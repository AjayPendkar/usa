// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/new_issue/new_issue_controller.dart';
import 'package:myrichardson/google_map_plug/google_maps_place_picker.dart';
import 'package:myrichardson/google_map_plug/providers/place_provider.dart';
import 'package:myrichardson/google_map_plug/providers/search_provider.dart';
import 'package:myrichardson/google_map_plug/src/components/prediction_tile.dart';
import 'package:myrichardson/google_map_plug/src/controllers/autocomplete_search_controller.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:myrichardson/model/google_map_model.dart';
import 'package:myrichardson/model/google_map_place_model.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:provider/provider.dart';

class AutoCompleteSearch extends StatefulWidget {
  final SearchProvider providerSearch;

  const AutoCompleteSearch(
      {Key? key,
      required this.sessionToken,
      required this.onPicked,
      required this.appBarKey,
      this.onPlacePicked,
      this.hintText,
      this.searchingText = AppStrings.map_searching,
      this.height = 40,
      this.contentPadding = EdgeInsets.zero,
      this.debounceMilliseconds,
      this.onSearchFailed,
      required this.searchBarController,
      this.autocompleteOffset,
      this.autocompleteRadius,
      this.autocompleteLanguage,
      this.autocompleteComponents,
      this.autocompleteTypes,
      this.strictbounds,
      this.newIssueController,
      this.region,
      this.initialSearchString,
      this.searchForInitialValue,
      this.autocompleteOnTrailingWhitespace,
      this.searchButtonTextStyle,
      this.searchAddress,
      this.hintTextStyle,
      required this.providerSearch})
      : super(key: key);

  final String? sessionToken;
  final TextStyle? searchButtonTextStyle;
  final TextStyle? hintTextStyle;
  final String? hintText;
  final String? searchingText;
  final String? searchAddress;
  final double height;
  final EdgeInsetsGeometry contentPadding;
  final int? debounceMilliseconds;
  final ValueChanged<Prediction> onPicked;
  final ValueChanged<Candidate>? onPlacePicked;
  final ValueChanged<String>? onSearchFailed;
  final SearchBarController searchBarController;
  final num? autocompleteOffset;
  final NewIssueController? newIssueController;
  final num? autocompleteRadius;
  final String? autocompleteLanguage;
  final List<String>? autocompleteTypes;
  final List<Component>? autocompleteComponents;
  final bool? strictbounds;
  final String? region;
  final GlobalKey appBarKey;
  final String? initialSearchString;
  final bool? searchForInitialValue;
  final bool? autocompleteOnTrailingWhitespace;

  @override
  AutoCompleteSearchState createState() => AutoCompleteSearchState();
}

class AutoCompleteSearchState extends State<AutoCompleteSearch> {
  FocusNode focus = FocusNode();
  OverlayEntry? overlayEntry;

  final newIssue = Get.put(NewIssueController());

  @override
  void initState() {
    widget.providerSearch.controller.text = widget.searchAddress ?? '';

    if (widget.initialSearchString != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.providerSearch.controller.text = widget.initialSearchString!;
        if (widget.searchForInitialValue!) {
          _onSearchInputChange();
        }
      });
    }
    widget.providerSearch.controller.addListener(_onSearchInputChange);
    focus.addListener(_onFocusChanged);

    widget.searchBarController.attach(this);
    super.initState();
  }

  @override
  void dispose() {
    widget.providerSearch.controller.removeListener(_onSearchInputChange);
    widget.providerSearch.controller.dispose();

    focus.removeListener(_onFocusChanged);
    focus.dispose();
    _clearOverlay();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewIssueController>(
      init: NewIssueController(),
      builder: (_) => ChangeNotifierProvider.value(
        value: widget.providerSearch,
        child: RoundedFrame(
          height: widget.height,
          padding: onlyPadding(right: 10),
          margin: onlyPadding(bottom: 10),
          borderRadius: BorderRadius.circular(3),
          elevation: 0.0,
          child: Row(
            children: <Widget>[
              horizontalSpace(10),
              Expanded(child: _buildSearchTextField(_.placeMap)),
              horizontalSpace(10),
              Text(
                AppStrings.map_search,
                style: widget.searchButtonTextStyle,
              ),
              horizontalSpace(10),
              _buildTextClearIcon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchTextField(PlaceMap? placeMap) {
    if (placeMap != null && placeMap.address != null) {
      widget.providerSearch.controller.text =
          placeMap.address!.street.toString();
      newIssue.placeMapA = placeMap;
      _clearOverlay();
    } else {
      // newIssue.placeMap = null;
    }
    return TextFormField(
      controller: widget.providerSearch.controller,
      focusNode: focus,
      onChanged: (val) {
        newIssue.isDisplayOverLay = true;
      },
      decoration: InputDecoration(
        hintText: AppStrings.enterSearch_map,
        hintStyle: widget.hintTextStyle,
        border: InputBorder.none,
        isDense: true,
        contentPadding: widget.contentPadding,
      ),
    );
  }

  Widget _buildTextClearIcon() {
    return Selector<SearchProvider, String>(
        selector: (_, provider) => provider.searchTerm,
        builder: (_, data, __) {
          if (data.length > 0) {
            return Padding(
              padding: onlyPadding(right: 8),
              child: GestureDetector(
                child: Icon(
                  Icons.clear,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColor.primaryWhite
                      : AppColor.primaryGrey,
                ),
                onTap: () {
                  clearText();
                },
              ),
            );
          } else {
            return horizontalSpace(10);
          }
        });
  }

  _onSearchInputChange() {
    if (!mounted) return;
    this.widget.providerSearch.searchTerm =
        widget.providerSearch.controller.text;

    PlaceProvider providerPlace = PlaceProvider.of(context, listen: false);

    if (widget.providerSearch.controller.text.isEmpty) {
      providerPlace.debounceTimer?.cancel();
      _searchPlace(widget.providerSearch.controller.text);
      return;
    }

    if (widget.providerSearch.controller.text.trim() ==
        this.widget.providerSearch.prevSearchTerm.trim()) {
      providerPlace.debounceTimer?.cancel();
      return;
    }

    if (!widget.autocompleteOnTrailingWhitespace! &&
        widget.providerSearch.controller.text
                .substring(widget.providerSearch.controller.text.length - 1) ==
            " ") {
      providerPlace.debounceTimer?.cancel();
      return;
    }

    if (providerPlace.debounceTimer?.isActive ?? false) {
      providerPlace.debounceTimer!.cancel();
    }

    providerPlace.debounceTimer =
        Timer(Duration(milliseconds: widget.debounceMilliseconds!), () {
      _searchPlace(widget.providerSearch.controller.text.trim());
    });
    //   newIssue.placeMap = null;
  }

  _onFocusChanged() {
    PlaceProvider provider = PlaceProvider.of(context, listen: false);
    provider.isSearchBarFocused = focus.hasFocus;
    provider.debounceTimer?.cancel();
    provider.placeSearchingState = SearchingState.Idle;
  }

  _searchPlace(String searchTerm) {
    if (context == null) return;

    _clearOverlay();

    if (searchTerm.length < 1) return;
    newIssue.placeMap = null;
    if (newIssue.isDisplayOverLay) {
      _displayOverlay(_buildSearchingOverlay());
      _performAutoCompleteSearch(searchTerm);
    }
  }

  _clearOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  _displayOverlay(Widget overlayChild) {
    _clearOverlay();

    final RenderBox? appBarRenderBox =
        widget.appBarKey.currentContext!.findRenderObject() as RenderBox?;
    final screenWidth = 100;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: appBarRenderBox!.size.height,
        left: screenWidth * 0.025,
        right: screenWidth * 0.025,
        child: Material(
          elevation: 4.0,
          child: Container(
              padding: onlyPadding(bottom: 150),
              height: Screen.screenHeight,
              child: overlayChild),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  Widget _buildSearchingOverlay() {
    return Padding(
      padding: symmetricPadding(vertical: 16, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(),
          ),
          horizontalSpace(24),
          Text(
            widget.searchingText ?? AppStrings.map_searching,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget _buildPredictionOverlay(
    List<Prediction> predictions,
    List<Candidate>? candidates,
  ) {
    return ListView.builder(
      physics: ScrollPhysics(),
      itemCount: predictions.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => PredictionTile(
        prediction: predictions[index],
        onTap: (selectedPrediction) {
          resetSearchBar();
          widget.onPicked(selectedPrediction);
          //  var index = predictions.indexOf(predictions);
          widget.onPlacePicked!(candidates![index]);
          widget.providerSearch.controller.text =
              '${candidates[index].address ?? ''}';
          widget.providerSearch.addressText = widget.providerSearch
              .addressAutoComplete(candidates[index].address!);
          widget.providerSearch.searchTerm = candidates[index].address!;
          newIssue.candidate = candidates[index];
          widget.providerSearch.prevSearchTerm = candidates[index].address!;
          _clearOverlay();
        },
      ),
    );
  }

  _performAutoCompleteSearch(String searchTerm) async {
    if (searchTerm.isNotEmpty) {
      final PlacesAutocompleteResponse response =
          await newIssue.getAddress(searchTerm);
      AppPreference.set(AppStrings.map_search_place, "search");

      if (response.errorMessage?.isNotEmpty == true ||
          response.status == "REQUEST_DENIED") {
        if (widget.onSearchFailed != null) {
          widget.onSearchFailed!(response.status);
        }
        return;
      }

      if (this.widget.providerSearch.prevSearchTerm == searchTerm &&
          this.widget.providerSearch.prevSearchTerm.isNotEmpty) {
        response.predictions.clear();
      }
      _displayOverlay(_buildPredictionOverlay(
          response.predictions, newIssue.addR!.candidates));
    }
  }

  clearText() {
    newIssue.placeMap = null;
    widget.providerSearch.searchTerm = "";
    widget.providerSearch.controller.clear();
  }

  resetSearchBar() {
    focus.unfocus();
  }

  clearOverlay() {
    _clearOverlay();
  }
}

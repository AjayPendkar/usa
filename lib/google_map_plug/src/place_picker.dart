import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myrichardson/controller/new_issue/new_issue_controller.dart';
import 'package:myrichardson/google_map_plug/google_maps_place_picker.dart';
import 'package:myrichardson/google_map_plug/providers/place_provider.dart';
import 'package:myrichardson/google_map_plug/providers/search_provider.dart';
import 'package:myrichardson/google_map_plug/src/autocomplete_search.dart';
import 'package:myrichardson/google_map_plug/src/controllers/autocomplete_search_controller.dart';
import 'package:myrichardson/google_map_plug/src/google_map_place_picker.dart';
import 'package:myrichardson/google_map_plug/src/utils/uuid.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart';
import 'package:myrichardson/model/google_map_model.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/new_issue/new_issue_screen.dart';
import 'package:provider/provider.dart';

enum PinState { Preparing, Idle, Dragging }

enum SearchingState { Idle, Searching }

class MapScreen extends StatefulWidget {
  MapScreen({
    Key? key,
    required this.apiKey,
    this.onPlacePicked,
    required this.initialPosition,
    this.useCurrentLocation,
    this.desiredLocationAccuracy = LocationAccuracy.high,
    this.onMapCreated,
    this.hintText,
    this.searchingText,
    this.onAutoCompleteFailed,
    this.onGeocodingSearchFailed,
    this.proxyBaseUrl,
    this.httpClient,
    this.selectedPlaceWidgetBuilder,
    this.pinBuilder,
    this.autoCompleteDebounceInMilliseconds = 500,
    this.cameraMoveDebounceInMilliseconds = 750,
    this.initialMapType = MapType.normal,
    this.enableMapTypeButton = true,
    this.enableMyLocationButton = true,
    this.myLocationButtonCooldown = 10,
    this.usePinPointingSearch = true,
    this.usePlaceDetailSearch = false,
    this.autocompleteOffset,
    this.autocompleteRadius,
    this.autocompleteLanguage,
    this.autocompleteComponents,
    this.autocompleteTypes,
    this.strictbounds,
    this.region,
    this.selectInitialPosition = false,
    this.resizeToAvoidBottomInset = true,
    this.initialSearchString,
    this.searchForInitialValue = false,
    this.forceAndroidLocationManager = false,
    this.forceSearchOnZoomChanged = false,
    this.automaticallyImplyAppBarLeading = true,
    this.autocompleteOnTrailingWhitespace = false,
    this.hidePlaceDetailsWhenDraggingPin = true,
    this.backgroundColor = Colors.indigo,
    this.actionButtonTextStyle,
    this.searchButtonTextStyle,
    this.hintTextStyle,
  }) : super(key: key);

  final String apiKey;

  final LatLng initialPosition;
  final bool? useCurrentLocation;
  final LocationAccuracy desiredLocationAccuracy;

  final MapCreatedCallback? onMapCreated;

  final String? hintText;
  final String? searchingText;
  final TextStyle? actionButtonTextStyle;

  final ValueChanged<String>? onAutoCompleteFailed;
  final ValueChanged<String>? onGeocodingSearchFailed;
  final int autoCompleteDebounceInMilliseconds;
  final int cameraMoveDebounceInMilliseconds;

  final MapType initialMapType;
  final bool enableMapTypeButton;
  final bool enableMyLocationButton;
  final int myLocationButtonCooldown;
  final TextStyle? searchButtonTextStyle;
  final TextStyle? hintTextStyle;
  final bool usePinPointingSearch;
  final bool usePlaceDetailSearch;

  final num? autocompleteOffset;
  final num? autocompleteRadius;
  final String? autocompleteLanguage;
  final List<String>? autocompleteTypes;
  final List<Component>? autocompleteComponents;
  final bool? strictbounds;
  final String? region;

  final bool resizeToAvoidBottomInset;
  final bool selectInitialPosition;

  final ValueChanged<PickResult>? onPlacePicked;
  final SelectedPlaceWidgetBuilder? selectedPlaceWidgetBuilder;
  final PinBuilder? pinBuilder;
  final String? proxyBaseUrl;
  final BaseClient? httpClient;
  final String? initialSearchString;
  final bool searchForInitialValue;

  final bool forceAndroidLocationManager;
  final bool forceSearchOnZoomChanged;
  final bool automaticallyImplyAppBarLeading;
  final bool autocompleteOnTrailingWhitespace;
  final bool hidePlaceDetailsWhenDraggingPin;
  final Color backgroundColor;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GlobalKey appBarKey = GlobalKey();
  Future<PlaceProvider>? _futureProvider;
  PlaceProvider? provider;
  SearchBarController searchBarController = SearchBarController();
  NewIssueController newIssueController = Get.put(NewIssueController());

  LatLng defaultLatLng = LatLng(32.95971, -96.73099);
  @override
  void initState() {
    super.initState();
    _futureProvider = _initPlaceProvider();
  }

  @override
  void dispose() {
    searchBarController.dispose();

    super.dispose();
  }

  setMarker(LatLng latLng) {
    newIssue.markers.clear();
    newIssue.markers
        .add(Marker(markerId: MarkerId("selected-location"), position: latLng));
    newIssue.onUpdate();
  }

  BitmapDescriptor? customIcon1;

  Future<PlaceProvider> _initPlaceProvider() async {
    final headers = await GoogleApiHeaders().getHeaders();
    final provider = PlaceProvider(
      widget.apiKey,
      widget.proxyBaseUrl,
      widget.httpClient,
      headers,
    );
    provider.sessionToken = Uuid().generateV4();
    provider.desiredAccuracy = widget.desiredLocationAccuracy;
    provider.setMapType(widget.initialMapType);

    return provider;
  }

  SearchProvider providerSearch = SearchProvider();
  final newIssue = Get.put(NewIssueController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        searchBarController.clearOverlay();
        return Future.value(true);
      },
      child: FutureBuilder<PlaceProvider>(
        future: _futureProvider,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            provider = snapshot.data;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<PlaceProvider>.value(value: provider!),
              ],
              child: Scaffold(
                key: ValueKey<int>(provider.hashCode),
                resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  leading: InkWell(
                      onTap: () {
                        print("InkWell called");
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back)),
                  key: appBarKey,
                  actions: [
                    Center(
                        child: Padding(
                      padding: onlyPadding(right: 15),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => NewIssueScreen(),
                              arguments: AppPreference.getString(
                                          AppStrings.map_search_place) ==
                                      "search"
                                  ? newIssue.candidate
                                  : newIssue.placeMapA);
                        },
                        child: Text(
                          AppStrings.save_,
                          style: widget.actionButtonTextStyle,
                        ),
                      ),
                    ))
                  ],
                  automaticallyImplyLeading: true,
                  elevation: 0,
                  backgroundColor: widget.backgroundColor,
                  centerTitle: true,
                  titleTextStyle: TextStyle(fontSize: 18),
                  bottom: PreferredSize(
                      preferredSize: Size.fromHeight(70.0),
                      child: _buildSearchBar(context)),
                  title: Text(AppStrings.Location),
                ),
                body: _buildMapWithLocation(),
              ),
            );
          }

          final children = <Widget>[];
          if (snapshot.hasError) {
            children.addAll([
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.error,
              ),
              Padding(
                padding: onlyPadding(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ]);
          } else {
            children.add(CircularProgressIndicator());
          }

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15),
        Expanded(
          child: GetBuilder<NewIssueController>(
            init: NewIssueController(),
            builder: (_) => AutoCompleteSearch(
                providerSearch: providerSearch,
                appBarKey: appBarKey,
                height: 50,
                hintTextStyle: widget.hintTextStyle,
                searchButtonTextStyle: widget.searchButtonTextStyle,
                searchBarController: searchBarController,
                sessionToken: provider!.sessionToken,
                hintText: widget.hintText,
                searchingText: widget.searchingText,
                debounceMilliseconds: widget.autoCompleteDebounceInMilliseconds,
                onPicked: (prediction) {
                  // _pickPrediction(prediction);
                },
                searchAddress: add,
                onPlacePicked: (candidate) {
                  _pickPrediction(candidate);
                },
                onSearchFailed: (status) {
                  if (widget.onAutoCompleteFailed != null) {
                    widget.onAutoCompleteFailed!(status);
                  }
                },
                autocompleteOffset: widget.autocompleteOffset,
                autocompleteRadius: widget.autocompleteRadius,
                autocompleteLanguage: widget.autocompleteLanguage,
                autocompleteComponents: widget.autocompleteComponents,
                autocompleteTypes: widget.autocompleteTypes,
                strictbounds: widget.strictbounds,
                region: widget.region,
                initialSearchString: widget.initialSearchString,
                searchForInitialValue: widget.searchForInitialValue,
                autocompleteOnTrailingWhitespace:
                    widget.autocompleteOnTrailingWhitespace),
          ),
        ),
        horizontalSpace(5),
      ],
    );
  }

  /* predictionPick(Prediction prediction) async {
    provider!.placeSearchingState = SearchingState.Searching;

    final PlacesDetailsResponse response =
        await provider!.places.getDetailsByPlaceId(
      prediction.placeId!,
      sessionToken: provider!.sessionToken,
      language: widget.autocompleteLanguage,
    );

    if (response.errorMessage?.isNotEmpty == true ||
        response.status == "REQUEST_DENIED") {
      if (widget.onAutoCompleteFailed != null) {
        widget.onAutoCompleteFailed!(response.status);
      }
      return;
    }

    provider!.selectedPlace = PickResult.fromPlaceDetailResult(response.result);

    provider!.isAutoCompleteSearching = true;

    await _moveTo(provider!.selectedPlace!.geometry!.location.lat,
        provider!.selectedPlace!.geometry!.location.lng);

    provider!.placeSearchingState = SearchingState.Idle;
  }*/

  _moveTo(double? latitude, double? longitude) async {
    GoogleMapController? controller = provider!.mapController;
    if (controller == null) return;
    if (latitude == null || longitude == null) {
      return;
    }
    setMarker(
      LatLng(latitude, longitude),
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 16,
        ),
      ),
    );
  }

  String? add;

  _pickPrediction(Candidate candidates) async {
    provider!.placeSearchingState = SearchingState.Searching;
    final PlacesAutocompleteResponse response =
        await NewIssueController().getAddress(candidates.address!);
    add = candidates.address;

    if (response.errorMessage?.isNotEmpty == true ||
        response.status == "REQUEST_DENIED") {
      if (widget.onAutoCompleteFailed != null) {
        widget.onAutoCompleteFailed!(response.status);
      }
      return;
    }

    provider!.isAutoCompleteSearching = true;

    await _moveTo(candidates.location!.y, candidates.location!.x);
    provider!.placeSearchingState = SearchingState.Idle;
  }

  _moveToCurrentPosition() async {
    if (provider!.currentPosition != null) {
      await _moveTo(provider!.currentPosition!.latitude,
          provider!.currentPosition!.longitude);
      newIssueController.onTapSetMarker(LatLng(
          provider!.currentPosition!.latitude,
          provider!.currentPosition!.longitude));
    } else {
      await _moveTo(defaultLatLng.latitude, defaultLatLng.longitude);
      newIssueController.onTapSetMarker(
          LatLng(defaultLatLng.latitude, defaultLatLng.longitude));
    }
  }

  Widget _buildMapWithLocation() {
    if (widget.useCurrentLocation != null && widget.useCurrentLocation!) {
      return FutureBuilder(
          future: provider!
              .updateCurrentLocation(widget.forceAndroidLocationManager),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (provider!.currentPosition == null) {
                return _buildMap(widget.initialPosition);
              } else {
                return _buildMap(LatLng(provider!.currentPosition!.latitude,
                    provider!.currentPosition!.longitude));
              }
            }
          });
    } else {
      return FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 1)),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildMap(widget.initialPosition);
          }
        },
      );
    }
  }

  Widget _buildMap(LatLng initialTarget) {
    return GoogleMapPlacePicker(
      initialTarget: initialTarget,
      appBarKey: appBarKey,
      selectedPlaceWidgetBuilder: widget.selectedPlaceWidgetBuilder,
      pinBuilder: widget.pinBuilder,
      onSearchFailed: widget.onGeocodingSearchFailed,
      debounceMilliseconds: widget.cameraMoveDebounceInMilliseconds,
      enableMapTypeButton: widget.enableMapTypeButton,
      enableMyLocationButton: widget.enableMyLocationButton,
      usePinPointingSearch: widget.usePinPointingSearch,
      usePlaceDetailSearch: widget.usePlaceDetailSearch,
      onMapCreated: (controller) {
        if (widget.onMapCreated != null) widget.onMapCreated!(controller);
        _moveToCurrentPosition();
      },
      selectInitialPosition: widget.selectInitialPosition,
      language: widget.autocompleteLanguage,
      forceSearchOnZoomChanged: widget.forceSearchOnZoomChanged,
      hidePlaceDetailsWhenDraggingPin: widget.hidePlaceDetailsWhenDraggingPin,
      onToggleMapType: () {
        provider!.switchMapType();
      },
      onMyLocation: () async {
        if (provider!.isOnUpdateLocationCooldown == false) {
          provider!.isOnUpdateLocationCooldown = true;
          Timer(Duration(seconds: widget.myLocationButtonCooldown), () {
            provider!.isOnUpdateLocationCooldown = false;
          });
          await provider!
              .updateCurrentLocation(widget.forceAndroidLocationManager);
          await _moveToCurrentPosition();
        }
      },
      onMoveStart: () {
        searchBarController.reset();
      },
      onPlacePicked: widget.onPlacePicked,
    );
  }
}

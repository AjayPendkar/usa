// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myrichardson/controller/new_issue/new_issue_controller.dart';
import 'package:myrichardson/google_map_plug/google_maps_place_picker.dart';
import 'package:myrichardson/google_map_plug/providers/place_provider.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

typedef SelectedPlaceWidgetBuilder = Widget Function(
  BuildContext context,
  PickResult? selectedPlace,
  SearchingState state,
  bool isSearchBarFocused,
);

typedef PinBuilder = Widget Function(
  BuildContext context,
  PinState state,
);

class GoogleMapPlacePicker extends StatelessWidget {
  GoogleMapPlacePicker({
    Key? key,
    required this.initialTarget,
    required this.appBarKey,
    this.selectedPlaceWidgetBuilder,
    this.pinBuilder,
    this.onSearchFailed,
    this.onMoveStart,
    this.onMapCreated,
    this.debounceMilliseconds,
    this.enableMapTypeButton,
    this.enableMyLocationButton,
    this.onToggleMapType,
    this.onMyLocation,
    this.onPlacePicked,
    this.usePinPointingSearch,
    this.usePlaceDetailSearch,
    this.selectInitialPosition,
    this.language,
    this.forceSearchOnZoomChanged,
    this.hidePlaceDetailsWhenDraggingPin,
  }) : super(key: key);

  final LatLng initialTarget;
  final GlobalKey appBarKey;

  final SelectedPlaceWidgetBuilder? selectedPlaceWidgetBuilder;
  final PinBuilder? pinBuilder;

  final ValueChanged<String>? onSearchFailed;
  final VoidCallback? onMoveStart;
  final MapCreatedCallback? onMapCreated;
  final VoidCallback? onToggleMapType;
  final VoidCallback? onMyLocation;
  final ValueChanged<PickResult>? onPlacePicked;

  final int? debounceMilliseconds;
  final bool? enableMapTypeButton;
  final bool? enableMyLocationButton;

  final bool? usePinPointingSearch;
  final bool? usePlaceDetailSearch;

  final bool? selectInitialPosition;

  final String? language;

  final bool? forceSearchOnZoomChanged;
  final bool? hidePlaceDetailsWhenDraggingPin;

  _searchByCameraLocation(PlaceProvider provider) async {
    if (forceSearchOnZoomChanged == false &&
        provider.prevCameraPosition != null &&
        provider.prevCameraPosition!.target.latitude ==
            provider.cameraPosition!.target.latitude &&
        provider.prevCameraPosition!.target.longitude ==
            provider.cameraPosition!.target.longitude) {
      provider.placeSearchingState = SearchingState.Idle;
      return;
    }

    provider.placeSearchingState = SearchingState.Searching;

    final GeocodingResponse response =
        await provider.geocoding.searchByLocation(
      Location(
          lat: provider.cameraPosition!.target.latitude,
          lng: provider.cameraPosition!.target.longitude),
      language: language,
    );

    if (response.errorMessage?.isNotEmpty == true ||
        response.status == "REQUEST_DENIED") {
      if (onSearchFailed != null) {
        onSearchFailed!(response.status);
      }
      provider.placeSearchingState = SearchingState.Idle;
      return;
    }

    if (usePlaceDetailSearch!) {
      final PlacesDetailsResponse detailResponse =
          await provider.places.getDetailsByPlaceId(
        response.results[0].placeId,
        language: language,
      );
      if (detailResponse.errorMessage?.isNotEmpty == true ||
          detailResponse.status == "REQUEST_DENIED") {
        if (onSearchFailed != null) {
          onSearchFailed!(detailResponse.status);
        }
        provider.placeSearchingState = SearchingState.Idle;
        return;
      }

      provider.selectedPlace =
          PickResult.fromPlaceDetailResult(detailResponse.result);
    } else {
      provider.selectedPlace =
          PickResult.fromGeocodingResult(response.results[0]);
    }
    provider.placeSearchingState = SearchingState.Idle;
  }

  final NewIssueController newIssueController = Get.put(NewIssueController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildGoogleMap(context),
        _buildFloatingCard(),
        _buildMapIcons(context),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Selector<PlaceProvider, MapType>(
        selector: (_, provider) => provider.mapType,
        builder: (_, data, __) {
          PlaceProvider provider = PlaceProvider.of(context, listen: false);
          CameraPosition initialCameraPosition = CameraPosition(
              target: LatLng(32.978087541002026, -96.76065668463707), zoom: 16);
          return GetBuilder<NewIssueController>(
            init: NewIssueController(),
            builder: (_) => GoogleMap(
              markers: _.markers,
              myLocationButtonEnabled: false,
              compassEnabled: false,
              mapToolbarEnabled: false,
              initialCameraPosition: initialCameraPosition,
              mapType: data,
              myLocationEnabled: true,
              onTap: newIssueController.onTapSetMarker,
              onMapCreated: (GoogleMapController controller) {
                provider.mapController = controller;
                provider.setCameraPosition(null);
                provider.pinState = PinState.Idle;
                if (selectInitialPosition!) {
                  provider.setCameraPosition(initialCameraPosition);
                  _searchByCameraLocation(provider);
                }
                onMapCreated!(controller);
              },
              onCameraIdle: () {
                if (provider.isAutoCompleteSearching) {
                  provider.isAutoCompleteSearching = false;
                  provider.pinState = PinState.Idle;
                  provider.placeSearchingState = SearchingState.Idle;
                  return;
                }
                if (usePinPointingSearch!) {
                  if (provider.pinState == PinState.Dragging) {
                    if (provider.debounceTimer?.isActive ?? false) {
                      provider.debounceTimer!.cancel();
                    }
                    provider.debounceTimer = Timer(
                        Duration(milliseconds: debounceMilliseconds!), () {
                      _searchByCameraLocation(provider);
                    });
                  }
                }
                provider.pinState = PinState.Idle;
              },
              onCameraMoveStarted: () {
                provider.setPrevCameraPosition(provider.cameraPosition);
                provider.debounceTimer?.cancel();
                provider.pinState = PinState.Dragging;
                if (this.hidePlaceDetailsWhenDraggingPin!) {
                  provider.placeSearchingState = SearchingState.Searching;
                }
                onMoveStart!();
              },
              onCameraMove: (CameraPosition position) {
                provider.setCameraPosition(position);
              },
              gestureRecognizers: Set()
                ..add(Factory<EagerGestureRecognizer>(
                    () => EagerGestureRecognizer())),
            ),
          );
        });
  }

  Widget _buildFloatingCard() {
    return Selector<PlaceProvider,
        Tuple4<PickResult?, SearchingState, bool, PinState>>(
      selector: (_, provider) => Tuple4(
          provider.selectedPlace,
          provider.placeSearchingState,
          provider.isSearchBarFocused,
          provider.pinState),
      builder: (context, data, __) {
        if ((data.item1 == null && data.item2 == SearchingState.Idle) ||
            data.item3 == true ||
            data.item4 == PinState.Dragging &&
                this.hidePlaceDetailsWhenDraggingPin!) {
          return Container();
        } else {
          if (selectedPlaceWidgetBuilder == null) {
            return _defaultPlaceWidgetBuilder(context, data.item1, data.item2);
          } else {
            return Builder(
                builder: (builderContext) => selectedPlaceWidgetBuilder!(
                    builderContext, data.item1, data.item2, data.item3));
          }
        }
      },
    );
  }

  Widget _defaultPlaceWidgetBuilder(
      BuildContext context, PickResult? data, SearchingState state) {
    return FloatingCard(
      bottomPosition: MediaQuery.of(context).size.height * 0.05,
      leftPosition: MediaQuery.of(context).size.width * 0.025,
      rightPosition: MediaQuery.of(context).size.width * 0.025,
      width: MediaQuery.of(context).size.width * 0.9,
      borderRadius: BorderRadius.circular(12.0),
      elevation: 4.0,
      color: Theme.of(context).cardColor,
      child: state == SearchingState.Searching
          ? _buildLoadingIndicator()
          : _buildSelectionDetails(context, data!),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      height: 48,
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildSelectionDetails(BuildContext context, PickResult result) {
    return Container(
      margin: AppTextStyle.appAllPadding10,
      child: Column(
        children: <Widget>[
          Text(
            result.formattedAddress!,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          verticalSpace(10),
          MaterialButton(
            padding: symmetricPadding(vertical: 10, horizontal: 15),
            child: Text(
              AppStrings.select_here,
              style: TextStyle(fontSize: 16),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            onPressed: () {
              onPlacePicked!(result);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMapIcons(BuildContext context) {
    final RenderBox appBarRenderBox =
        appBarKey.currentContext!.findRenderObject() as RenderBox;

    return Positioned(
      top: appBarRenderBox.size.height,
      right: 15,
      child: Column(
        children: <Widget>[
          enableMapTypeButton!
              ? Container(
                  width: 35,
                  height: 35,
                  child: RawMaterialButton(
                    shape: CircleBorder(),
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? AppColor.black54
                        : AppColor.primaryWhite,
                    elevation: 8.0,
                    onPressed: onToggleMapType,
                    child: Icon(Icons.layers),
                  ),
                )
              : Container(),
          verticalSpace(10),
          enableMyLocationButton!
              ? Container(
                  width: 35,
                  height: 35,
                  child: RawMaterialButton(
                    shape: CircleBorder(),
                    fillColor: Theme.of(context).brightness == Brightness.dark
                        ? AppColor.black54
                        : AppColor.primaryWhite,
                    elevation: 8.0,
                    onPressed: onMyLocation,
                    child: Icon(Icons.my_location),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

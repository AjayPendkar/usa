import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myrichardson/constants/colors_constant.dart';
import 'package:myrichardson/constants/strings_constatnt.dart';
import 'package:myrichardson/constants/text_style_constatnt.dart';
import 'package:myrichardson/controller/dioController.dart';
import 'package:myrichardson/google_map_plug/google_maps_place_picker.dart';
import 'package:myrichardson/google_map_plug/providers/place_provider.dart';
import 'package:myrichardson/model/google_map_model.dart' as map;
import 'package:myrichardson/model/google_map_place_model.dart';
import 'package:myrichardson/model/issue_type_model.dart';
import 'package:myrichardson/model/issuetype_submit_model.dart';
import 'package:myrichardson/utils/loader.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';

import '../../main.dart';

class NewIssueController extends GetxController {
  final imagePicker = ImagePicker();
  File? file;
  String? img64;
  PickResult? selectedPlace;
  static final kInitialPosition =
      LatLng(32.978087541002026, -96.76065668463707);
  IssueType? selectedSalutation;
  bool autoValidate = false;
  bool isLoading = false;

  String? selectedIssueType;
  String? selectedIssueTypeId;

  bool isDisplayOverLay = true;
  PlaceProvider? provider;
  String? description, dropdown, location;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  onClick() {
    autoValidate = true;
    update();
  }

  getIssueType(IssueType value) {
    selectedSalutation = value;
    update();
  }

  onUpdate() {
    update();
  }

  void openGallery() async {
    final image = await imagePicker.getImage(
        source: ImageSource.gallery,
        maxHeight: 1024,
        maxWidth: 1024,
        imageQuality: 70);

    if (image != null) {
      file = File(image.path);
      update();
      final bytes = file!.readAsBytesSync();
      img64 = base64Encode(bytes);
    } else {}
  }

  Future<void> openCamera() async {
    final image = await imagePicker.getImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxHeight: 1024,
        maxWidth: 1024);
    if (image != null) {
      file = File(image.path);
      update();
      final bytes = file!.readAsBytesSync();
      img64 = base64Encode(bytes);
    } else {}
  }

  @override
  void onInit() {
    getIssuType();
    super.onInit();
  }

  final Set<Marker> markers = Set();

  List<IssueType> issueTypeList = [];

  void getIssuType() async {
    try {
      final response = await DioApiClient().dio!.get(issueTypeEndPoint);
      for (int i = 0; i < response.data.length; i++) {
        issueTypeList.add(IssueType.fromJson(response.data[i]));
      }
    } catch (exception) {}
    update();
  }

  Map<String, String> issuesTypesMap = HashMap();

  Future<List<String>> getIssuTypeFuture() async {
    try {
      final response = await DioApiClient().dio!.get(issueTypeEndPoint);
      for (int i = 0; i < response.data.length; i++) {
        issueTypeList.add(IssueType.fromJson(response.data[i]));
      }
      int i = 0;
      List<String> arr = [];
      issuesTypesMap.clear();
      while (i < issueTypeList.length) {
        // var currentElement = _.issueTypeList[i];
        arr.add(issueTypeList[i].issueType as String);

        issuesTypesMap[issueTypeList[i].issueType as String] =
            issueTypeList[i].issueUnid as String;

        i++;
      }

      // update();
      return arr.toSet().toList();
    } catch (exception) {
      return [];
    }
  }

  IssueSubmit? issueSubmit = IssueSubmit();

  Future<void> getIssueSubmit() async {
    issueSubmit = IssueSubmit(
      testPhoto: TestPhoto(
        type: AppStrings.multiPart,
        content: [
          Content(
              data: img64,
              contentDisposition: AppStrings.inline,
              boundary: AppStrings.photoBoundary,
              contentTransferEncoding: AppStrings.bit,
              contentType: AppStrings.contentType)
        ],
      ),
      email: AppPreference.getString(AppStrings.email),
      name: AppPreference.getString(AppStrings.name),
      phone: AppPreference.getString(AppStrings.phone),
      comments: descriptionController.text.trim(),
      // issueType: selectedSalutation!.issueType,
      // issueUnid: selectedSalutation!.issueUnid,
      issueType: selectedIssueType,
      issueUnid: selectedIssueTypeId,
      issueAddress:
          AppPreference.getString(AppStrings.map_search_place) == "search"
              ? candidate!.address
              : placeMapA?.address?.street,
      issueLocationX:
          AppPreference.getString(AppStrings.map_search_place) == "search"
              ? candidate!.location!.y.toString()
              : placeMapA?.location?.y.toString(),
      issueLocationY:
          AppPreference.getString(AppStrings.map_search_place) == "search"
              ? candidate!.location!.x.toString()
              : placeMapA?.location?.x.toString(),
    );

    showLoadingIndicator();
    Dio? dio = DioApiClient().dio!;
    dio.options.contentType = 'application/json';
    dio.options.headers['Content-Type'] = 'application/json';
    await dio.post(issueSubmitEndPoint,
        data: img64 != null
            ? jsonEncode(issueSubmit!.toJson())
            : jsonEncode(issueSubmit!.toJsonimage()));
    hideLoadingIndicator();
  }

  map.Address? addR;

  Future<PlacesAutocompleteResponse> getAddress(String searchDate) async {
    Map<String, dynamic> paramters = {
      AppStrings.street: searchDate,
      AppStrings.outsr: 4326,
      AppStrings.f: 'json'
    };

    final response = await DioApiClient()
        .dio!
        .get(DioApiClient.baseUrlSearchMap, queryParameters: paramters);
    log("url : " + DioApiClient.baseUrlSearchMap.toString());
    log("queryParameters : " + paramters.toString());
    log("statusCode : " + response.statusCode.toString());
    log("data : " + response.data.toString());

    List<Prediction> predication = [];
    addR = map.Address.fromJson(response.data);

    candidateAddress = addR!.candidates!;
    for (int i = 0; i < addR!.candidates!.length; i++) {
      map.Candidate candi = addR!.candidates![i];
      predication.add(
        Prediction(
            description: candi.address,
            id: null,
            terms: <Term>[Term(offset: 0, value: '')],
            distanceMeters: null,
            placeId: '$i',
            types: <String>['locality', 'political', 'geocode'],
            matchedSubstrings: <MatchedSubstring>[
              MatchedSubstring(offset: 0, length: 0)
            ]),
      );
    }

    PlacesAutocompleteResponse placeResponse = PlacesAutocompleteResponse(
      status: 'Ok',
      errorMessage: '',
      predictions: predication,
    );

    return placeResponse;
  }

  map.Candidate? candidate;
  List<map.Candidate>? candidateAddres = [];

  List<map.Candidate>? get candidateAddress => candidateAddres;

  set candidateAddress(List<map.Candidate>? candidate) {
    candidateAddres = candidate;
    update();
  }

  PlaceMap? placeMap;
  PlaceMap? placeMapA;

  getPlaceAddress({lat, wkd, lng}) async {
    Map<String, dynamic> mapPerameter = {
      AppStrings.distance: 200,
      AppStrings.outsr: 4326,
      AppStrings.f_pjson: "pjson",
      AppStrings.perameter_location:
          "{\"x\": \"$lng\",\"y\": \"$lat\",\"spatialReference\": {\"wkid\": 4326}}"
    };

    final response = await DioApiClient()
        .dio!
        .get(DioApiClient.baseUrlPlaceMap, queryParameters: mapPerameter);

    if (response.statusCode == 200) {
      SnackBar(
        content: Text("Not Eklendi"),
        duration: Duration(seconds: 2),
      );

      final data = json.decode(response.data);
      if (data["address"] != null) {
        SnackBar(
          content: Text("Not Eklendi"),
          duration: Duration(seconds: 2),
        );

        placeMap = PlaceMap.fromJson(data);
        update();
      } else {
        showMyDialog();
      }
    }
  }

  void showMyDialog() {
    showDialog(
        barrierDismissible: false,
        context: navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
              title:
                  Text('Please select an address within the Richardson city'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Close"))
              ],
            )
        // builder: (context) => Center(
        //       child: Material(
        //         color: Colors.transparent,
        //         child: Text('Please enter an address in the Richardson city'),
        //       ),
        //     )
        );
  }

  openMap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return MapScreen(
          searchButtonTextStyle: AppTextStyle.robotoMedium(
            fontSize: 15,
            color: AppColor.darkBlueColor,
          ),
          hintTextStyle: AppTextStyle.robotoRegular(
              fontSize: 15, color: AppColor.greyTextColor),
          actionButtonTextStyle: AppTextStyle.robotoRegular(
              fontSize: 15, color: AppColor.primaryWhite),
          backgroundColor: AppColor.themeColor,
          apiKey: AppStrings.apiKey,
          initialPosition: kInitialPosition,
          usePinPointingSearch: true,
          useCurrentLocation: true,
          selectInitialPosition: true,
          onPlacePicked: (result) {
            selectedPlace = result;
            Navigator.of(context).pop();
            update();
          },
          forceSearchOnZoomChanged: true,
          usePlaceDetailSearch: true,
          automaticallyImplyAppBarLeading: false,
          selectedPlaceWidgetBuilder:
              (_, selectedPlace, state, isSearchBarFocused) {
            return isSearchBarFocused
                ? Container()
                : FloatingCard(
                    bottomPosition: 30.0,
                    leftPosition: 0.0,
                    rightPosition: 0.0,
                    width: 500,
                    borderRadius: BorderRadius.circular(12.0),
                  );
          },
          pinBuilder: (context, state) {
            if (state == PinState.Idle) {
              return Icon(Icons.location_on_outlined);
            } else {
              return Icon(Icons.location_on);
            }
          },
        );
      },
    ));
  }

  onTapSetMarker(LatLng point) {
    try {
      markers.clear();
      markers.add(Marker(
        markerId: MarkerId('1'),
        position: point,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
      onUpdate();
      AppPreference.set(AppStrings.map_search_place, "onClick");
      isDisplayOverLay = false;
      getPlaceAddress(lng: point.longitude, lat: point.latitude);
    } catch (e) {
      log("onTapSetMarker exp ${e.toString()}");
    }
  }
}

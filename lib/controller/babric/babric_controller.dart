import 'package:flutter/cupertino.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/dioController.dart';
import 'package:myrichardson/model/babric/babric_model.dart';
import 'package:myrichardson/model/babric/babric_model_data.dart';
import 'package:myrichardson/model/address_model.dart';
import 'package:myrichardson/model/babric/babric_submit_model.dart';
import 'package:myrichardson/routes/app_routes.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';

class BBICController extends GetxController {
  String? name, email, phone, address, comment;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController controller = TextEditingController();

  late List<BABICNonCompostableRequest> babicNonCompostableList;
  late List<BABICCompostable> babicCompostableList;

  bool selectedValue = false;

  @override
  void onInit() {
    preLoadData();
    PhoneInputFormatter.replacePhoneMask(
      countryCode: 'US',
      newMask: '+0 (000) 000 00 00',
    );
    phoneController.text = AppPreference.getString(AppStrings.phone) ?? '';
    nameController.text = AppPreference.getString(AppStrings.name) ?? '';
    emailController.text = AppPreference.getString(AppStrings.email) ?? '';
    super.onInit();
  }

  checkValNonCompostable(bool val, int index) {
    babicNonCompostableList[index].isChecked = val;
    update();
  }

  checkValCompostable(bool val, int index) {
    babicCompostableList[index].isCheck = val;
    update();
  }

  preLoadData() {
    babicCompostableList = [];

    babicCompostableData.forEach((element) {
      babicCompostableList.add(BABICCompostable(
        materialType: element.materialType,
        description: element.description,
        isCheck: element.isCheck ?? false ? false : false,
        title: element.title,
      ));
    });

    babicNonCompostableList = [];
    babicNonCompostableData.forEach((element) {
      babicNonCompostableList.add(BABICNonCompostableRequest(
        materialType: element.materialType,
        description: element.description,
        isChecked: element.isChecked ?? false ? false : false,
        title: element.title,
      ));
    });

    update();
  }

  onSave() {
    selectedValue = true;
    update();
  }

  Babic? babic;

  Address? selectAddress;

  Future<void> getBabric() async {
    List selectedCompostable = [];

    /// checking atleast one check box selected or not
    if (babicCompostableList
        .where((element) => element.isCheck == true)
        .toList()
        .isEmpty) {
      msgInToast(
          msg: AppStrings.selectAtleastOneCompostableMaterialCategories,
          gravity: ToastGravity.BOTTOM);
      return null;
    }

    if (babicNonCompostableList
        .where((element) => element.isChecked == true)
        .toList()
        .isEmpty) {
      msgInToast(
          msg: AppStrings.selectAtleastOneNonCompostableMaterialCategories,
          gravity: ToastGravity.BOTTOM);
      return null;
    }

    for (var item in babicCompostableList) {
      if (item.isCheck!) {
        selectedCompostable.add(item.materialType);
      }
    }
    for (var item in babicNonCompostableList) {
      if (item.isChecked!) {
        selectedCompostable.add(item.materialType);
      }
    }

    Map<String, dynamic> paramters = {
      AppStrings.OpenAgent: "",
      AppStrings.perameter_name: nameController.text.trim(),
      AppStrings.perameter_email: emailController.text.trim(),
      AppStrings.perameter_phone: phoneController.text.trim(),
      AppStrings.comment_perameter: commentController.text.trim(),
      AppStrings.perameter_address: selectAddress?.fullStreetAddress!.trim() ??
          addressController.text.trim(),
      AppStrings.perameter_taxName: selectAddress?.taxOwnerName!.trim() ??
          AppPreference.getString(AppStrings.textOwnerName),
      AppStrings.perameter_landId: selectAddress?.landLocationId ??
          AppPreference.getString(AppStrings.locationId),
      AppStrings.perameter_utilityId: selectAddress?.utilityId ??
          AppPreference.getString(AppStrings.utilityId),
      AppStrings.perameter_materialTypes: "$selectedCompostable",
    };

    final response = await DioApiClient()
        .dio!
        .get(babricEndPoint, queryParameters: paramters);
    for (int i = 0; i < response.data.length; i++) {
      babic = Babic.fromJson(response.data[i]);
    }
    Get.toNamed(
      Routes.RequestAcceptable,
    );
    update();
  }
}

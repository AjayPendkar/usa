import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:myrichardson/utils/common_widgets/common_design.dart';
import 'package:myrichardson/utils/loader.dart';
import 'package:myrichardson/model/address_model.dart';
import '../dioController.dart';

class AddressController extends GetxController {
  List<Address> autoCompleteData = [];
  SuggestionsBoxController? suggestionsBoxController;
  TextEditingController controller = TextEditingController();
  bool isClicked = false;
  var add;
  var textName;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Address>> getAddress(String address) async {
    autoCompleteData = [];
    try {
      showLoadingIndicator();
      final response =
          await DioApiClient().dio!.get(addressEndPoint + address + "*");
      hideLoadingIndicator();
      for (int i = 0; i < response.data.length; i++) {
        autoCompleteData.add(Address.fromJson(response.data[i]));
      }
      autoCompleteData.add(Address(type: 'buttonAdd'));
      print("suggestionsCallback autoCompleteData ${autoCompleteData.length}");
    } catch (exception) {
      hideLoadingIndicator();
      msgInToast(msg: "Connection TimeOut .......");
    }
    update();
    return autoCompleteData;
  }

  setSelectedAddress(String address) async {
    add = address;
    update();
  }
}

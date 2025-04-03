import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:myrichardson/model/contact_us_model.dart';
import 'package:myrichardson/utils/common_widgets/common_design.dart';

import '../dioController.dart';

class ContactController extends GetxController {
  List<Contact> contactList = [];
  bool isLoading = false;

  @override
  void onInit() {
    getContact();
    super.onInit();
  }

  onUpdateCloseLoader() {
    isLoading = false;
    update();
  }

  void getContact() async {
    try {
      isLoading = true;
      final response = await DioApiClient().dio!.get(contactEndPoint);
      isLoading = false;
      for (int i = 0; i < response.data.length; i++) {
        contactList.add(Contact.fromJson(response.data[i]));
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.error is ResponseType) {
        onUpdateCloseLoader();
      }
      // ignore: deprecated_member_use
      if (e.type == DioErrorType.connectionTimeout) {
        onUpdateCloseLoader();
        msgInToast(
            msg: "Connection TimeOut .......", gravity: ToastGravity.SNACKBAR);
      }
      if (e.error is SocketException) {
        onUpdateCloseLoader();
        msgInToast(
            msg: "No, Internet Connection.......",
            gravity: ToastGravity.SNACKBAR);
      }
    }
    update();
  }
}

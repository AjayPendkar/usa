import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/new_issue/new_issue_controller.dart';

import '../library.dart';

class ExceptionHandling {
  final refresh = Get.put(NewIssueController());

  bool isLoading = false;

  requestServer(computation()) async {
    try {
      return await computation();
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.error is ResponseType) {
        isLoading = false;
        refresh.onUpdate();
      }
      // ignore: deprecated_member_use
      if (e.type == DioErrorType.connectionTimeout) {
        isLoading = false;
        refresh.onUpdate();
        msgInToast(
            msg: "Connection TimeOut .......", gravity: ToastGravity.SNACKBAR);
      }
      if (e.error is SocketException) {
        isLoading = false;
        refresh.onUpdate();
        msgInToast(
            msg: "No, Internet Connection.......",
            gravity: ToastGravity.SNACKBAR);
      }
    } catch (e) {}
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/dioController.dart';
import 'package:myrichardson/main.dart';
import 'package:myrichardson/model/notification_model.dart';
import 'package:myrichardson/utils/library.dart';

import '../../utils/shared_preference/shared_preference.dart';

class DashboardController extends GetxController {
  NotificationModel? notificationModel;
  bool isLoading = false;
  // bool isVisible = isUserClosedWarningMessage ? false : true;

  List<String> itemTitle = [
    AppStrings.new_issue,
    AppStrings.my_issue,
    AppStrings.BBIC_request,
    AppStrings.news,
    AppStrings.event,
    AppStrings.thingstodo,
    AppStrings.contact_us,
    AppStrings.profile,
  ];
  List<String> itemSubtitle = [
    AppStrings.newIssue_desc,
    AppStrings.myIssue_desc,
    AppStrings.babic_desc,
    AppStrings.news_desc,
    AppStrings.event_desc,
    AppStrings.thingstodo_desc,
    AppStrings.contact_desc,
    AppStrings.profile_desc,
  ];

  final List<String> drawerItems = [
    AppStrings.Home,
    AppStrings.new_issue,
    AppStrings.my_issue,
    AppStrings.BBIC_request,
    AppStrings.news,
    AppStrings.event,
    AppStrings.thingstodo,
    AppStrings.profile,
    AppStrings.contact,
    AppStrings.show_alert,
  ];

  void showToast() {
    update();
    // isVisible = !isVisible;
    // AppPreference.set(AppStrings.notification,
    //     !AppPreference.getBool(AppStrings.notification));
    AppPreference.set(AppStrings.notification, true);
    update();
  }

  onUpdateCloseLoader() {
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    if (notificationModelWarningMessage == null) {
      getNotification();
    } else {
      notificationModel = notificationModelWarningMessage;
    }

    super.onInit();
  }

  bool isMessageBlank = true;

  void getNotification() async {
    try {
      isLoading = true;
      final response = await DioApiClient().dio!.get(notificationEndPoint);

      isLoading = false;
      //@TODO: remove before push
      // response.data = [];
      if (response.data == []) {
        isMessageBlank = true;
      } else {
        isMessageBlank = false;
      }
      for (int i = 0; i < response.data.length; i++) {
        notificationModel = NotificationModel.fromJson(response.data[i]);
        notificationModelWarningMessage = notificationModel!;
      }
      // notificationModel!.url = "";
      // notificationModelWarningMessage!.url = "";
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.error is ResponseType) {
        onUpdateCloseLoader();
      }
      // ignore: deprecated_member_use
      if (e.type == DioErrorType.connectionTimeout) {
        onUpdateCloseLoader();
      }
      if (e.error is SocketException) {
        onUpdateCloseLoader();
        // msgInToast(
        //     msg: "No, Internet Connection.......",
        //     gravity: ToastGravity.SNACKBAR);
      }
    }
    update();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/dashboard/dashboard_controller.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/dashboard/widget/warning_richtext.dart';

bool isUserClosedWarningMessage = false;

class WarningMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (_) => _.notificationModel == null
          ? Container()
          : Padding(
              padding: AppTextStyle.appAllPadding15,
              child:
                  //!isUserClosedWarningMessage
                  !AppPreference.getBool(AppStrings.notification)
                      // && _.notificationName != null
                      ? Container(
                          padding: symmetricPadding(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColor.warningColor,
                          ),
                          // height: Screen.screenHeight * 0.10,
                          child: _.isLoading
                              ? Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator())
                              : _.notificationModel == null
                                  ? Padding(
                                      padding: symmetricPadding(
                                          vertical: 20, horizontal: 60),
                                      child: Text(
                                        AppStrings.error_msg,
                                        style: TextStyle(
                                            color: AppColor.primaryWhite),
                                      ),
                                    )
                                  : WarningRichText(
                                      onPressed: () {
                                        _.showToast();
                                        isUserClosedWarningMessage = true;
                                        // AppPreference.set(
                                        //     AppStrings.notification, true);
                                      },
                                      warningText:
                                          "${_.notificationModel!.text ?? ''}",
                                      notificationModel: _.notificationModel!,
                                    ),
                        )
                      : Container()),
    );
  }
}

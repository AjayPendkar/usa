import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/dashboard/dashboard_controller.dart';
import 'package:myrichardson/routes/app_routes.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/dashboard/dashboard_screen.dart';

import '../../view/dashboard/widget/warning_message.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          GetBuilder<DashboardController>(
            init: DashboardController(),
            builder: (_) => Drawer(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    verticalSpace(29),
                    Container(
                      height: Screen.screenHeight * 0.60,
                      child: ListView.builder(
                        itemCount: _.drawerItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: onlyPadding(left: 10),
                            child: SizedBox(
                              height: 44,
                              child: TextButton(
                                onPressed: () {
                                  switch (index) {
                                    case 0:
                                      Get.back();
                                      break;
                                    case 1:
                                      Get.toNamed(Routes.NewIssueScreen);
                                      break;
                                    case 2:
                                      Get.toNamed(Routes.MyIssueScreen);
                                      break;
                                    case 3:
                                      AppPreference.set(
                                          AppStrings.listLastAddButton, true);
                                      AppPreference.set(
                                          AppStrings.fixAddressStore, true);
                                      AppPreference.set(
                                          AppStrings.address_screen_back, true);
                                      AppPreference.set(
                                          AppStrings.address_selectNavigation,
                                          true);
                                      AppPreference.set(
                                          AppStrings.address_search_button,
                                          false);
                                      Get.toNamed(Routes.SearchAddressBabric);
                                      break;
                                    case 4:
                                      Get.toNamed(Routes.PrivacyScreen);
                                      break;
                                    case 5:
                                      Get.toNamed(Routes.EventScreen);
                                      break;
                                    case 6:
                                      Get.toNamed(Routes.ThingsToDoScreen);

                                      break;
                                    case 7:
                                      AppPreference.set(
                                          AppStrings.listLastAddButton, false);
                                      AppPreference.set(
                                          AppStrings.fixAddressStore, false);
                                      AppPreference.set(
                                          AppStrings.address_screen_back,
                                          false);
                                      AppPreference.set(
                                          AppStrings.address_selectNavigation,
                                          false);
                                      Get.toNamed(Routes.UserProfile);
                                      break;
                                    case 8:
                                      Get.toNamed(Routes.ContactScreen);
                                      break;
                                    case 9:
                                      isUserClosedWarningMessage = false;
                                      AppPreference.set(
                                          AppStrings.notification, false);
                                      Get.offAll(DashboardScreen());
                                      break;
                                  }
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(_.drawerItems[index],
                                      style: AppTextStyle.robotoMedium(
                                          fontSize: 14,
                                          color: AppColor.blackTextColor)),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/dashboard/dashboard_controller.dart';
import 'package:myrichardson/routes/app_routes.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/dashboard/widget/warning_message.dart';

import '../../new_issue/new_issue_screen.dart';

class ListOfCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (_) {
          return Padding(
            padding:
                // !AppPreference.getBool(AppStrings.notification)
                //     ? !_.isMessageBlank
                //         ? AppTextStyle.appAllPadding10
                //         : EdgeInsets.fromLTRB(10, 100, 10, 20)
                //     :
                AppTextStyle.appAllPadding10,
            child: ListView.builder(
              itemCount: _.itemTitle.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    switch (index) {
                      case 0:
                        {
                          selectedSalutation = "";
                          Get.toNamed(Routes.NewIssueScreen);
                          break;
                        }
                      case 1:
                        Get.toNamed(Routes.MyIssueScreen);
                        break;
                      case 2:
                        AppPreference.set(AppStrings.listLastAddButton, true);
                        AppPreference.set(AppStrings.fixAddressStore, true);
                        AppPreference.set(AppStrings.address_screen_back, true);
                        AppPreference.set(
                            AppStrings.address_selectNavigation, true);
                        AppPreference.set(
                            AppStrings.address_search_button, false);
                        Get.toNamed(Routes.SearchAddressBabric);
                        break;
                      case 3:
                        Get.toNamed(Routes.PrivacyScreen);
                        break;
                      case 4:
                        Get.toNamed(Routes.EventScreen);
                        break;
                      case 5:
                        Get.toNamed(Routes.ThingsToDoScreen);

                        break;
                      case 6:
                        AppPreference.set(AppStrings.listLastAddButton, false);
                        AppPreference.set(AppStrings.fixAddressStore, false);
                        AppPreference.set(
                            AppStrings.address_screen_back, false);
                        AppPreference.set(
                            AppStrings.address_selectNavigation, false);
                        Get.toNamed(Routes.ContactScreen);
                        break;
                      case 7:
                        AppPreference.set(
                            AppStrings.address_selectNavigation, false);
                        AppPreference.set(AppStrings.fixAddressStore, false);
                        Get.toNamed(Routes.UserProfile);
                        break;
                    }
                  },
                  child: Column(
                    children: [
                      if (index == 0)
                        if (!isUserClosedWarningMessage) WarningMessage(),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.primaryWhite,
                          border: Border.all(color: AppColor.greyBorderColor),
                        ),
                        margin: AppTextStyle.appAllPadding5,
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 9,
                                child: Padding(
                                  padding: AppTextStyle.appAllPadding20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _.itemTitle[index],
                                        style: AppTextStyle.robotoBold(
                                            fontSize: 14,
                                            color: AppColor.blackTextColor),
                                      ),
                                      Text(
                                        _.itemSubtitle[index],
                                        maxLines: 8,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyle.robotoRegular(
                                            fontSize: 12,
                                            color: AppColor.lightGreyTextColor,
                                            height: 1.6),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: AppColor.greyBoxColor,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                    color: AppColor.greyArrowColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}

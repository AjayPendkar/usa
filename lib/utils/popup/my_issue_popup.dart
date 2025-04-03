import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cupertino_tabbar/cupertino_tabbar.dart' as CupertinoTabBar;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/my_issue/my_issue_controller.dart';
import 'package:myrichardson/utils/library.dart';

myIssuePopUP(BuildContext context) {
  return AwesomeDialog(
    context: context,
    dialogBackgroundColor: AppColor.background,
    headerAnimationLoop: false,
    animType: AnimType.SCALE,
    dialogType: DialogType.NO_HEADER,
    body: GetBuilder<MyIssueController>(
        init: MyIssueController(),
        builder: (_) => Padding(
              padding: allPadding(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.popUpTitle,
                    style: AppTextStyle.robotoMedium(
                        color: AppColor.blackTextColor, fontSize: 17),
                  ),
                  verticalSpace(10),
                  CupertinoTabBar.CupertinoTabBar(
                    AppColor.whiteGrey,
                    AppColor.whitef7f7f7,
                    [
                      tabBarText(tabText: AppStrings.Open_Tickets),
                      tabBarText(tabText: AppStrings.Closed_Tickets),
                      tabBarText(tabText: AppStrings.All_Tickets),
                    ],
                    _.signalValGetter,
                    (int index) {
                      _.signalValChangeTab(index: index);
                    },
                    innerHorizontalPadding: 0,
                    animateUntilScrolled: true,
                    useSeparators: true,
                    fittedWhenScrollable: false,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textButtonPopUP(
                        popUpText: AppStrings.ok,
                        onPressed: () {
                          _.getFilter(_.filterTab[_.signalValue]);
                          Get.back();
                        },
                      ),
                      Container(
                        height: 25,
                        child: verticalDivider(
                          color: AppColor.greyDividerColor,
                          width: 1,
                          thickness: 1,
                        ),
                      ),
                      textButtonPopUP(
                        popUpText: AppStrings.cancel,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  )
                ],
              ),
            )),
  )..show();
}

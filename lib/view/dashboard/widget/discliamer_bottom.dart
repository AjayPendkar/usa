import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/dashboard/dashboard_controller.dart';
import 'package:myrichardson/routes/app_routes.dart';
import 'package:myrichardson/utils/library.dart';

class DisclaimerBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.2),
      child: GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (_) => Container(
          height: Screen.screenHeight * 0.07,
          color: AppColor.themeColor,
          child: Padding(
            padding: AppTextStyle.appSymmetricPaddingH10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.Agreement);
                  },
                  child: Text(
                    AppStrings.disclaimer,
                    maxLines: 10,
                    style: AppTextStyle.robotoRegular(
                        fontSize: 14, color: AppColor.primaryWhite),
                  ),
                ),
                InkWell(
                  onTap: () {
                    AppLauncher.launchCaller(Url: '(972) 744-4111');
                  },
                  child: Text(
                    '(972) 744-4111',
                    maxLines: 10,
                    style: AppTextStyle.robotoRegular(
                        fontSize: 14, color: AppColor.primaryWhite),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

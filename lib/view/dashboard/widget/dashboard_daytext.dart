import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/recycle_day/recycle_controller.dart';
import 'package:myrichardson/controller/trash/trash_controller.dart';
import 'package:myrichardson/controller/water/water_controller.dart';
import 'package:myrichardson/routes/app_routes.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/dashboard/widget/common_dayText.dart';

import '../../../controller/dashboard/water_trash_recycle_controller.dart';

class DayText extends StatelessWidget {
  final trash = Get.put(TrashController());
  final recycle = Get.put(RecycleController());
  final water = Get.put(WaterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaterTrashRecycleController>(
        init: WaterTrashRecycleController(),
        builder: (_) {
          return Column(
            children: [
              Container(
                height: Screen.screenHeight * 0.09,
                decoration: BoxDecoration(
                    color: AppColor.primaryWhite,
                    borderRadius: BorderRadius.zero,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.greyShadowColor,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DashboardDayText(
                        eventDay: AppStrings.water,
                        // weekDay: AppPreference.getBool(AppStrings.dashboard)
                        //     ? water.evenOddAddress().toString()
                        //     : AppStrings.unknown,
                        // weekDay: _.waterTrashRecycleModel!.water,
                        // weekDay: _.waterTrashRecycleModel != null
                        //     ? _.waterTrashRecycleModel!.water
                        //     : AppStrings.unknown,
                        weekDay: AppPreference.getString(
                                AppStrings.spWaterDayValue) ??
                            AppStrings.unknown,
                        onTap: () {
                          Get.toNamed(Routes.WaterScreen);
                        }),
                    DashboardDayText(
                        eventDay: AppStrings.trash_day,
                        // weekDay: AppPreference.getBool(AppStrings.dashboard)
                        //     ? trash.getTrashDay()
                        //     : AppStrings.unknown,

                        // weekDay: _.waterTrashRecycleModel != null
                        //     ? _.waterTrashRecycleModel!.trash
                        //     : AppStrings.unknown,
                        weekDay: AppPreference.getString(
                                AppStrings.spTrashDayValue) ??
                            AppStrings.unknown,
                        onTap: () {
                          Get.toNamed(Routes.TrashScreen);
                        }),
                    DashboardDayText(
                        eventDay: AppStrings.Recycle_Day,
                        // weekDay: AppPreference.getBool(AppStrings.dashboard)
                        //     ? recycle.getRecycleDay()
                        //     : AppStrings.unknown,
                        // weekDay: _.waterTrashRecycleModel != null
                        //     ? _.waterTrashRecycleModel!.recycling
                        //     : AppStrings.unknown,
                        weekDay: AppPreference.getString(
                                AppStrings.spRecyclingDayValue) ??
                            AppStrings.unknown,
                        onTap: () {
                          Get.toNamed(Routes.RecycleDayScreen);
                        }),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

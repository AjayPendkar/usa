import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/water/water_controller.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/water/widget/water_header.dart';

class WaterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TitleAppBar(title: AppStrings.water),
        body: GetBuilder<WaterController>(
          init: WaterController(),
          builder: (_) => SingleChildScrollView(
            child: Padding(
              padding: onlyPadding(bottom: 15),
              child: _.isLoading
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: _.waterList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            WaterHeader(
                              // day: AppPreference.getBool(AppStrings.dashboard)
                              //     ? _.evenOddAddress().toString()
                              //     : AppStrings.unknown,
                              day: AppPreference.getString(
                                      AppStrings.spWaterDayValue) ??
                                  AppStrings.unknown,
                              stage: _.waterList[index].stage,
                              waterDesc: _.waterList[index].implementedText,
                              evenWaterText:
                                  _.waterList[index].evenWateringDays![index] +
                                      " & " +
                                      _.waterList[index].evenWateringDays![1],
                              oddWaterText:
                                  _.waterList[index].oddWateringDays![index] +
                                      " & " +
                                      _.waterList[index].oddWateringDays![1],
                            ),
                            GreyTitleContainer(
                              title: AppStrings.restrictions,
                            ),
                            verticalSpace(12),
                            for (int i = 0;
                                i <
                                    _.waterList[index].additionalRestrictions!
                                        .length;
                                i++)
                              waterBottomText(
                                descriptionText:
                                    '${_.waterList[index].additionalRestrictions![i]}',
                                // maxLine: 10
                              ),
                            GreyTitleContainer(
                              padding: symmetricPadding(vertical: 12),
                              title: AppStrings.exemptions,
                            ),
                            for (int i = 0;
                                i < _.waterList[index].exemptions!.length;
                                i++)
                              waterBottomText(
                                descriptionText:
                                    '${_.waterList[index].exemptions![i]}',
                                // maxLine: 10
                              ),
                            GreyTitleContainer(
                              padding: symmetricPadding(vertical: 12),
                              title: AppStrings.variances,
                            ),
                            for (int i = 0;
                                i < _.waterList[index].variances!.length;
                                i++)
                              waterBottomText(
                                descriptionText:
                                    _.waterList[index].variances![i],
                                // maxLine: 10
                              ),
                          ],
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

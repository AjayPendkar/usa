import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/recycle_day/recycle_controller.dart';
import 'package:myrichardson/model/recycle_day_model.dart';
import 'package:myrichardson/utils/date_format/date_formated.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/recycle_day/widget/holiday_header.dart';
import 'package:myrichardson/view/recycle_day/widget/recycle_bottom.dart';
import 'package:myrichardson/view/recycle_day/widget/recycle_header.dart';
import 'package:myrichardson/view/recycle_day/widget/recycle_holiday.dart';

class RecycleDayScreen extends StatefulWidget {
  @override
  State<RecycleDayScreen> createState() => _RecycleDayScreenState();
}

class _RecycleDayScreenState extends State<RecycleDayScreen> {
  var currentDate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TitleAppBar(title: AppStrings.Recycle_Day),
        body: GetBuilder<RecycleController>(
          init: RecycleController(),
          builder: (_) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _.isLoading
                    ? Align(
                        alignment: Alignment.topCenter,
                        child: CircularProgressIndicator())
                    : _.recycleList == null
                        ? errorMsg()
                        : Column(
                            children: [
                              RecycleHeader(
                                // day: AppPreference.getBool(AppStrings.dashboard)
                                //     ? _.getRecycleDay()
                                //     : AppStrings.unknown,
                                day: AppPreference.getString(
                                        AppStrings.spRecyclingDayValue) ??
                                    AppStrings.unknown,
                                learnText:
                                    "${_.recycleList!.introduction!.link!.text}",
                                recycleDesc: _.recycleList!.introduction!.text,
                              ),
                              RecycleBottom(),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: _.recycleList!.additionalInformation!
                                    .dropOffCenters!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: onlyPadding(
                                      left: 15,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        verticalSpace(15),
                                        blackLineText(
                                            dropText: _
                                                .recycleList!
                                                .additionalInformation!
                                                .dropOffCenters![index]
                                                .text),
                                        Column(
                                          children: recycleDay(_
                                              .recycleList!
                                              .additionalInformation!
                                              .dropOffCenters![index]
                                              .links!),
                                        ),
                                        greyTextColor(
                                          greyText: _
                                              .recycleList!
                                              .additionalInformation!
                                              .dropOffCenters![index]
                                              .notes,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              GreyTitleContainer(
                                  title: AppStrings.Holiday_MakeUp_Days,
                                  padding: AppTextStyle.appSymmetricPaddingV15),
                            ],
                          ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _.holidayMarkup!.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0 ||
                        currentDate != _.holidayMarkup![index].holidayName) {
                      currentDate = _.holidayMarkup![index].holidayName;
                      return Column(
                        children: [
                          HoliDayHeaderRow(
                              day: _.holidayMarkup![index].holidayName,
                              date:
                                  " -   ${formatDate(datePass: _.holidayMarkup![index].holidayDate.toString())}"),
                          RecycleTextHoliday(
                            subtitle: AppStrings.recycle_day,
                            title: AppStrings.make_up_day,
                            color: AppColor.backgroundColor,
                          ),
                          divider(
                              color: AppColor.lightGreyTextColor,
                              height: 3,
                              thickness: 1.3),
                          RecycleTextHoliday(
                            title:
                                "${formatDate(datePass: _.holidayMarkup![index].recyclingDay.toString())}",
                            subtitle:
                                "${formatDate(datePass: _.holidayMarkup![index].makeupDay.toString())}",
                            textStyle: AppTextStyle.robotoRegular(
                                fontSize: 14, color: AppColor.blackTextColor),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          RecycleTextHoliday(
                            title:
                                "${formatDate(datePass: _.holidayMarkup![index].recyclingDay.toString())}",
                            subtitle:
                                "${formatDate(datePass: _.holidayMarkup![index].makeupDay.toString())}",
                            textStyle: AppTextStyle.robotoRegular(
                                fontSize: 14, color: AppColor.blackTextColor),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> recycleDay(List<LinkElement> list) {
    List<Widget> recycle = [];
    list.forEach((link) {
      recycle.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonBlackBoldText(text: link.location),
            underLineText(
              mainText: link.address,
              onTap: () {
                AppLauncher.launchURL(url: link.url);
              },
            ),
            link.city!.isEmpty
                ? Container()
                : greyTextColor(greyText: link.city, height: 1.4),
            link.phone!.isEmpty
                ? Container()
                : underLineText(
                    mainText: link.phone,
                    onTap: () {
                      AppLauncher.launchCaller(Url: link.phone);
                    }),
            verticalSpace(5)
          ],
        ),
      );
    });
    return recycle;
  }
}

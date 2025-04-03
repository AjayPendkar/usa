import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/trash/trash_controller.dart';
import 'package:myrichardson/model/trash_model.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/trash/widget/trash_bottom.dart';
import 'package:myrichardson/view/trash/widget/trash_header.dart';
import 'package:myrichardson/view/water/widget/water_text_widget.dart';

class TrashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TitleAppBar(title: AppStrings.trash),
        body: GetBuilder<TrashController>(
          init: TrashController(),
          builder: (_) => SingleChildScrollView(
            child: _.isLoading
                ? Align(
                    alignment: Alignment.topCenter,
                    child: CircularProgressIndicator())
                : _.trashList == null
                    ? errorMsg()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TrashHeader(
                            trashDesc: _.trashList!.introduction!.text,
                            learnText:
                                "${_.trashList!.introduction!.link!.text}",
                            // day: AppPreference.getBool(AppStrings.dashboard)
                            //     ? _.getTrashDay()
                            //     : AppStrings.unknown,
                            day: AppPreference.getString(
                                    AppStrings.spTrashDayValue) ??
                                AppStrings.unknown,
                          ),
                          Container(
                            margin: AppTextStyle.appAllPadding15,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColor.primaryGrey)),
                            child: Column(
                              children: [
                                waterTrashTableHeader(
                                  keyText: AppStrings.home_location,
                                  valueText: AppStrings.regular_trash_day,
                                ),
                                for (int i = 0;
                                    i <
                                        _.trashList!.introduction!.trashDays!
                                            .length;
                                    i++)
                                  WaterText(
                                    keyText: _.trashList!.introduction!
                                        .trashDays![i].location,
                                    valueText:
                                        "${_.trashList!.introduction!.trashDays![i].text}",
                                  ),
                              ],
                            ),
                          ),
                          TrashBottom(),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _.trashList!.additionalInformation!
                                .dropOffCenters!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: onlyPadding(
                                  left: 15,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    verticalSpace(15),
                                    blackLineText(
                                        dropText: _
                                            .trashList!
                                            .additionalInformation!
                                            .dropOffCenters![index]
                                            .text),
                                    Column(
                                      children: trashDay(_
                                          .trashList!
                                          .additionalInformation!
                                          .dropOffCenters![index]
                                          .links!),
                                    ),
                                    greyTextColor(
                                      greyText: _
                                          .trashList!
                                          .additionalInformation!
                                          .dropOffCenters![index]
                                          .notes,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          verticalSpace(15),
                          GreyTitleContainer(
                            title: AppStrings.holidayInformation,
                          ),
                          waterTrashRecycleDescription(
                              descriptionText: _.trashList!
                                  .additionalInformation!.holidayInformation),
                        ],
                      ),
          ),
        ),
      ),
    );
  }

  List<Widget> trashDay(List<LinkElement> list) {
    List<Widget> trash = [];
    list.forEach((link) {
      trash.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonBlackBoldText(text: link.location),
          underLineText(
              mainText: link.address!,
              onTap: () {
                AppLauncher.launchURL(url: link.url);
              }),
          if (link.city != null && link.city!.length > 0) Text(link.city!),
          link.phone!.isEmpty
              ? Container()
              : underLineText(
                  mainText: link.phone,
                  onTap: () {
                    AppLauncher.launchCaller(Url: link.phone);
                  }),
          verticalSpace(5)
        ],
      ));
    });
    return trash;
  }
}

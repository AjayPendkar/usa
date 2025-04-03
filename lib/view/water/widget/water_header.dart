import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/web_url/allweb_url_link.dart';
import 'package:myrichardson/view/water/widget/water_text_widget.dart';

class WaterHeader extends StatelessWidget {
  final String? day;
  final String? stage;
  final String? waterDesc;
  final String? evenWaterText;
  final String? oddWaterText;

  const WaterHeader(
      {this.day,
      this.stage,
      this.waterDesc,
      this.evenWaterText,
      this.oddWaterText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconWithDayText(
          dayText: day,
          icon: Icons.location_on,
        ),
        AdditionalInfoBlueText(title: stage),
        waterTrashRecycleDescription(descriptionText: waterDesc),
        learnMore(
          learnMoreText: AppStrings.learn_more_about_water,
          onTap: () => AppLauncher.launchURL(url: WebUrl.waterUrl),
        ),
        Container(
          margin: AppTextStyle.appAllPadding15,
          decoration: BoxDecoration(border: Border.all(color: AppColor.black)),
          child: Column(
            children: [
              waterTrashTableHeader(
                valueText: AppStrings.water_day,
                keyText: AppStrings.last_digit_address,
              ),
              WaterText(
                keyText: AppStrings.even,
                valueText: evenWaterText,
              ),
              WaterText(
                keyText: AppStrings.odd,
                valueText: oddWaterText,
              ),
              Container(
                padding: AppTextStyle.appAllPadding10,
                color: AppColor.greyDDDD,
                child: Center(
                    child: greyTextColor(
                        greyText: AppStrings.no_law_watering_day)),
              )
            ],
          ),
        ),
        verticalSpace(10),
        AdditionalInfoBlueText(title: AppStrings.additional_info),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class HoliDayHeaderRow extends StatelessWidget {
  final String? day;
  final EdgeInsetsGeometry? padding;
  final String? date;

  HoliDayHeaderRow({this.day, this.padding, this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? symmetricPadding(vertical: 0),
      child: Container(
        height: 37,
        width: Screen.screenWidth,
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ' $day',
                style: AppTextStyle.robotoBold(
                  fontSize: 15,
                  color: AppColor.primaryWhite,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Text(
                ' $date',
                softWrap: true,
                style: AppTextStyle.robotoBold(
                  fontSize: 15,
                  color: AppColor.primaryWhite,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        color: AppColor.themeColor,
      ),
    );
  }
}

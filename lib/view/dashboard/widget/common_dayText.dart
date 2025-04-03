import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class DashboardDayText extends StatelessWidget {
  final onTap;
  final String? eventDay;
  final String? weekDay;

  const DashboardDayText({this.onTap, this.eventDay, this.weekDay});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            eventDay!,
            style: AppTextStyle.robotoBold(
                fontSize: 14, color: AppColor.greyTextColor),
            overflow: TextOverflow.ellipsis,
          ),
          Text(weekDay!,
              style: AppTextStyle.robotoRegular(
                  fontSize: 10.5, color: AppColor.greyTextColor, height: 1.5),
              overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}

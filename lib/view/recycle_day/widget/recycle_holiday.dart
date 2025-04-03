import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class RecycleTextHoliday extends StatelessWidget {
  final Color? color;
  final String? title;
  final String? subtitle;
  final TextStyle? textStyle;

  const RecycleTextHoliday(
      {Key? key, this.color, this.title, this.subtitle, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTextStyle.appAllPadding10,
      color: color,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title!,
              style: textStyle ??
                  AppTextStyle.robotoBold(
                      fontSize: 14, color: AppColor.blackTextColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              subtitle!,
              overflow: TextOverflow.ellipsis,
              style: textStyle ??
                  AppTextStyle.robotoBold(
                      fontSize: 14, color: AppColor.blackTextColor),
            ),
          ),
        ],
      ),
    );
  }
}

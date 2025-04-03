import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class RequestFrom extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const RequestFrom({
    Key? key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: onlyPadding(bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title!,
                  style: AppTextStyle.robotoBold(
                      fontSize: 14, color: AppColor.blackTextColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Text(
                  subtitle.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.robotoRegular(
                      fontSize: 14, color: AppColor.greyTextColor),
                ),
              ),
            ],
          ),
          verticalSpace(7),
          divider(color: AppColor.greyIconColor, height: 3, thickness: 1),
        ],
      ),
    );
  }
}

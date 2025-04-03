import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class SimpleTextDivider extends StatelessWidget {
  final String? text;
  final onTap;
  final secondText;
  final String? dataText;
  final TextDecoration? decoration;

  const SimpleTextDivider(
      {Key? key,
      this.text,
      this.onTap,
      this.secondText,
      this.dataText,
      this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: onlyPadding(left: 15, bottom: 18, top: 18),
          child: Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(text.toString(),
                  style: AppTextStyle.robotoMedium(
                      fontSize: 18, color: AppColor.userTextGrey)),
              horizontalSpace(8),
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: secondText ??
                      Text(dataText.toString(),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: AppTextStyle.robotoMedium(
                                  fontSize: 18, color: AppColor.blueColor)
                              .copyWith(
                            decoration: decoration,
                          )),
                ),
              )
            ],
          ),
        ),
        divider(color: AppColor.greyDividerColor, height: 2),
      ],
    );
  }
}

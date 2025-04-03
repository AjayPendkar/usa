import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class RichTextCommon extends StatelessWidget {
  final String? firstText;
  final TextStyle? firstTextStyle;
  final String? secondText;
  final TextStyle? secondTextStyle;

  const RichTextCommon(
      {Key? key,
      this.firstText,
      this.firstTextStyle,
      this.secondText,
      this.secondTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: firstText,
          style: firstTextStyle ??
              AppTextStyle.robotoRegular(
                  fontSize: 17, color: AppColor.textFieldTextGrey),
          children: [
            TextSpan(
                text: secondText,
                style: secondTextStyle ??
                    AppTextStyle.robotoRegular(
                        fontSize: 14,
                        color: AppColor.richTextGrey,
                        height: 3.5))
          ]),
    );
  }
}

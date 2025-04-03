import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class WaterText extends StatelessWidget {
  final String? keyText;
  final String? valueText;
  final TextStyle? textStyle;
  final Decoration? decoration;

  WaterText(
      {this.keyText,
      this.valueText,
      this.textStyle = AppTextStyle.regularGrey14,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTextStyle.appAllPadding10,
      decoration: decoration ??
          BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: AppColor.greyDividerColor))),
      child: Row(
        children: [
          Expanded(
            child: Text(
              keyText!,
              maxLines: 5,
              style: textStyle,
              // maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(
              valueText!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class NewIssueFormTitle extends StatelessWidget {
  final String? issueTitle;
  NewIssueFormTitle({this.issueTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(25),
        Align(
            alignment: Alignment.topLeft,
            child: Text(issueTitle!,
                style: AppTextStyle.robotoBold(
                    fontSize: 15, color: AppColor.darkBlueColor))),
      ],
    );
  }
}

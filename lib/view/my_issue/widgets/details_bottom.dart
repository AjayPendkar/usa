import 'package:flutter/material.dart';
import 'package:myrichardson/model/my_issue_model.dart';
import 'package:myrichardson/utils/date_format/date_formated.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/view/my_issue/widgets/description_column.dart';

class DetailsBottom extends StatelessWidget {
  final String? issueType;
  final String? issueId;
  final String? issueAddress;
  final String? statusDate;
  final String? createdDate;
  final MyIssue? myIssue;

  const DetailsBottom(
      {this.issueType,
      this.issueId,
      this.issueAddress,
      this.statusDate,
      this.createdDate,
      this.myIssue});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppTextStyle.appAllPadding20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              issueType.toString(),
              style:
                  AppTextStyle.robotoBold(fontSize: 18, color: AppColor.black),
            ),
            Text(
              issueId.toString(),
              maxLines: 5,
              style: AppTextStyle.robotoRegular(
                  fontSize: 14, color: AppColor.black, height: 1.6),
            ),
            Text(
              issueAddress.toString(),
              maxLines: 5,
              style: AppTextStyle.robotoRegular(
                  fontSize: 16, color: AppColor.black, height: 3),
            ),
            verticalSpace(40),
            submitResolvedDate(
              status: AppStrings.submit_jem,
              statusDate: cstToNormalDateConvert(datePass: statusDate),
            ),
            submitResolvedDate(
                status: AppStrings.resolved_jem,
                statusDate: cstToNormalDateConvert(datePass: createdDate)),
            if (myIssue != null && myIssue!.status == "Resolved")
              submitResolvedDate(
                  status: AppStrings.resolutionComments,
                  statusDate: cstToNormalDateConvert(
                      datePass: myIssue!.resolutionDescription)),
          ],
        ),
      ),
    );
  }
}

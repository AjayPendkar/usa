import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/view/babric_request/widget/rich_text_widget.dart';

class IssueDescription extends StatelessWidget {
  const IssueDescription({
    Key? key,
    this.issueTypeTitle,
    this.mapAddress,
    this.issueDescription,
    this.issueDate,
    this.labelText,
  }) : super(key: key);

  final String? issueTypeTitle;
  final String? mapAddress;
  final String? issueDescription;
  final String? issueDate;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTextStyle.appSymmetricPaddingH10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(issueTypeTitle.toString(),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.robotoBold(
                  fontSize: 16, color: AppColor.black, height: 1.2)),
          Text(mapAddress.toString(),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.robotoRegular(
                  fontSize: 14, color: AppColor.black, height: 1.2)),
          Text(issueDescription.toString(),
              style: AppTextStyle.robotoRegular(
                  fontSize: 14, color: AppColor.black, height: 1.2)),
          Text("$labelText  $issueDate",
              style: AppTextStyle.robotoRegular(
                  fontSize: 14, color: AppColor.BlueColor, height: 1.2)),
        ],
      ),
    );
  }
}

Widget submitResolvedDate({String? status, String? statusDate}) {
  return Column(
    children: [
      verticalSpace(5),
      RichTextCommon(
        firstText: status,
        secondText: statusDate,
        firstTextStyle:
            AppTextStyle.robotoMedium(fontSize: 16, color: AppColor.BlueColor),
        secondTextStyle: AppTextStyle.robotoRegular(
            fontSize: 16, color: AppColor.lightGreyTextColor),
      ),
    ],
  );
}

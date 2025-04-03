import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/loader.dart';
import 'package:myrichardson/view/dashboard/dashboard_screen.dart';

class IssueSubmitted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    hideLoadingIndicator();
    return Scaffold(
      appBar: TitleAppBar(
        icon: commonIconAndBack(),
        title: AppStrings.newIssue_request_accepted,
      ),
      body: Padding(
        padding: symmetricPadding(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.issue_submitted,
              style: AppTextStyle.robotoBold(
                      color: AppColor.blueColor, fontSize: 28)
                  .copyWith(height: 3),
            ),
            Padding(
              padding: symmetricPadding(vertical: 20),
              child: AcceptReqText(
                  call: AppStrings.new_issue_call,
                  descriptionText: AppStrings.issue_submitted_desc,
                  fontSize: 15,
                  phoneNumber: AppStrings.new_issue_call),
            ),
            RadiusButton(
              btnText: AppStrings.home_submit,
              btnColor: AppColor.buttonBlue,
              btnOnTap: () {
                Get.offAll(() => DashboardScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}

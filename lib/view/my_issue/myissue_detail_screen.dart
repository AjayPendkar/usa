import 'package:flutter/material.dart';
import 'package:myrichardson/controller/my_issue/my_issue_controller.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/view/my_issue/widgets/details_bottom.dart';

class IssueDetailScreen extends StatelessWidget {
  final String? place;
  final String? resolveDate;
  final MyIssueController? controller;
  final int? index;

  IssueDetailScreen(
      {this.place, this.resolveDate, this.controller, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(title: AppStrings.issue_details),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: Screen.screenHeight / 3,
              child: controller!.filterList[index!].imageUrl != null
                  ? FadeInImage(
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.network(AppStrings.errorImage,
                            fit: BoxFit.fitWidth);
                      },
                      image: NetworkImage(
                          controller!.filterList[index!].imageUrl!),
                      fit: BoxFit.cover,
                      placeholder: AssetImage(AppStrings.loading_gif))
                  : Image.asset(AppStrings.placeHolder, fit: BoxFit.cover),
            ),
            DetailsBottom(
              issueType: controller!.filterList[index!].issueType!,
              issueId: controller!.filterList[index!].issueId!,
              issueAddress: controller!.filterList[index!].issueAddress!,
              statusDate: controller!.filterList[index!].statusDate,
              createdDate: controller!.filterList[index!].createdDate!,
              myIssue: controller!.filterList[index!],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/my_issue/my_issue_controller.dart';
import 'package:myrichardson/utils/date_format/date_formated.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/popup/my_issue_popup.dart';
import 'package:myrichardson/view/my_issue/myissue_detail_screen.dart';
import 'widgets/description_column.dart';

class MyIssueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyIssueController>(
        init: MyIssueController(),
        builder: (_) => SafeArea(
              child: Scaffold(
                appBar: TitleAppBar(
                    icon: commonIconAndBack(),
                    title: AppStrings.my_issue,
                    showAction: true,
                    action: Icon(
                      Icons.subject,
                      color: AppColor.whiteGrey,
                      size: 20,
                    ),
                    onTap: () {
                      myIssuePopUP(context);
                    }),
                body: _.filterList.length == 0
                    ? _.isLoading
                        ? Center(child: CircularProgressIndicator())
                        :
                        // Text("Aj")
                        myIssueDataNotFound()
                    : ListView.builder(
                        itemCount: _.filterList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(IssueDetailScreen(
                                controller: _,
                                index: index,
                              ));
                            },
                            child: Padding(
                              padding: AppTextStyle.appAllPadding10,
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            height: 80,
                                            child: _.filterList[index]
                                                        .imageUrl !=
                                                    null
                                                ? FadeInImage(
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.network(
                                                          AppStrings.errorImage,
                                                          fit: BoxFit.fitWidth);
                                                    },
                                                    image: NetworkImage(_
                                                        .filterList[index]
                                                        .imageUrl!),
                                                    fit: BoxFit.cover,
                                                    placeholder: AssetImage(
                                                        AppStrings.loading_gif))
                                                : Image.asset(
                                                    AppStrings.placeHolder,
                                                    fit: BoxFit.cover),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 8,
                                        child: IssueDescription(
                                          issueTypeTitle:
                                              _.filterList[index].issueType!,
                                          mapAddress:
                                              _.filterList[index].issueAddress!,
                                          issueDescription:
                                              _.filterList[index].comments!,
                                          labelText: _.filterList[index].status,
                                          issueDate: cstToNormalDateConvert(
                                              datePass: _.filterList[index]
                                                  .statusDate!),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              ),
            ));
  }
}

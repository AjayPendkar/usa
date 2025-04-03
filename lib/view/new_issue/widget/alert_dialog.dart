import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/new_issue/new_issue_controller.dart';
import 'package:myrichardson/utils/library.dart';

class BuildAlertDialog extends StatelessWidget {
  const BuildAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(
          AppStrings.take_photo,
          style: AppTextStyle.robotoBold(
              fontSize: 15, color: AppColor.darkBlueColor),
        ),
        content: GetBuilder<NewIssueController>(
          init: NewIssueController(),
          builder: (_) => Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _.openCamera();
                    Get.back();
                  },
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: AppColor.greyIconColor,
                    size: 60,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _.openGallery();
                    Get.back();
                  },
                  child: Icon(
                    Icons.image,
                    color: AppColor.greyIconColor,
                    size: 60,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

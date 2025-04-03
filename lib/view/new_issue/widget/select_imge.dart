import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/new_issue/new_issue_controller.dart';
import 'package:myrichardson/utils/library.dart';

class SelectImage extends StatelessWidget {
  const SelectImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewIssueController>(
        init: NewIssueController(),
        builder: (_) {
          return Container(
              margin: symmetricPadding(vertical: 10),
              height: Screen.screenHeight / 3.40,
              width: Screen.screenWidth / 1.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColor.greyBlurColor,
                border: Border.all(color: AppColor.greyBorderColor),
              ),
              child: _.file == null
                  ? Icon(
                      Icons.camera_alt_rounded,
                      color: AppColor.greyIconColor,
                      size: Screen.screenHeight / 6,
                    )
                  : Image.file(
                      File(_.file!.path),
                      fit: BoxFit.fill,
                    ));
        });
  }
}

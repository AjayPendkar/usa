import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:myrichardson/controller/babric/babric_controller.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/utilities.dart';
import 'package:myrichardson/view/babric_request/widget/common_widget.dart';
import 'package:myrichardson/view/babric_request/widget/rich_text_widget.dart';

class BABICBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BBICController>(
      init: BBICController(),
      builder: (_) => Padding(
        padding: symmetricPadding(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            requestCategoriesTitleText(
                titleText: AppStrings.compostable_categories),
            verticalSpace(10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _.babicCompostableList.length,
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckBoxWithCategories(
                    checkBoxText: _.babicCompostableList[index].title,
                    value: _.babicCompostableList[index].isCheck,
                    onChanged: (val) {
                      Utilities.closeKeyboard(context);
                      _.checkValCompostable(val, index);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: onlyPadding(top: 18, bottom: 15),
              child: requestCategoriesTitleText(
                  titleText: AppStrings.non_compostable_categories),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _.babicNonCompostableList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckBoxWithCategories(
                        checkBoxText: _.babicNonCompostableList[index].title,
                        value: _.babicNonCompostableList[index].isChecked,
                        onChanged: (val) {
                          Utilities.closeKeyboard(context);
                          _.checkValNonCompostable(val, index);
                        },
                      ),
                      categoriesDescription(
                        descriptionText:
                            _.babicNonCompostableList[index].description,
                      ),
                    ],
                  );
                }),
            categoriesDescription(
              descriptionText: AppStrings.description_text,
              padding: onlyPadding(left: 0),
            ),
            RichTextCommon(
              firstText: AppStrings.comment,
              secondText: AppStrings.special_instruction,
            ),
            divider(color: AppColor.textFieldTextGrey, height: 2),
            BorderTextFormField(
              maxLine: 6,
              controller: _.commentController,
            ),
          ],
        ),
      ),
    );
  }
}

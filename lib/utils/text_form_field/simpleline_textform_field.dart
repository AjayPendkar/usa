// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/padding_space/padding_margin.dart';

class SimpleLineTextFormField extends StatelessWidget {
  final hintText;
  final controller;
  final validator;
  final keyBoardType;
  final onChanged;
  final textInputAction;
  final onTap;
  final inputFormatter;
  final readOnly;

  SimpleLineTextFormField(
      {this.hintText,
      this.controller,
      this.readOnly,
      this.validator,
      this.textInputAction,
      this.onTap,
      this.inputFormatter,
      this.keyBoardType,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: symmetricPadding(vertical: 7),
      child: TextFormField(
        readOnly: readOnly,
        onTap: onTap,
        maxLines: 2,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        keyboardType: keyBoardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        inputFormatters: inputFormatter,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 17,
              fontFamily: AppStrings.robotoStyleRegular,
              color: AppColor.textFieldTextGrey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyDividerColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyDividerColor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyDividerColor),
          ),
        ),
      ),
    );
  }
}

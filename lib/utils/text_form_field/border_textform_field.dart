import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class BorderTextFormField extends StatelessWidget {
  final maxLine;
  final hintText;
  final controller;
  final validator;
  final onChanged;

  BorderTextFormField(
      {this.maxLine,
      this.hintText,
      this.controller,
      this.validator,
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: onlyPadding(top: 10, bottom: 45),
      child: Container(
        padding: onlyPadding(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.lightSky),
        ),
        child: Padding(
          padding: onlyPadding(left: 10, right: 10),
          child: TextFormField(
            validator: validator,
            onChanged: onChanged,
            maxLines: maxLine,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 17,
                  fontFamily: AppStrings.robotoStyleRegular,
                  color: AppColor.textFieldTextGrey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.greyIconColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

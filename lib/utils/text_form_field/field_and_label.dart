import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class FieldAndLabel extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final onChanged;
  final suffixWidget;
  final key;
  final validator;
  final keyboardType;
  final textInputAction;
  final fillColor;
  final contentPadding;
  final onEditingComplete;
  final focusNode;
  final onTap;

  FieldAndLabel(
      {this.hintText,
      this.contentPadding,
      this.errorText,
      this.controller,
      this.prefixIcon,
      this.onEditingComplete,
      this.focusNode,
      this.onChanged,
      this.suffixWidget,
      this.key,
      this.onTap,
      this.validator,
      this.textInputAction,
      this.keyboardType,
      this.fillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onChanged: onChanged,
        onTap: onTap,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction ?? TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            contentPadding: contentPadding,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            hintText: hintText,
            suffix: suffixWidget,
            hintStyle: AppTextStyle.robotoRegular(
                fontSize: 15, color: AppColor.rowHeaderColor),
            filled: true,
            prefixIcon: prefixIcon,
            fillColor: fillColor),
      ),
    );
  }
}

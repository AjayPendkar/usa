import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class AppTextStyle {
  static TextStyle robotoBold(
      {Color? color,
      double? fontSize,
      double height = 1.0,
      double? decorationThickness,
      double letterSpacing = 0.0}) {
    return TextStyle(
        color: color ?? AppColor.primaryWhite,
        height: height,
        fontSize: fontSize ?? 20,
        fontFamily: AppStrings.robotoStyleBold,
        decorationThickness: decorationThickness);
  }

  static TextStyle robotoRegular(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      double height = 1.0,
      double letterSpacing = 0.0}) {
    return TextStyle(
        color: color ?? AppColor.primaryWhite,
        height: height,
        fontSize: fontSize ?? 20,
        fontFamily: AppStrings.robotoStyleRegular,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  static const regularGrey14 =
      TextStyle(fontSize: 12, color: AppColor.greyTextColor);

  static TextStyle robotoLight(
      {Color? color,
      FontWeight? fontWeight,
      double? fontSize,
      double height = 1.0,
      double letterSpacing = 0.0}) {
    return TextStyle(
        color: color ?? AppColor.primaryWhite,
        height: height,
        fontSize: fontSize ?? 20,
        fontFamily: AppStrings.robotoStyleLight,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  static TextStyle robotoMedium(
      {Color? color,
      FontWeight? fontWeight,
      double? fontSize,
      double height = 1.0,
      double letterSpacing = 0.0}) {
    return TextStyle(
        color: color ?? AppColor.primaryWhite,
        height: height,
        fontSize: fontSize ?? 20,
        fontFamily: AppStrings.robotoStyleMedium,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  //app page padding
  static const appAllPadding15 = EdgeInsets.all(15);
  static const appAllPadding5 = EdgeInsets.all(5);
  static const appAllPadding10 = EdgeInsets.all(10);
  static const appAllPadding20 = EdgeInsets.all(20);
  static const appSymmetricPaddingH10 = EdgeInsets.symmetric(horizontal: 10);
  static const appSymmetricPaddingH15 = EdgeInsets.symmetric(horizontal: 15);
  static const appSymmetricPaddingV10 = EdgeInsets.symmetric(vertical: 10);
  static const appSymmetricPaddingV15 = EdgeInsets.symmetric(vertical: 15);
  static const appSymmetricPaddingV5 = EdgeInsets.symmetric(vertical: 5);

  // Decorations
  static const blackBottomDecoration = BoxDecoration(
    color: AppColor.rowHeaderColor,
    border: Border(bottom: BorderSide(color: AppColor.primaryBlack)),
  );
  static const lightGreyBottomDecoration = BoxDecoration(
    color: AppColor.primaryWhite,
    border: Border(bottom: BorderSide(color: AppColor.greyDividerColor)),
  );

  static final typeHeadDecoration = InputDecoration(
      contentPadding: onlyPadding(left: 10),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      prefixIcon: Icon(
        Icons.search,
        color: AppColor.rowHeaderColor,
      ),
      filled: true,
      fillColor: AppColor.primaryWhite,
      hintText: AppStrings.search);
}

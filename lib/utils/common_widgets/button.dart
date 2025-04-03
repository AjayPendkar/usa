// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class RadiusButton extends StatelessWidget {
  final String? btnText;
  final btnOnTap;
  final Color? btnColor;

  const RadiusButton({this.btnText, this.btnOnTap, this.btnColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: symmetricPadding(vertical: 10),
      child: Container(
        height: Screen.screenHeight * 0.08,
        width: Screen.screenWidth,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: btnColor),
          onPressed: btnOnTap,
          child: Text(btnText.toString(),
              style: AppTextStyle.robotoRegular(
                  fontSize: 15, color: AppColor.primaryWhite)),
        ),
      ),
    );
  }
}

class InAgreementButton extends StatelessWidget {
  final onPressed;
  final String? agreementText;

  const InAgreementButton({Key? key, this.onPressed, this.agreementText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: MaterialButton(
        color: AppColor.sky,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: onPressed,
        child: Text(agreementText.toString(),
            style: AppTextStyle.robotoMedium(
                fontSize: 15, color: AppColor.lightSky)),
      ),
    );
  }
}

Widget textButtonPopUP({onPressed, String? popUpText}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(popUpText.toString(),
        style: AppTextStyle.robotoMedium(
            fontSize: 15, color: AppColor.themeColor)),
  );
}

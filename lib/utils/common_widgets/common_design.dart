import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/view/babric_request/widget/rich_text_widget.dart';
import 'package:myrichardson/view/dashboard/dashboard_screen.dart';
import 'package:myrichardson/view/water/widget/water_text_widget.dart';

class AdditionalInfoBlueText extends StatelessWidget {
  final String? title;

  AdditionalInfoBlueText({this.title});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(),
      child: ListTile(
        title: Text(
          title!,
          maxLines: 5,
          style: AppTextStyle.robotoLight(
              fontSize: 17, color: AppColor.primaryWhite),
          overflow: TextOverflow.ellipsis,
        ),
        tileColor: AppColor.themeColor,
      ),
    );
  }
}

class AcceptReqText extends StatelessWidget {
  final String? descriptionText;
  final double? fontSize;
  final String? call;
  final String? phoneNumber;

  const AcceptReqText(
      {Key? key,
      this.descriptionText,
      this.fontSize,
      this.call,
      this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: descriptionText,
          style: AppTextStyle.robotoRegular(
            fontSize: fontSize,
            color: AppColor.greyTextColor,
          ).copyWith(height: 1.2),
          children: [
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => AppLauncher.launchCaller(Url: call),
                text: phoneNumber,
                style: AppTextStyle.robotoMedium(
                        fontSize: 15, color: AppColor.blueColor)
                    .copyWith(
                  height: 1.2,
                  decoration: TextDecoration.underline,
                ))
          ]),
    );
  }
}

class IconWithDayText extends StatelessWidget {
  final IconData? icon;
  final String? dayText;

  IconWithDayText({this.icon, this.dayText});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: AppTextStyle.appAllPadding5,
        child: Icon(icon, color: AppColor.primaryWhite),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: AppColor.themeColor),
      ),
      title: RichTextCommon(
          firstText: AppStrings.your_day,
          secondText: dayText,
          firstTextStyle: AppTextStyle.robotoRegular(
              fontSize: 14, color: AppColor.greyTextColor),
          secondTextStyle: AppTextStyle.robotoBold(
              fontSize: 14, color: AppColor.greyTextColor)),
    );
  }
}

class GreyTitleContainer extends StatelessWidget {
  final String? title;
  final EdgeInsetsGeometry? padding;

  GreyTitleContainer({this.title, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? symmetricPadding(vertical: 0),
      child: ListTile(
        title: Text(
          title!,
          style: AppTextStyle.robotoBold(
            fontSize: 15,
            color: AppColor.black,
          ),
          // overflow: TextOverflow.ellipsis,
        ),
        tileColor: AppColor.greyDDDD,
      ),
    );
  }
}

Widget tabBarText({String? tabText}) {
  return Text(
    tabText.toString(),
    style: AppTextStyle.robotoMedium(
      color: AppColor.primaryGrey,
      fontSize: 12,
    ),
    textAlign: TextAlign.center,
  );
}

Widget waterTrashRecycleDescription(
    {String? descriptionText, EdgeInsetsGeometry? padding}) {
  return Padding(
    padding: padding ?? AppTextStyle.appAllPadding15,
    child: Text(
      descriptionText.toString(),
      // maxLines: 12,
      style: AppTextStyle.robotoRegular(
          fontSize: 14, color: AppColor.greyTextColor),
      // overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget waterTrashTableHeader({String? keyText, String? valueText}) {
  return Container(
    decoration: BoxDecoration(color: AppColor.rowHeaderColor),
    child: WaterText(
      decoration: AppTextStyle.blackBottomDecoration,
      keyText: keyText,
      valueText: valueText,
      textStyle: AppTextStyle.robotoRegular(
          fontSize: 14, color: AppColor.primaryWhite),
    ),
  );
}

Widget underLineText({String? mainText, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Text(mainText.toString(),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style:
            AppTextStyle.robotoMedium(fontSize: 15, color: AppColor.blueColor)
                .copyWith(
          height: 1.3,
          decoration: TextDecoration.underline,
        )),
  );
}

Widget blackLineText({String? dropText}) {
  return Text(dropText.toString(),
      style: AppTextStyle.robotoBold(
        fontSize: 15,
        color: AppColor.black,
      ).copyWith(
        height: 1.3,
        decoration: TextDecoration.underline,
      ));
}

Widget commonBlackBoldText({String? text}) {
  return Text(
    text.toString(),
    style: AppTextStyle.robotoBold(
      fontSize: 15,
      color: AppColor.black,
    ).copyWith(height: 1.3),
  );
}

Widget greyTextColor({String? greyText, maxLine, double? height}) {
  return Text(greyText.toString(),
      maxLines: maxLine,
      style: AppTextStyle.robotoRegular(
        fontSize: 14,
        color: AppColor.greyTextColor,
      ).copyWith(height: height));
}

Widget waterBottomText({String? descriptionText, maxLine}) {
  return Padding(
    padding: symmetricPadding(vertical: 4, horizontal: 9),
    child: Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Icon(
          Icons.circle,
          size: 7,
        ),
        horizontalSpace(10),
        Flexible(
          child: greyTextColor(greyText: descriptionText, maxLine: maxLine),
        ),
      ],
    ),
  );
}

Widget learnMore({String? learnMoreText, EdgeInsetsGeometry? padding, onTap}) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: padding ?? AppTextStyle.appSymmetricPaddingH15,
              child: Text(
                learnMoreText ?? AppStrings.learn_more,
                style: AppTextStyle.robotoBold(
                    fontSize: 14, color: AppColor.darkBlueColor),
              ),
            )),
      ),
      verticalSpace(5),
    ],
  );
}

Widget myIssueDataNotFound() {
  return Padding(
    padding: symmetricPadding(horizontal: 30),
    child: Center(
      child: Text(
        AppStrings.no_issue_found,
        textAlign: TextAlign.justify,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: AppTextStyle.robotoRegular(
            fontSize: 17, color: AppColor.greyTextColor),
      ),
    ),
  );
}

msgInToast({String? msg, ToastGravity? gravity, Color? backColor}) {
  return Fluttertoast.showToast(
    msg: msg.toString(),
    gravity: gravity ?? ToastGravity.CENTER,
    timeInSecForIosWeb: 3,
    backgroundColor: backColor ?? AppColor.warningColor,
    textColor: AppColor.primaryWhite,
    fontSize: 16.0,
  );
}

Widget commonIconAndBack() {
  return GestureDetector(
      onTap: () {
        Get.offAll(() => DashboardScreen());
      },
      child: Icon(Icons.arrow_back));
}

Widget errorMsg() {
  return Center(
      child: Padding(
    padding: symmetricPadding(vertical: 20),
    child: Text(
      AppStrings.error_msg,
    ),
  ));
}

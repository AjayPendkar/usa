import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myrichardson/model/notification_model.dart';
import 'package:myrichardson/utils/library.dart';

class WarningRichText extends StatelessWidget {
  final NotificationModel? notificationModel;
  final String? warningText;
  final onPressed;

  const WarningRichText(
      {Key? key, this.warningText, this.onPressed, this.notificationModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppStrings.warningIcon,
          height: 26,
        ),
        horizontalSpace(10),
        Expanded(
          child: RichText(
              // maxLines: 3,
              // overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.start,
              text: TextSpan(
                  style: AppTextStyle.robotoMedium(
                          fontSize: 13, color: AppColor.primaryWhite)
                      .copyWith(height: 1.5),
                  text: warningText,
                  //  "est_chakra/.pub-cache/hosted/pub.dartlang.org/location-4.4.0/android/src/mosted/pub.dartlang.org/location-4.4.0/android/src/maincache/hosted/pub.dartlang.org/location-4.4.0/android/src/main/java/com/lyokone/location/FlutterLocation.java uses or overrides a deprecated API.",
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            // AppLauncher.launchURL(url: WebUrl.notificationUrl),
                            notificationModel!.url == null ||
                                    notificationModel!.url!.length == 0
                                ? null
                                : AppLauncher.launchURL(
                                    url: notificationModel!.url),
                      text: notificationModel!.url == null ||
                              notificationModel!.url!.length == 0
                          ? ""
                          : "...." + AppStrings.read_more,
                      style: AppTextStyle.robotoMedium(
                          fontSize: 13, color: AppColor.primaryWhite),
                    )
                  ])),
        ),
        Padding(
          padding: onlyPadding(
            bottom: 40,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.clear,
                color: AppColor.primaryWhite,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

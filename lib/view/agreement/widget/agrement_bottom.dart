import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/dashboard/dashboard_screen.dart';

class AgreementBottom extends StatelessWidget {
  const AgreementBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: onlyPadding(left: 15, right: 19, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Spacer(),
          InAgreementButton(
              onPressed: () {
                AppPreference.set(AppStrings.agreement, true);
                Get.offAll(() => DashboardScreen());
              },
              agreementText: AppStrings.agree),
          horizontalSpace(13),
          InAgreementButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
              agreementText: AppStrings.cancel),
        ],
      ),
    );
  }
}

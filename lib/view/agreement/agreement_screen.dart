import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/constants/colors_constant.dart';
import 'package:myrichardson/controller/agreement_controller.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/web_url/allweb_url_link.dart';
import 'package:myrichardson/view/agreement/widget/agrement_bottom.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Agreement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primaryWhite,
        body: GetBuilder<AgreementController>(
          init: AgreementController(),
          builder: (_) => Column(
            children: [
              Expanded(
                flex: 30,
                child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: WebUrl.agreementUrl,
                ),
              ),
              Spacer(),
              AgreementBottom(),
            ],
          ),
        ),
      ),
    );
  }
}

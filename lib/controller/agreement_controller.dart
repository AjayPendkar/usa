import 'dart:io';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AgreementController extends GetxController{
  // ignore: must_call_super
  void onInit() {
    super.onInit();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

}
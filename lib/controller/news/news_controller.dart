import 'dart:io';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsController extends GetxController {

  void onInit() {
    super.onInit();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
}

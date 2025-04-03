import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/news/news_controller.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/web_url/allweb_url_link.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TitleAppBar(
          icon: commonIconAndBack(),
          title: AppStrings.news_,
        ),
        body: Container(
          margin: AppTextStyle.appSymmetricPaddingH15,
          child: GetBuilder<NewsController>(
            init: NewsController(),
            builder: (_) => Column(
              children: [
                Expanded(
                  flex: 9,
                  child: WebView(
                    initialUrl: WebUrl.newsUrl,
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageStarted: (start) {
                      // showLoadingIndicator();
                    },
                    onPageFinished: (finish) {
                      // hideLoadingIndicator();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

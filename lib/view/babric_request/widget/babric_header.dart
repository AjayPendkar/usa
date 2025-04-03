import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/web_url/allweb_url_link.dart';

class BABICHeader extends StatelessWidget {
  BABICHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightGrey,
      child: Padding(
        padding: symmetricPadding(horizontal: 21),
        child: _buildHeader(),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: onlyPadding(top: 22, bottom: 21),
          child: Text(
            AppStrings.BBIC_name,
            style: AppTextStyle.robotoBold(
                color: AppColor.primaryGrey, fontSize: 17),
          ),
        ),
        Text(
          AppStrings.BBIC_discription,
          style: AppTextStyle.robotoRegular(
              fontSize: 14, color: AppColor.grey, height: 1.5),
          textAlign: TextAlign.start,
        ),
        learnMore(
          onTap: () {
            AppLauncher.launchURL(url: WebUrl.babicUrl);
          },
          padding: onlyPadding(top: 20, bottom: 10),
        ),
        learnMore(
          onTap: () {
            AppLauncher.launchURL(url: WebUrl.acceptableMaterial);
          },
          learnMoreText: AppStrings.acceptable_material,
          padding: onlyPadding(bottom: 20),
        ),
      ],
    );
  }
}

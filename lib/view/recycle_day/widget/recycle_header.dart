import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/web_url/allweb_url_link.dart';

class RecycleHeader extends StatelessWidget {
  final String? recycleDesc;
  final String? learnText;
  final String? day;

  RecycleHeader({this.recycleDesc, this.learnText, this.day});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconWithDayText(
          dayText: day,
          icon: Icons.api,
        ),
        divider(
          height: 2,
          color: AppColor.greyDividerColor,
          thickness: 1,
        ),
        waterTrashRecycleDescription(
          descriptionText: recycleDesc,
        ),
        learnMore(
          learnMoreText: learnText,
          onTap: () {
            AppLauncher.launchURL(url: WebUrl.recycleUrl);
          },
        ),
      ],
    );
  }
}

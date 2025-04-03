import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/web_url/allweb_url_link.dart';

class TrashHeader extends StatelessWidget {
  final String? trashDesc;
  final String? learnText;
  final String? day;

  TrashHeader({this.trashDesc, this.learnText, this.day});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconWithDayText(
          dayText: day,
          icon: Icons.delete,
        ),
        divider(
          height: 2,
          color: AppColor.greyDividerColor,
          thickness: 1,
        ),
        waterTrashRecycleDescription(
          descriptionText: trashDesc,
        ),
        learnMore(
          learnMoreText: learnText,
          onTap: () => AppLauncher.launchURL(url: WebUrl.trashUrl),
        ),
      ],
    );
  }
}

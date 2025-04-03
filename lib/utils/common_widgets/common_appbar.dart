import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class TitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? showAction;
  final Widget? action;
  final onTap;
  final icon;
  final Image? image;

  const TitleAppBar(
      {Key? key,
      this.title,
      this.action,
      this.onTap,
      this.icon,
      this.image,
      this.showAction = false})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.themeColor,
      leading: icon,
      title: image ??
          Text(
            title.toString(),
            style: AppTextStyle.robotoRegular(
                fontSize: 17, color: AppColor.primaryWhite),
          ),
      actions: [
        Center(
            child: Padding(
          padding: onlyPadding(right: 15),
          child: showAction!
              ? GestureDetector(
                  onTap: onTap,
                  child: action ??
                      Text(
                        'Submit',
                        style: AppTextStyle.robotoRegular(
                            fontSize: 15, color: AppColor.primaryWhite),
                      ),
                )
              : null,
        ))
      ],
      centerTitle: true,
    );
  }
}

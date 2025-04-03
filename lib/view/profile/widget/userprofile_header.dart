import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.user_profile,
            style: AppTextStyle.robotoBold(
              color: AppColor.userTextGrey,
              fontSize: 20,
            )),
        verticalSpace(15),
        Text(AppStrings.userProfile_description,
            style: AppTextStyle.robotoRegular(
                fontSize: 15, color: AppColor.grey, height: 1.4)),
        verticalSpace(10),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myrichardson/utils/library.dart';

class CheckBoxWithCategories extends StatelessWidget {
  final value;
  final onChanged;
  final String? checkBoxText;

  const CheckBoxWithCategories(
      {Key? key, this.value, this.onChanged, this.checkBoxText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 32,
          child: Checkbox(
            tristate: false,
            value: value,
            onChanged: onChanged,
            side: BorderSide(
              color: AppColor.rowHeaderColor,
              width: 1,
            ),
          ),
        ),
        horizontalSpace(10),
        Text(
          checkBoxText.toString(),
          style: AppTextStyle.robotoMedium(
            fontSize: 15,
            color: AppColor.darkBlueColor,
          ),
        ),
      ],
    );
  }
}

Widget categoriesDescription({
  String? descriptionText,
  EdgeInsetsGeometry? padding,
}) {
  return Padding(
    padding: padding ?? onlyPadding(left: 30),
    child: Text(
      descriptionText.toString(),
      softWrap: true,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.justify,
      style: AppTextStyle.robotoRegular(
          fontSize: 13, color: AppColor.grey, height: 1.4),
    ),
  );
}

Widget requestCategoriesTitleText({String? titleText}) {
  return Text(
    titleText.toString(),
    style: AppTextStyle.robotoBold(color: AppColor.darkBlueColor, fontSize: 17),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/contact_us/contact_us_controller.dart';
import 'package:myrichardson/model/contact_us_model.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/view/contact_us/widget/simple_text_divider.dart';

class ContactDetails extends StatefulWidget {
  final Contact? contact;

  ContactDetails({Key? key, this.contact}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ContactController>(
        init: ContactController(),
        builder: (_) => Scaffold(
          appBar: TitleAppBar(title: widget.contact!.department!),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: Screen.screenHeight * 0.22,
                  padding: onlyPadding(left: 12, bottom: 31),
                  color: AppColor.BlueColor,
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(widget.contact!.department!,
                          style: AppTextStyle.robotoMedium(
                              fontSize: 26, color: AppColor.primaryWhite))),
                ),
                SimpleTextDivider(
                    decoration: TextDecoration.underline,
                    text: AppStrings.phoneNumber,
                    dataText: widget.contact!.phoneNumber,
                    onTap: () {
                      AppLauncher.launchCaller(
                          Url: widget.contact!.phoneNumber);
                    }),
                SimpleTextDivider(
                    decoration: TextDecoration.underline,
                    text: AppStrings.faxNumber,
                    secondText: widget.contact!.faxNumber!.isEmpty
                        ? Text("   --")
                        : Text(widget.contact!.faxNumber!,
                            style: AppTextStyle.robotoMedium(
                                fontSize: 18, color: AppColor.blueColor))),
                SimpleTextDivider(
                    decoration: widget.contact!.email!.isEmpty
                        ? TextDecoration.none
                        : TextDecoration.underline,
                    text: AppStrings.email_contact,
                    dataText: widget.contact!.email!.isEmpty
                        ? "  --"
                        : widget.contact!.email,
                    onTap: () {
                      widget.contact!.email!.isEmpty
                          // ignore: unnecessary_statements
                          ? "--"
                          : AppLauncher.launchEmail(
                              email: widget.contact!.email);
                    }),
                SimpleTextDivider(
                    decoration: TextDecoration.underline,
                    text: AppStrings.website,
                    dataText: AppStrings.visit_website,
                    onTap: () {
                      AppLauncher.launchURL(url: widget.contact!.website);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

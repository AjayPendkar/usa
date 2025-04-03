import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/contact_us/contact_us_controller.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/view/contact_us/contact_us_details.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactController>(
      init: ContactController(),
      builder: (_) => SafeArea(
        child: Scaffold(
          appBar: TitleAppBar(
              icon: commonIconAndBack(), title: AppStrings.contact_us),
          body: _.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: _.contactList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ContactDetails(
                              contact: _.contactList[index],
                            ));
                      },
                      child: Padding(
                        padding: allPadding(18),
                        child: Text(
                          _.contactList[index].department!,
                          style: AppTextStyle.robotoMedium(
                              fontSize: 16, color: AppColor.blackTextColor),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/babric/babric_controller.dart';
import 'package:myrichardson/utils/date_format/date_formated.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/view/babric_request/widget/request_accept_form.dart';

class RequestAcceptable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleAppBar(
        icon: commonIconAndBack(),
        title: AppStrings.BBIC_request_accepted,
      ),
      body: Padding(
        padding: symmetricPadding(horizontal: 15),
        child: GetBuilder<BBICController>(
            init: BBICController(),
            builder: (_) {
              return _.babic?.orderNumber == null
                  ? Center(child: CircularProgressIndicator())
                  : _.babic?.orderNumber == AppStrings.duplicate
                      ? Padding(
                          padding: symmetricPadding(
                            vertical: 30,
                          ),
                          child: AcceptReqText(
                              call: AppStrings.call,
                              phoneNumber: AppStrings.call,
                              descriptionText:
                                  "${AppStrings.request_duplic} ${_.babic?.pickupDate ?? ''} ${AppStrings.request_last_duplic}",
                              fontSize: 16),
                        )
                      : _.babic?.orderNumber == AppStrings.commercial
                          ? Padding(
                              padding: AppTextStyle.appSymmetricPaddingV15,
                              child: AcceptReqText(
                                  call: AppStrings.call,
                                  phoneNumber: AppStrings.call,
                                  descriptionText:
                                      AppStrings.request_commercial,
                                  fontSize: 16))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.request_accepted,
                                  style: AppTextStyle.robotoBold(
                                          color: AppColor.blueColor,
                                          fontSize: 28)
                                      .copyWith(height: 2.5),
                                ),
                                Padding(
                                  padding: AppTextStyle.appSymmetricPaddingV15,
                                  child: AcceptReqText(
                                      call: AppStrings.call,
                                      phoneNumber: AppStrings.call,
                                      descriptionText: AppStrings.request_desc,
                                      fontSize: 14),
                                ),
                                verticalSpace(10),
                                RequestFrom(
                                    title: AppStrings.order_number,
                                    subtitle: _.babic?.orderNumber ?? ''),
                                RequestFrom(
                                    title: AppStrings.pickup_address,
                                    subtitle: _.babic?.pickupAddress ?? ''),
                                RequestFrom(
                                  title: AppStrings.pickup_date,
                                  subtitle: cstToNormalDateConvert(
                                      datePass: _.babic?.pickupDate ?? ''),
                                ),
                              ],
                            );
            }),
      ),
    );
  }
}

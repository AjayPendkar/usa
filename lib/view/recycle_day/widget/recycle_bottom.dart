import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/recycle_day/recycle_controller.dart';
import 'package:myrichardson/utils/library.dart';

class RecycleBottom extends StatelessWidget {
  const RecycleBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecycleController>(
      init: RecycleController(),
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(20),
          AdditionalInfoBlueText(title: AppStrings.additional_info),
          GreyTitleContainer(
            title: AppStrings.accepted_materials,
          ),
          Padding(
            padding: AppTextStyle.appAllPadding15,
            child: Text(
              "${_.recycleList!.additionalInformation!.acceptableMaterials!.text}",
              style: AppTextStyle.robotoRegular(
                  fontSize: 15, color: AppColor.greyTextColor),
            ),
          ),
          for (int i = 0;
              i <
                  _.recycleList!.additionalInformation!.acceptableMaterials!
                      .materials!.length;
              i++)
            Padding(
              padding: symmetricPadding(vertical: 5, horizontal: 15),
              child: greyTextColor(
                  greyText:
                      '* ${_.recycleList!.additionalInformation!.acceptableMaterials!.materials![i]}'),
            ),
          verticalSpace(10),
          GreyTitleContainer(
            title: AppStrings.purchase_bag,
          ),
          Padding(
            padding: onlyPadding(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(15),
                commonBlackBoldText(
                    text: _.recycleList!.additionalInformation!.purchaseBags!
                        .trashBags!.label!),
                waterTrashRecycleDescription(
                  descriptionText: _.recycleList!.additionalInformation!
                      .purchaseBags!.trashBags!.text,
                  padding: onlyPadding(left: 0, top: 15, bottom: 12, right: 15),
                ),
                commonBlackBoldText(
                    text: _.recycleList!.additionalInformation!.purchaseBags!
                        .blueBags!.label!),
                waterTrashRecycleDescription(
                  descriptionText: _.recycleList!.additionalInformation!
                      .purchaseBags!.blueBags!.text,
                  padding: onlyPadding(left: 0, top: 15, bottom: 12, right: 15),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _.recycleList!.additionalInformation!
                        .purchaseBags!.links!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: onlyPadding(
                              top: 10,
                            ),
                            child: commonBlackBoldText(
                                text: _.recycleList!.additionalInformation!
                                    .purchaseBags!.links![index].location),
                          ),
                          Row(
                            children: [
                              underLineText(
                                mainText: _.recycleList!.additionalInformation!
                                    .purchaseBags!.links![index].address!,
                                onTap: () {
                                  AppLauncher.launchURL(
                                      url: _.recycleList!.additionalInformation!
                                          .purchaseBags!.links![index].url);
                                },
                              ),
                              (_.recycleList!.additionalInformation!
                                          .purchaseBags!.links![index].city !=
                                      null)
                                  ? Text(_.recycleList!.additionalInformation!
                                      .purchaseBags!.links![index].city
                                      .toString())
                                  : Container(),
                            ],
                          ),
                          underLineText(
                            mainText: _.recycleList!.additionalInformation!
                                .purchaseBags!.links![index].phone!,
                            onTap: () {
                              AppLauncher.launchCaller(
                                  Url: _.recycleList!.additionalInformation!
                                      .purchaseBags!.links![index].phone!);
                            },
                          ),
                        ],
                      );
                    }),
                verticalSpace(30),
                waterTrashRecycleDescription(
                    padding: onlyPadding(
                      left: 0,
                      bottom: 5,
                    ),
                    descriptionText: _.recycleList!.additionalInformation!
                        .purchaseBags!.blueBagsCost!.text),
                for (int i = 0;
                    i <
                        _.recycleList!.additionalInformation!.purchaseBags!
                            .blueBagsCost!.costs!.length;
                    i++)
                  Padding(
                    padding: onlyPadding(left: 50, top: 3),
                    child: greyTextColor(
                        greyText:
                            '*  ${_.recycleList!.additionalInformation!.purchaseBags!.blueBagsCost!.costs![i]}'),
                  ),
              ],
            ),
          ),
          verticalSpace(15),
          GreyTitleContainer(
            title: AppStrings.dropOffCenters,
          ),
        ],
      ),
    );
  }
}

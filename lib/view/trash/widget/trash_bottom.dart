import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/trash/trash_controller.dart';
import 'package:myrichardson/utils/library.dart';

class TrashBottom extends StatelessWidget {
  const TrashBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrashController>(
      init: TrashController(),
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdditionalInfoBlueText(title: AppStrings.additional_info),
          GreyTitleContainer(
            title: AppStrings.collection_point,
          ),
          waterTrashRecycleDescription(
            descriptionText:
                _.trashList!.additionalInformation!.collectionPoint,
          ),
          GreyTitleContainer(
            title: AppStrings.setOutTime,
          ),
          waterTrashRecycleDescription(
            descriptionText: _.trashList!.additionalInformation!.setOutTime,
          ),
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
                    text: _.trashList!.additionalInformation!.purchaseBags!
                        .trashBags!.label!),
                waterTrashRecycleDescription(
                  descriptionText: _.trashList!.additionalInformation!
                      .purchaseBags!.trashBags!.text,
                  padding: onlyPadding(left: 0, top: 15, bottom: 12, right: 15),
                ),
                commonBlackBoldText(
                    text: _.trashList!.additionalInformation!.purchaseBags!
                        .blueBags!.label!),
                waterTrashRecycleDescription(
                  descriptionText: _.trashList!.additionalInformation!
                      .purchaseBags!.blueBags!.text,
                  padding: onlyPadding(left: 0, top: 15, bottom: 12, right: 15),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _.trashList!.additionalInformation!.purchaseBags!
                        .links!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: onlyPadding(
                              top: 10,
                            ),
                            child: commonBlackBoldText(
                                text: _.trashList!.additionalInformation!
                                    .purchaseBags!.links![index].location),
                          ),
                          underLineText(
                              mainText: _.trashList!.additionalInformation!
                                  .purchaseBags!.links![index].address!,
                              onTap: () {
                                AppLauncher.launchURL(
                                    url: _.trashList!.additionalInformation!
                                        .purchaseBags!.links![index].url);
                              }),
                          if (_.trashList!.additionalInformation!.purchaseBags!
                                      .links![index].city !=
                                  null &&
                              _.trashList!.additionalInformation!.purchaseBags!
                                      .links![index].city!.length >
                                  0)
                            Text(
                              _.trashList!.additionalInformation!.purchaseBags!
                                  .links![index].city!,
                            ),
                          underLineText(
                            mainText: _.trashList!.additionalInformation!
                                .purchaseBags!.links![index].phone!,
                            onTap: () {
                              AppLauncher.launchCaller(
                                  Url: _.trashList!.additionalInformation!
                                      .purchaseBags!.links![index].phone!);
                            },
                          ),
                        ],
                      );
                    }),
                verticalSpace(30),
                waterTrashRecycleDescription(
                    padding: onlyPadding(left: 0, bottom: 5),
                    descriptionText: _.trashList!.additionalInformation!
                        .purchaseBags!.blueBagsCost!.text),
                for (int i = 0;
                    i <
                        _.trashList!.additionalInformation!.purchaseBags!
                            .blueBagsCost!.costs!.length;
                    i++)
                  Padding(
                    padding: onlyPadding(left: 50, top: 3),
                    child: greyTextColor(
                        greyText:
                            '*  ${_.trashList!.additionalInformation!.purchaseBags!.blueBagsCost!.costs![i]}'),
                  ),
              ],
            ),
          ),
          verticalSpace(15),
          GreyTitleContainer(
            title: AppStrings.householdHazardousWaste,
          ),
          waterTrashRecycleDescription(
            descriptionText: _.trashList!.additionalInformation!
                .householdHazardousWaste!.text,
          ),
          Padding(
            padding: onlyPadding(left: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonBlackBoldText(
                    text: _.trashList!.additionalInformation!
                        .householdHazardousWaste!.links![0].location),
                underLineText(
                    mainText: _.trashList!.additionalInformation!
                        .householdHazardousWaste!.links![0].address,
                    onTap: () {
                      AppLauncher.launchURL(
                          url: _.trashList!.additionalInformation!
                              .householdHazardousWaste!.links![0].url);
                    }),
                Text(_.trashList!.additionalInformation!
                    .householdHazardousWaste!.links![0].city
                    .toString()),
                underLineText(
                  mainText: _.trashList!.additionalInformation!
                      .householdHazardousWaste!.links![0].phone!,
                  onTap: () {
                    AppLauncher.launchCaller(
                        Url: _.trashList!.additionalInformation!.purchaseBags!
                            .links![0].phone!);
                  },
                )
              ],
            ),
          ),
          verticalSpace(10),
          GreyTitleContainer(
            title: AppStrings.dropOffCenters,
          ),
        ],
      ),
    );
  }
}

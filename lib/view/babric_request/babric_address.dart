import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/Address/address_controller.dart';
import 'package:myrichardson/controller/babric/babric_controller.dart';
import 'package:myrichardson/model/address_model.dart';
import 'package:myrichardson/routes/app_routes.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/loader.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/dashboard/dashboard_screen.dart';
import 'package:myrichardson/view/profile/user_profile.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SearchAddressBabric extends StatelessWidget {
  SearchAddressBabric({Key? key}) : super(key: key);
  final userAddress = Get.put(BBICController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
        init: AddressController(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: GestureDetector(
                  onTap: () {
                    AppPreference.getBool(AppStrings.address_screen_back)
                        ? Get.offAll(() => DashboardScreen())
                        : Get.back();
                    _.isClicked = false;
                    _.add = null;
                    _.controller.clear();
                  },
                  child: Icon(Icons.arrow_back)),
              backgroundColor: AppColor.themeColor,
              title: Text(
                AppStrings.Select_address,
                style: AppTextStyle.robotoRegular(
                    fontSize: 17, color: AppColor.primaryWhite),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: Padding(
                  padding: allPadding(12),
                  child: TypeAheadField<Address>(
                    suggestionsBoxController: _.suggestionsBoxController,
                    noItemsFoundBuilder: (context) => Container(),
                    getImmediateSuggestions: true,
                    textFieldConfiguration: TextFieldConfiguration(
                      textInputAction: TextInputAction.next,
                      controller: _.controller,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[0-9a-zA-Z " "]')),
                      ],
                      onChanged: (value) {
                        // _.getAddress(value);
                        _.isClicked = false;
                      },
                      decoration: AppTextStyle.typeHeadDecoration,
                    ),
                    suggestionsCallback: (pattern) async {
                      if (pattern.isEmpty) {
                        hideLoadingIndicator();
                        return <Address>[];
                      }
                      return _.getAddress(pattern);
                    },
                    itemBuilder: (context, Address suggestion) {
                      print(
                          "suggestionsCallback itemBuilder ${suggestion.fullStreetAddress}");
                      return suggestion.type == null
                          ? ListTile(
                              title: SubstringHighlight(
                                textStyleHighlight: AppTextStyle.robotoRegular(
                                    color: AppColor.black, fontSize: 15),
                                text: suggestion.fullStreetAddress.toString(),
                                term: _.controller.text,
                              ),
                            )
                          : Container();
                    },
                    onSuggestionSelected: (
                      Address suggestion,
                    ) {
                      _.isClicked = true;
                      _.controller.text =
                          suggestion.fullStreetAddress.toString();
                      userAddress.selectAddress = suggestion;

                      AppPreference.set(
                          AppStrings.textOwnerName, suggestion.taxOwnerName);
                      AppPreference.set(
                          AppStrings.utilityId, suggestion.utilityId);
                      AppPreference.set(
                          AppStrings.locationId, suggestion.landLocationId);

                      if (AppPreference.getBool(AppStrings.fixAddressStore))
                        Get.toNamed(Routes.BBICCollection,
                            arguments: userAddress.selectAddress);

                      AppPreference.set(AppStrings.section_code,
                          suggestion.sectionCode.toString());

                      _.setSelectedAddress(
                          suggestion.fullStreetAddress.toString());
                    },
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: AppTextStyle.appAllPadding20,
              child: Column(
                children: [
                  Text(
                    AppStrings.address_detail,
                    style: AppTextStyle.robotoRegular(
                        fontSize: 15, color: AppColor.greyTextColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(20),
                  AppPreference.getBool(AppStrings.address_search_button) ||
                          AppPreference.getBool(AppStrings.dashboard)
                      ? RadiusButton(
                          btnText:
                              "${_.add == null ? '' : AppStrings.USE} ${AppPreference.getBool(AppStrings.fixAddressStore) ? AppPreference.getString(AppStrings.address) : _.add != null ? _.add.toString() : AppStrings.Select_address}",
                          btnColor: AppColor.buttonBlue,
                          btnOnTap: () {
                            _.add = null;
                            if (AppPreference.getBool(
                                AppStrings.address_selectNavigation)) {
                              Get.toNamed(
                                Routes.BBICCollection,
                              );
                            } else {
                              _.isClicked == false
                                  ? msgInToast(
                                      msg: AppStrings.selectAddress,
                                      gravity: ToastGravity.SNACKBAR)
                                  : Get.to(() => UserProfile(),
                                      arguments: _.controller.text);
                            }
                            _.isClicked = false;
                          })
                      : Container()
                ],
              ),
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:myrichardson/controller/Address/address_controller.dart';
import 'package:myrichardson/controller/babric/babric_controller.dart';
import 'package:myrichardson/controller/dashboard/water_trash_recycle_controller.dart';
import 'package:myrichardson/routes/app_routes.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/dashboard/dashboard_screen.dart';
import 'package:myrichardson/view/profile/widget/userprofile_header.dart';

class UserProfile extends StatefulWidget {
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var userSelectValue = Get.arguments;

  final formKey = GlobalKey<FormState>();

  final clear = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BBICController>(
        init: BBICController(),
        builder: (_) {
          _.addressController.text =
              userSelectValue ?? AppPreference.getString(AppStrings.address);
          return SafeArea(
            child: Scaffold(
              appBar: TitleAppBar(
                icon: commonIconAndBack(),
                title: AppStrings.user_profile,
              ),
              body: Padding(
                padding: symmetricPadding(horizontal: 21, vertical: 24),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserProfileHeader(),
                        SimpleLineTextFormField(
                          readOnly: false,
                          validator: validateName,
                          controller: _.nameController,
                          onChanged: (val) {
                            // formKey.currentState!.validate();
                            _.name = val;
                          },
                          textInputAction: TextInputAction.next,
                          hintText: AppStrings.name,
                        ),
                        SimpleLineTextFormField(
                          readOnly: false,
                          textInputAction: TextInputAction.next,
                          validator: validateEmail,
                          onChanged: (val) {
                            //formKey.currentState!.validate();
                            _.email = val;
                          },
                          controller: _.emailController,
                          hintText: AppStrings.email,
                        ),
                        SimpleLineTextFormField(
                          readOnly: false,
                          textInputAction: TextInputAction.next,
                          controller: _.phoneController,
                          onChanged: (val) {
                            // formKey.currentState!.validate();
                            _.phone = val;
                          },
                          keyBoardType: TextInputType.phone,
                          validator: validatePhone,
                          inputFormatter: [
                            MaskTextInputFormatter(
                              mask: AppStrings.phoneNumber_format,
                            )
                          ],
                          hintText: AppStrings.phone,
                        ),
                        Stack(
                          children: [
                            SimpleLineTextFormField(
                              readOnly: false,
                              textInputAction: TextInputAction.next,
                              validator: validateAddress,
                              onTap: () {
                                _.addressController.clear();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                AppPreference.set(
                                    AppStrings.address_search_button, true);
                                AppPreference.set(
                                    AppStrings.fixAddressStore, false);
                                clear.controller.clear();
                                Get.toNamed(Routes.SearchAddressBabric);
                              },
                              onChanged: (val) {
                                //  formKey.currentState!.validate();
                                _.address = val;
                              },
                              controller: _.addressController,
                              // controller: _.addressController =
                              //     TextEditingController(
                              //         text: userSelectValue ??
                              //             AppPreference.getString(
                              //                 AppStrings.address)),
                              hintText: AppStrings.address,
                            ),
                            Positioned(
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: InkWell(
                                    onTap: () {
                                      _.addressController.clear();
                                      userSelectValue = null;
                                      AppPreference.set(
                                          AppStrings.dashboard, false);
                                      AppPreference.set(
                                          AppStrings.address, null);
                                    },
                                    child: Icon(Icons.delete)))
                          ],
                        ),
                        verticalSpace(45),
                        RadiusButton(
                          btnText: AppStrings.submit,
                          btnOnTap: () async {
                            if (_.nameController.text.trim().isEmpty &&
                                _.emailController.text.trim().isEmpty &&
                                _.phoneController.text.trim().isEmpty &&
                                _.addressController.text.trim().isEmpty) {
                              AppPreference.set(AppStrings.name,
                                  _.nameController.text.trim());
                              AppPreference.set(AppStrings.email,
                                  _.emailController.text.trim());
                              AppPreference.set(AppStrings.phone,
                                  _.phoneController.text.trim());
                              AppPreference.set(AppStrings.address,
                                  _.addressController.text.trim());
                              AppPreference.set(AppStrings.dashboard, false);
                              Get.offAll(
                                DashboardScreen(),
                              );
                            }
                            //  else if (formKey.currentState!.validate()) {
                            //   AppPreference.set(
                            //       AppStrings.name, _.nameController.text);
                            //   AppPreference.set(
                            //       AppStrings.email, _.emailController.text);
                            //   AppPreference.set(
                            //       AppStrings.phone, _.phoneController.text);
                            //   AppPreference.set(
                            //       AppStrings.address, _.addressController.text);
                            //   AppPreference.set(AppStrings.dashboard, true);
                            //   Get.offAll(
                            //     DashboardScreen(),
                            //   );
                            // }
                            if (_.nameController.text.trim().isNotEmpty &&
                                validateName(_.nameController.text.trim()) !=
                                    null) {
                              return;
                            } else {
                              AppPreference.set(AppStrings.name,
                                  _.nameController.text.trim());
                            }
                            if (_.emailController.text.trim().isNotEmpty &&
                                validateEmail(_.emailController.text.trim()) !=
                                    null) {
                              return;
                            } else {
                              AppPreference.set(AppStrings.email,
                                  _.emailController.text.trim());
                            }
                            if (_.phoneController.text.trim().isNotEmpty &&
                                validatePhone(_.phoneController.text.trim()) !=
                                    null) {
                              return;
                            } else {
                              AppPreference.set(AppStrings.phone,
                                  _.phoneController.text.trim());
                            }
                            if (_.addressController.text.trim().isNotEmpty &&
                                validateAddress(
                                        _.addressController.text.trim()) !=
                                    null) {
                              return;
                            } else {
                              AppPreference.set(AppStrings.dashboard, true);
                              AppPreference.set(AppStrings.address,
                                  _.addressController.text.trim());
                            }

                            if (_.addressController.text.trim().isEmpty) {
                              AppPreference.set(AppStrings.dashboard, false);
                            } else {
                              AppPreference.set(AppStrings.dashboard, true);
                            }

                            await WaterTrashRecycleController().getData();

                            Get.offAll(
                              DashboardScreen(),
                            );

                            _.onSave();
                          },
                          btnColor: AppColor.buttonBlue,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

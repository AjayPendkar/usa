import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:myrichardson/controller/Address/address_controller.dart';
import 'package:myrichardson/controller/babric/babric_controller.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/babric_request/widget/babric_bottom.dart';
import 'package:myrichardson/view/babric_request/widget/babric_header.dart';

class BABICRequestScreen extends StatefulWidget {
  @override
  State<BABICRequestScreen> createState() => _BABICRequestScreenState();
}

class _BABICRequestScreenState extends State<BABICRequestScreen> {
  final formKey = GlobalKey<FormState>();

  var bbaricAddress = Get.arguments;

  final clear = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    print("bbaricAddress ${bbaricAddress?.fullStreetAddress}");
    print("bbaricAddress #1 ${AppPreference.getString(AppStrings.address)}");

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: TitleAppBar(
          icon: GestureDetector(
              onTap: () {
                clear.controller.clear();
                Get.back();
              },
              child: Icon(Icons.arrow_back)),
          title: AppStrings.BBIC_request,
        ),
        body: SingleChildScrollView(
          child: GetBuilder<BBICController>(
            init: BBICController(),
            builder: (_) => Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BABICHeader(),
                  divider(
                      color: AppColor.lightGreyTextColor,
                      height: 3,
                      thickness: 1.5),
                  Padding(
                    padding: symmetricPadding(horizontal: 15, vertical: 29),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.enter_pickUp_location,
                          style: AppTextStyle.robotoBold(
                            color: AppColor.lightBLue,
                            fontSize: 22,
                          ),
                        ),
                        verticalSpace(10),
                        SimpleLineTextFormField(
                          readOnly: false,
                          validator: validateName1,
                          controller: _.nameController,
                          onChanged: (val) {
                            formKey.currentState!.validate();
                            _.name = val;
                          },
                          textInputAction: TextInputAction.next,
                          hintText: AppStrings.name,
                        ),
                        SimpleLineTextFormField(
                          readOnly: false,
                          textInputAction: TextInputAction.next,
                          validator: validateEmail1,
                          onChanged: (val) {
                            formKey.currentState!.validate();
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
                            formKey.currentState!.validate();
                            _.phone = val;
                          },
                          validator: validatePhone1,
                          inputFormatter: [
                            MaskTextInputFormatter(
                              mask: AppStrings.phoneNumber_format,
                            )
                          ],
                          keyBoardType: TextInputType.phone,
                          hintText: AppStrings.phone,
                        ),
                        SimpleLineTextFormField(
                          readOnly: true,
                          textInputAction: TextInputAction.next,
                          validator: validateAddress1,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          onChanged: (val) {
                            formKey.currentState!.validate();
                            _.address = val;
                          },
                          controller: _.addressController =
                              TextEditingController(
                                  text: bbaricAddress?.fullStreetAddress ??
                                      AppPreference.getString(
                                          AppStrings.address)),
                          hintText: AppStrings.address,
                        ),
                      ],
                    ),
                  ),
                  BABICBottom(),
                  Padding(
                    padding: symmetricPadding(horizontal: 15, vertical: 10),
                    child: RadiusButton(
                      btnText: AppStrings.submit_request,
                      btnColor: AppColor.buttonBlue,
                      btnOnTap: () {
                        if (formKey.currentState!.validate()
                            // ||
                            //     _.nameController.text.isEmpty ||
                            //     _.emailController.text.isEmpty ||
                            //     _.phoneController.text.isEmpty
                            ) {
                          _.getBabric();
                        } else {
                          _.onSave();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

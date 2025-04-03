import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/new_issue/new_issue_controller.dart';
import 'package:myrichardson/model/issue_type_model.dart';
import 'package:myrichardson/routes/app_routes.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/new_issue/widget/alert_dialog.dart';
import 'package:myrichardson/view/new_issue/widget/select_imge.dart';
import 'package:path/path.dart';
import 'widget/issue_form_title.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';


class NewIssueScreen extends StatefulWidget {
  @override
  State<NewIssueScreen> createState() => _NewIssueScreenState();
}

class _NewIssueScreenState extends State<NewIssueScreen> {
  var location = Get.arguments;

  var formKey = GlobalKey<FormState>();

  var _selected;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewIssueController>(
        init: NewIssueController(),
        builder: (_) {
           var i = 0;
          List<String> arr = [];
          while (i < _.issueTypeList.length) {

            // var currentElement = _.issueTypeList[i];
            arr.add(_.issueTypeList[i].issueType as String);

            i++;
          }
          // _selected= "";

          return SafeArea(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Scaffold(
                appBar: TitleAppBar(
                  icon: commonIconAndBack(),
                  title: AppStrings.new_issue,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: AppTextStyle.appSymmetricPaddingH15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return BuildAlertDialog();
                                  });
                            },
                            child: SelectImage()),
                        NewIssueFormTitle(issueTitle: AppStrings.issue_type),
                        verticalSpace(5),
                         DropdownSearch(
                          dropdownSearchDecoration: InputDecoration(),
                          mode: Mode.DIALOG,
                          showSearchBox: true,
                          // selectedItem: true,
                          items:  arr,
        //                           onChanged: (s){
        //   setState(() { 
        //    _selected[i]=s;  
        //   });
        // },

                              
                          // arr,
                          // value: _selected,
                          // selectedItem: _selected,

                          
                          validator: (value) => value == null
                              ? AppStrings.validation_issue_type
                              : null,
                            
                              //  onChanged: (salutation) {
                              //    IssueType temp = IssueType(issueType: salutation);
                              //   _.getIssueType(temp);
                              // },
                          
                          // label: "Menu mode",
                          // hint: "country in menu mode",
                          // popupItemDisabled: (String s) => s.startsWith('I'),
                          // onChanged: print,
                          // selectedItem: "Brazil"
                        ),
                        SearchableDropdown<IssueType>(
                          // menuMaxHeight: 500,
                          isExpanded: true,
                          iconDisabledColor: AppColor.textFieldTextGrey,
                          // decoration: InputDecoration(
                          //   enabledBorder: UnderlineInputBorder(
                          //     borderSide: BorderSide(
                          //       color: AppColor.greyDividerColor,
                          //     ),
                          //   ),
                          // ),
                          value: _.selectedSalutation,
                          hint: Text(
                            AppStrings.select,
                            style: AppTextStyle.robotoRegular(
                              fontSize: 17,
                              color: AppColor.textFieldTextGrey,
                            ).copyWith(height: 0.10),
                          ),
                          onChanged: (salutation) {
                            _.getIssueType(salutation!);
                          },
                          validator: (value) => value == null
                              ? AppStrings.validation_issue_type
                              : null,
                          items: _.issueTypeList
                              .map<DropdownMenuItem<IssueType>>(
                                  (IssueType value) {
                            return DropdownMenuItem<IssueType>(
                              value: value,
                              child: Text(
                                value.issueType!,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            );
                          }).toList(),
                        ),
                        NewIssueFormTitle(
                          issueTitle: AppStrings.issue_location,
                        ),
                        SimpleLineTextFormField(
                          readOnly: false,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _.openMap(context);
                          },
                          validator: validateLocation,
                          controller: _.locationController =
                              TextEditingController(
                                  text: AppPreference.getString(
                                              AppStrings.map_search_place) ==
                                          "search"
                                      ? location?.address.toString()
                                      : location?.address?.street.toString()),
                          onChanged: (val) {
                            formKey.currentState!.validate();
                            _.location = val;
                          },
                          keyBoardType: TextInputType.url,
                          hintText: AppStrings.select,
                        ),
                        NewIssueFormTitle(
                          issueTitle: AppStrings.issue_description,
                        ),
                        SimpleLineTextFormField(
                          readOnly: false,
                          // validator: validateDescription,
                          controller: _.descriptionController,
                          onChanged: (val) {
                            formKey.currentState!.validate();
                            _.description = val;
                          },
                          keyBoardType: TextInputType.text,
                          hintText: AppStrings.description,
                        ),
                        verticalSpace(30),
                        RadiusButton(
                          btnText: AppStrings.submit,
                          btnColor: AppColor.buttonBlue,
                          btnOnTap: () {
                            // if (_.img64 == null)
                            //   msgInToast(
                            //       msg:
                            //           "Issue not submitted, Please fill all issue data");
                            if (formKey.currentState!.validate() &&
                                _.img64 != null) {
                              formKey.currentState!.save();
                          
                             _.getIssueSubmit();
                              Future.delayed(Duration(seconds: 5),
                                  () => Get.toNamed(Routes.IssueSubmitted));
                            } else {
                              _.onClick();
                            }
                          },
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
} /*issueAddress":"N B Exxon, Richardson, TX","issueType":"Graffiti"*/
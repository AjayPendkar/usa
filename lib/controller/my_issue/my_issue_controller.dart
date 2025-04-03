// ignore_for_file: unnecessary_statements

import 'package:get/get.dart';
import 'package:myrichardson/controller/dioController.dart';
import 'package:myrichardson/model/my_issue_model.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';

class MyIssueController extends GetxController {
  int signalValue = 0;
  List<MyIssue> myIssueList = [];
  List<MyIssue> filterList = [];
  List<String> filterTab = [
    AppStrings.Submitted,
    AppStrings.Resolved,
    AppStrings.All_Issue
  ];
  bool isLoading = false;

  @override
  void onInit() {
    getMyIssue();
    super.onInit();
  }

  void getMyIssue() async {
    Map<String, dynamic> paramters = {
      AppStrings.OpenAgent: "",
      AppStrings.keys:
          "${AppPreference.getString(AppStrings.name)}:${AppPreference.getString(AppStrings.email)}:${AppPreference.getString(AppStrings.phone)}"
      // "Johnathan:john@gmail.com:(234) 567-8901",
    };

    try {
      isLoading = true;

      final response = await DioApiClient()
          .dio!
          .get(myIssueEndPoint, queryParameters: paramters);
      isLoading = false;
      for (int i = 0; i < response.data.length; i++) {
        myIssueList.add(MyIssue.fromJson(response.data[i]));
      }
    } catch (exception) {
      isLoading = false;
    }
    getFilter(AppStrings.All_Issue);
    update();
  }

  getFilter(String status) {
    if (status == AppStrings.All_Issue) {
      filterList = myIssueList;
    } else {
      filterList =
          myIssueList.where((element) => element.status == status).toList();
    }

    update();
  }

  int signalValGetter() => signalValue;

  signalValChangeTab({int? index}) {
    signalValue = index!;
    update();
  }
}

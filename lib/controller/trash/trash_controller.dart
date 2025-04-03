// ignore_for_file: unnecessary_statements

import 'package:get/get.dart';
import 'package:myrichardson/controller/dioController.dart';
import 'package:myrichardson/model/trash_model.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';

class TrashController extends GetxController {
  Trash? trashList;

  bool isLoading = false;

  @override
  void onInit() {
    getTrash();
    super.onInit();
  }

  getTrashDay() {
    String days = AppPreference.getString(AppStrings.section_code) ==
                AppStrings.NW ||
            AppPreference.getString(AppStrings.section_code) == AppStrings.NE
        ? AppStrings.tuesday_friday
        : AppPreference.getString(AppStrings.section_code) == AppStrings.SW ||
                AppPreference.getString(AppStrings.section_code) ==
                    AppStrings.SE
            ? AppStrings.monday_thursday
            : AppStrings.monday_friday;
    return days;
  }

  void getTrash() async {
    try {
      isLoading = true;
      final response = await DioApiClient().dio!.get(trashEndPoint);
      isLoading = false;
      trashList = Trash.fromJson(response.data);
    } catch (exception) {
      isLoading = false;
      msgInToast(msg: "Connection TimeOut .......");
    }
    update();
  }
}

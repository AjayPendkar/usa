import 'dart:convert';

import 'package:get/get.dart';
import 'package:myrichardson/controller/dioController.dart';
import 'package:myrichardson/model/holiday_markup_model.dart';
import 'package:myrichardson/model/recycle_day_model.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';

import '../../model/day_model.dart';

class RecycleController extends GetxController {
  Recycle? recycleList;
  bool isLoading = false;
  List<HolidayMarkUp>? holidayMarkup = [];

  @override
  void onInit() {
    getRecycle();
    super.onInit();
  }

  getRecycleDay() {
    String day = AppPreference.getString(AppStrings.section_code) ==
            AppStrings.NW
        ? AppStrings.Tuesday
        : AppPreference.getString(AppStrings.section_code) == AppStrings.NE
            ? AppStrings.friday
            : AppPreference.getString(AppStrings.section_code) == AppStrings.SW
                ? AppStrings.monday
                : AppPreference.getString(AppStrings.section_code) ==
                        AppStrings.SE
                    ? AppStrings.Thursday
                    : AppStrings.sunday;
    return day;
  }

  void getRecycle() async {
    try {
      isLoading = true;
      final response = await DioApiClient().dio!.get(recycleEndPoint);
      isLoading = false;
      recycleList = Recycle.fromJson(response.data);
      getHoliday();
    } catch (exception) {
      isLoading = false;
      msgInToast(msg: "Connection TimeOut .......");
    }
    update();
  }

  getHoliday() async {
    final response = await DioApiClient().dio!.get(holidayEndPoint);
    for (int i = 0; i < response.data.length; i++) {
      holidayMarkup!.add(HolidayMarkUp.fromJson(response.data[i]));
    }
    update();
  }

  dayinfo() async {
    final response =
        await DioApiClient().dio!.get(holidayEndPoint, queryParameters: {
      AppStrings.OpenAgent: "",
      AppStrings.address: "${AppPreference.getString(AppStrings.address)}"
      // "Johnathan:john@gmail.com:(234) 567-8901",
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Day.fromJson(jsonDecode(response.data));
    }
    update();
  }
}

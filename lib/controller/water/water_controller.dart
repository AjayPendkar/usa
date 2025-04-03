import 'package:get/get.dart';
import 'package:myrichardson/controller/dioController.dart';
import 'package:myrichardson/model/water_model.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';

class WaterController extends GetxController {
  List<Water> waterList = [];
  bool isLoading = false;

  @override
  void onInit() {
    getWater();
    super.onInit();
  }

  List<String> listIn = [];

  evenOddAddress() {
    String addres = AppPreference.getString(AppStrings.address) ?? "";
    listIn = addres.split(" ");
    if (listIn.length > 1) {
      if (int.parse(listIn[0]) % 2 == 0) {
        return AppStrings.Tuesday;
      } else {
        return AppStrings.sunday;
      }
    }
  }

  getWater() async {
    try {
      isLoading = true;
      final response = await DioApiClient().dio!.get(waterEndPoint);
      isLoading = false;
      for (int i = 0; i < response.data.length; i++) {
        waterList.add(Water.fromJson(response.data[i]));
      }
    } catch (exception) {
      isLoading = false;
      msgInToast(msg: "Connection TimeOut .......");
    }
    update();
  }
}

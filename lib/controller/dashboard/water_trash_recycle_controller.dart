import 'dart:convert';
import 'package:get/get.dart';
import 'package:myrichardson/controller/dioController.dart';
import 'package:myrichardson/model/water_trash_recycle_model.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';

import '../../main.dart';

class WaterTrashRecycleController extends GetxController {
  WaterTrashRecycleModel? waterTrashRecycleModel;
  bool isLoading = false;

  @override
  void onInit() {
    if (AppPreference.getString(AppStrings.spLastFetchedAddress) !=
            AppPreference.getString(AppStrings.address) ||
        isItFirstTimeToCallDashboardDayData) {
      getData();
    } else {}

    super.onInit();
  }

  getData() async {
    try {
      // String address = AppPreference.getString(AppStrings.address);
      // String params = "openagent&address=" + Uri.encodeComponent("$address");
      // String url = "https://discovery.cor.gov/public" + dayEndPoint + params;
      isLoading = true;
      // final response = await Dio().get(url);

      isLoading = false;

      AppPreference.set(AppStrings.spLastFetchedAddress,
          AppPreference.getString(AppStrings.address));

      final response =
          await DioApiClient().dio!.get(dayEndPoint, queryParameters: {
        AppStrings.openagent: "",
        AppStrings.aaddress: "${AppPreference.getString(AppStrings.address)}"
        // "Johnathan:john@gmail.com:(234) 567-8901",
      });

      String data = response
          .toString()
          .replaceAll("<html>", "")
          .replaceAll("<head>", "")
          .replaceAll("</head>", "")
          .replaceAll("<body text=\"#000000\">", "")
          .replaceAll("</body>", "")
          .replaceAll("</html>", "")
          .toString();

      waterTrashRecycleModel =
          WaterTrashRecycleModel.fromJson(jsonDecode(data));

      isItFirstTimeToCallDashboardDayData = false;
      update();
    } catch (exception) {
      isLoading = false;

      msgInToast(msg: "Connection TimeOut ....... ");
    }
    update();
  }
}

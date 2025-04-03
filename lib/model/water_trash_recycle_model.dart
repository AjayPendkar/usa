import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';

class WaterTrashRecycleModel {
  String? water;
  String? trash;
  String? recycling;

  WaterTrashRecycleModel.fromJson(Map<String, dynamic> map) {
    this.water = map["water"];
    this.trash = map["trash"];
    this.recycling = map["recycling"];

    AppPreference.set(AppStrings.spWaterDayValue, water);
    AppPreference.set(AppStrings.spTrashDayValue, trash);
    AppPreference.set(AppStrings.spRecyclingDayValue, recycling);
  }
}

import 'package:myrichardson/constants/strings_constatnt.dart';
import 'package:myrichardson/model/babric/babric_model.dart';

final List<BABICNonCompostableRequest> babicNonCompostableData = [
  BABICNonCompostableRequest(
    title: AppStrings.large_interior,
    description: AppStrings.large_piece_description,
    isChecked: false,
    materialType: "BLIP",
  ),
  BABICNonCompostableRequest(
    title: AppStrings.application,
    description: AppStrings.application_description,
    isChecked: false,
    materialType: "BAPP",
  ),
  BABICNonCompostableRequest(
    title: AppStrings.electronics,
    description: AppStrings.electronics_description,
    isChecked: false,
    materialType: "BELC",
  ),
  BABICNonCompostableRequest(
    title: AppStrings.matteres,
    description: AppStrings.scral_description,
    isChecked: false,
    materialType: "BMBS",
  ),
  BABICNonCompostableRequest(
    title: AppStrings.equipement,
    description: AppStrings.equ_description,
    isChecked: false,
    materialType: "BEQP",
  ),
  BABICNonCompostableRequest(
    title: AppStrings.scral_mettal,
    description: AppStrings.scral_description,
    isChecked: false,
    materialType: "BSCM",
  ),
  BABICNonCompostableRequest(
    title: AppStrings.fence_material,
    description: "",
    isChecked: false,
    materialType: "BFEN",
  ),
];

final List<BABICCompostable> babicCompostableData = [
  BABICCompostable(
    title: AppStrings.brown_bags,
    isCheck: false,
    materialType: "CBCB",
  ),
  BABICCompostable(
    title: AppStrings.loss_brush,
    isCheck: false,
    materialType: "CLBT",
  ),
];

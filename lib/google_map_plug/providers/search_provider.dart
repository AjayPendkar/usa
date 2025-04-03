// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SearchProvider extends ChangeNotifier {
  static SearchProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<SearchProvider>(context, listen: listen);

  String _prevSearchTerm = "";
  String _searchTerm = "";

  String get prevSearchTerm => _prevSearchTerm;

  String get searchTerm => _searchTerm;

  set searchTerm(String newValue) {
    _searchTerm = newValue;
    notifyListeners();
  }

  TextEditingController controller = TextEditingController();

  set prevSearchTerm(String newValue) {
    _prevSearchTerm = newValue;
    notifyListeners();
  }

  var addressText;

  addressAutoComplete(String address) {
    addressText = address;
    controller.text = addressText;
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:myrichardson/google_map_plug/src/autocomplete_search.dart';

class SearchBarController extends ChangeNotifier {
  late AutoCompleteSearchState _autoCompleteSearch;

  attach(AutoCompleteSearchState searchWidget) {
    _autoCompleteSearch = searchWidget;
  }

  /// Just clears text.
  clear() {
    _autoCompleteSearch.clearText();
  }

  /// Clear and remove focus (Dismiss keyboard)
  reset() {
    _autoCompleteSearch.resetSearchBar();
  }

  clearOverlay() {
    _autoCompleteSearch.clearOverlay();
  }
}

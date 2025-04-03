import 'package:flutter/material.dart';

class Utilities {
  static closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}

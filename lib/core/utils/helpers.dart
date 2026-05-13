import 'package:flutter/material.dart';

class Helpers {

  // HIDE KEYBOARD
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  // SNACKBAR
  static void showSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // SCREEN WIDTH
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // SCREEN HEIGHT
  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
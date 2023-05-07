import 'package:flutter/material.dart';

class Utils {
  /// Changes the focus from one widget to another
  static void changeFocus(context, currentFocusNode, nextFocusNode) {
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  /// Takes the message to display in snackbar
  /// Shows a green snackbar indicating success
  static showGreenSnackBar(context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: (Colors.green[400]),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Takes the message to display in snackbar
  /// Shows a red snackbar indicating failure or error
  static showRedSnackBar(context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: (Colors.red[400]),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

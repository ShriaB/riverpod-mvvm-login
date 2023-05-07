import 'package:flutter/material.dart';

/// Style for buttons
var textButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(vertical: 10.0)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))),
  backgroundColor: MaterialStateProperty.all(Colors.blue),
);

/// Style for input text fields
var textInputDecorationBorder = const OutlineInputBorder(
    borderSide: BorderSide(
  width: 1.0,
));

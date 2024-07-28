import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get screenBackgroundcolor => brightness == Brightness.light
      ? const Color.fromARGB(255, 214, 231, 248)
      : const Color.fromRGBO(245, 249, 253, 1);
  Color get primaryBlueColor => brightness == Brightness.light
      ? const Color.fromRGBO(12, 84, 190, 1)
      : const Color.fromRGBO(12, 84, 190, 1);
  Color get primaryBlackColor => brightness == Brightness.light
      ? const Color.fromRGBO(0, 0, 0, 1)
      : const Color.fromRGBO(0, 0, 0, 1);
    Color get titleColor => brightness == Brightness.light
      ? const Color.fromRGBO(206, 211, 220, 1)
      : const Color.fromRGBO(206, 211, 220, 1);
}

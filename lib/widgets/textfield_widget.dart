import 'package:comments_app/themes/colorscheme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {required this.hintText,
      required this.inputType,
      required this.controller,
      super.key});
  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  bool isErrorOccured = false;
  bool isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final RegExp passwordRegex =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
    return passwordRegex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primaryBlackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        cursorHeight: 20,
        cursorColor: Theme.of(context).colorScheme.primaryBlackColor,
        decoration: InputDecoration(
            errorMaxLines: 2,
            filled: true,
            isDense: true,
            fillColor: Colors.white,
            focusColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.only(left: 10, top: 7, bottom: 7, right: 0),
            hintText: hintText,
            errorStyle: const TextStyle(
              height: 0,
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primaryBlackColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            )),
        keyboardType: inputType,
        obscureText: inputType == TextInputType.visiblePassword ? true : false,
        autocorrect: false,
        validator: (value) {
          if (value == null || value.trim() == "") {
            isErrorOccured = true;
            return "The field is required";
          } else if (inputType == TextInputType.emailAddress &&
              !isValidEmail(value)) {
            isErrorOccured = true;
            return 'Please enter a valid email';
          } else if (inputType == TextInputType.visiblePassword &&
              !isValidPassword(value)) {
            isErrorOccured = true;
            return 'Password must be at least 6 characters long and include both letters and numbers';
          } else {
            isErrorOccured = false;
          }
          return null;
        },
      ),
    );
  }
}

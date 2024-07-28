import 'package:comments_app/themes/colorscheme.dart';
import 'package:flutter/material.dart';

extension CustomStyles on TextTheme {
  TextStyle regularTextStyle(BuildContext context,
          {Color? textColor, FontWeight? fontweight, double? fontSize, FontStyle? fontStyle}) =>
      TextStyle(
          color: textColor ?? Theme.of(context).colorScheme.primaryBlackColor,
          fontSize: fontSize ?? 16,
          fontFamily: 'Poppins',
          fontWeight: fontweight ?? FontWeight.w400, fontStyle: fontStyle);
}

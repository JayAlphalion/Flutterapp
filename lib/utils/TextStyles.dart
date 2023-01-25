import 'package:flutter/material.dart';

import 'Constants.dart';

class TextStyles {
  static heading1({double? size, Color? color, FontWeight? weight}) =>
      TextStyle(
          fontSize: size ?? Constant.heading1FontSize,
          color: color,
          fontWeight: weight ?? Constant.heading1FontWeight);

  static heading2({double? size, Color? color, FontWeight? weight}) =>
      TextStyle(
          fontSize: size ?? Constant.heading2FontSize,
          color: color,
          fontWeight: weight ?? Constant.heading2FontWeight);
  static heading3({double? size, Color? color, FontWeight? weight}) =>
      TextStyle(
          fontSize: size ?? Constant.heading3FontSize,
          color: color,
          fontWeight: weight ?? Constant.heading3FontWeight);
  static heading4({double? size, Color? color, FontWeight? weight}) =>
      TextStyle(
          fontSize: size ?? Constant.heading4FontSize,
          color: color,
          fontWeight: weight ?? Constant.heading4FontWeight);
  static heading5({double? size, Color? color, FontWeight? weight}) =>
      TextStyle(
          fontSize: size ?? Constant.heading5FontSize,
          color: color,
          fontWeight: weight ?? Constant.heading5FontWeight);
  static heading6({double? size, Color? color, FontWeight? weight}) =>
      TextStyle(
          fontSize: size ?? Constant.heading6FontSize,
          color: color,
          fontWeight: weight ?? Constant.heading6FontWeight);
  static heading7({double? size, Color? color, FontWeight? weight}) =>
      TextStyle(
          fontSize: size ?? Constant.heading7FontSize,
          color: color,
          fontWeight: weight ?? Constant.heading7FontWeight);
  static heading8({double? size, Color? color, FontWeight? weight}) =>
      TextStyle(
          fontSize: size ?? Constant.heading8FontSize,
          color: color,
          fontWeight: weight ?? Constant.heading8FontWeight);
}

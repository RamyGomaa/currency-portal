import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';

TextStyle _getTextStyle({
  double? fontSize,
  String? fontFamily,
  FontWeight? fontWeight,
  Color? color,
}) {
  fontWeight ??= FontWeightManager.regular;
  color ??= ColorManager.textPrimary;
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

//light
TextStyle getLightTextStyle({
  double? fontSize,
  String? fontFamily,
  Color? color,
}) {
  return _getTextStyle(
      fontWeight: FontWeightManager.light,
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily);
}

//regular style
TextStyle getRegularTextStyle({
  double? fontSize,
  String? fontFamily,
  Color? color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
  );
}

//Medium
TextStyle getMediumTextStyle({
  double? fontSize,
  String? fontFamily,
  Color? color,
}) {
  return _getTextStyle(
    fontWeight: FontWeightManager.medium,
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
  );
}

//Semi Bold
TextStyle getSemiBoldTextStyle({
  double? fontSize,
  String? fontFamily,
  Color? color,
}) {
  return _getTextStyle(
    fontWeight: FontWeightManager.semiBold,
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
  );
}

//Bold
TextStyle getBoldTextStyle({
  double? fontSize,
  String? fontFamily,
  Color? color,
}) {
  return _getTextStyle(
    fontWeight: FontWeightManager.bold,
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
  );
}

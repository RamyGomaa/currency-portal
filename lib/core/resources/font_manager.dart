import 'package:flutter/cupertino.dart';

class FontConstants {
  static const String fontFamilyNahdi = "Nahdi Bold";
  static const String fontFamilyAlmarai = "Almarai";
  static const String defaultFontFamily = fontFamilyAlmarai;
}

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class FontSize {
  static const double s8 = 8.0;
  static const double s9 = 9.0;
  static const double s10 = 10.0;
  static const double s11 = 11.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s17 = 17.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s22 = 22.0;
  static const double s30 = 30.0;
  static const double s40 = 40.0;
  static const double s50 = 50.0;
  static const double s60 = 60.0;
  static const double s70 = 70.0;

  static double getRelativeFontSize(BuildContext context,
      {double unit = FontSize.s10}) {
    return unit * MediaQuery.of(context).size.height * 0.0022;
  }
}

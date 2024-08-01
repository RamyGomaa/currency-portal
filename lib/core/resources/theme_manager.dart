import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData? getApplicationTheme(BuildContext context) {
  const textfieldRoundRadius = AppSize.s10;
  return ThemeData(
      //main colors
      fontFamily: FontConstants.defaultFontFamily,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: Colors.white),
      secondaryHeaderColor: ColorManager.secondary,
      indicatorColor: ColorManager.secondary,
      scaffoldBackgroundColor: ColorManager.primary,
      primaryColor: ColorManager.primary,
      primaryColorDark: ColorManager.primaryDark,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.white,
      //cardview Theme
      cardTheme: CardTheme(
        color: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
          side: const BorderSide(
            color: ColorManager.lightGrey,
            width: 0.4,
          ),
        ),
        shadowColor: ColorManager.lightGrey,
        elevation: AppSize.s4,
      ),

      // app bar theme
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: ColorManager.darkGrey), //
        centerTitle: true,
        color: ColorManager.primary,
        elevation: AppSize.s4,
        shadowColor: ColorManager.grey,
        titleTextStyle: getRegularTextStyle(),
      ),
      // button theme
      buttonTheme: const ButtonThemeData(
        shape: StadiumBorder(),
        buttonColor: ColorManager.accent,
        splashColor: ColorManager.primaryDark,
      ),

      //elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: getRegularTextStyle(
              color: ColorManager.textPrimary,
              fontFamily: FontConstants.defaultFontFamily),
          backgroundColor: ColorManager.secondary,
          // side: const BorderSide(color: ColorManager.darkGrey, width: 0.5),
        ),
      ),

      //text theme

      textTheme: TextTheme(
        headlineLarge: getBoldTextStyle(
          color: ColorManager.textPrimary,
        ),
        headlineMedium: getLightTextStyle(
          color: ColorManager.grey,
        ),
        displayLarge: getBoldTextStyle(color: ColorManager.textPrimary),
        displayMedium: getBoldTextStyle(color: ColorManager.textPrimary),
        labelSmall: getMediumTextStyle(color: ColorManager.textPrimary),
        labelMedium: getMediumTextStyle(color: ColorManager.textPrimary),
        labelLarge: getMediumTextStyle(color: ColorManager.textPrimary),
        displaySmall: getMediumTextStyle(color: ColorManager.textPrimary),
        bodyLarge: getMediumTextStyle(color: ColorManager.textPrimary),
        bodyMedium: getMediumTextStyle(
          color: ColorManager.textPrimary,
        ),
        bodySmall: getMediumTextStyle(
          color: ColorManager.textPrimary,
        ).copyWith(
          height: AppSize.s2,
        ),
      ),
      //text buttton
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorManager.secondary,
          textStyle: getMediumTextStyle(color: ColorManager.textPrimary),
        ),
      ),

      //input decoration theme
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: defaultInputDecorationTheme(textfieldRoundRadius),
        textStyle: getMediumTextStyle(color: ColorManager.grey),
      ),
      inputDecorationTheme: defaultInputDecorationTheme(textfieldRoundRadius),

      //chips theme
      chipTheme: ChipThemeData(
        backgroundColor: ColorManager.primary,
        deleteIconColor: ColorManager.primary,
        disabledColor: ColorManager.white,
        // labelPadding: const EdgeInsets.symmetric(horizontal: AppSize.s12),
        // padding: const EdgeInsets.symmetric(horizontal: AppSize.s4),
        // secondaryLabelStyle: getMediumTextStyle(color: ColorManager.white),
        secondarySelectedColor: ColorManager.secondary,
        selectedColor: ColorManager.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
          side: const BorderSide(
            color: ColorManager.secondary,
            width: AppSize.s2,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: AppSize.s4,
        selectedItemColor: ColorManager.secondary,
        unselectedItemColor: ColorManager.grey1,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: ColorManager.accent, surface: ColorManager.primary));
}

InputDecorationTheme defaultInputDecorationTheme(double textfieldRoundRadius) {
  return InputDecorationTheme(
    fillColor: ColorManager.lightGrey,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.rAppBar / 4),
      borderSide: const BorderSide(
        color: ColorManager.grey2,
        width: 0.15,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.rAppBar / 4),
      borderSide: const BorderSide(
        color: ColorManager.grey2,
        width: 0.15,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.circular(textfieldRoundRadius),
      borderSide: BorderSide(
        color: ColorManager.grey,
        width: 0.4,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      // borderRadius: BorderRadius.circular(textfieldRoundRadius),
      borderSide: BorderSide(
        color: Color.fromARGB(255, 160, 102, 108),
        width: 0.1,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: ColorManager.accent,
        width: 0.1,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.rAppBar / 4),
      borderSide: const BorderSide(
        color: ColorManager.grey2,
        width: 0.15,
      ),
    ),
    prefixIconColor: ColorManager.darkGrey,
    suffixIconColor: ColorManager.grey1,
    labelStyle: getMediumTextStyle(color: ColorManager.grey),
    hintStyle: getLightTextStyle(
      color: ColorManager.darkGrey.withOpacity(0.4),
    ),
    helperStyle: getMediumTextStyle(color: ColorManager.lightGrey),
  );
}

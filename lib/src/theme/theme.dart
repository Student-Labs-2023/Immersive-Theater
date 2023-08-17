import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';

BorderRadiusGeometry panelRadius = const BorderRadius.only(
  topLeft: Radius.circular(24.0),
  topRight: Radius.circular(24.0),
);
BorderRadiusGeometry containerRadius =
    const BorderRadius.all(Radius.circular(40.0));
BorderRadiusGeometry searchBarRadius =
    const BorderRadius.all(Radius.circular(8.0));

Color secondaryColor = const Color.fromARGB(255, 248, 249, 250);
Color barIndicatorColor = const Color.fromARGB(30, 55, 49, 49);
Color primaryTextColor = const Color.fromARGB(255, 33, 37, 41);
Color secondaryTextColor = const Color.fromARGB(255, 173, 181, 189);
Color accentTextColor = const Color.fromARGB(255, 114, 91, 255);

Color defaultTextColor = Colors.black;
ThemeData defaultTheme() => ThemeData(
      useMaterial3: false,
      focusColor: AppColor.accentBackground,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.redAlert),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.purplePrimary),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.grey),
        ),
      ),
      fontFamily: defaultFont,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          height: baseTextHeight,
          color: defaultTextColor,
          fontSize: heading1FontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w600,
          letterSpacing: letterSpacing,
        ),
        displayMedium: TextStyle(
          height: baseTextHeight,
          color: defaultTextColor,
          fontSize: heading2FontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w600,
          letterSpacing: letterSpacing,
        ),
        displaySmall: TextStyle(
          height: baseTextHeight,
          color: defaultTextColor,
          fontSize: heading3FontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w600,
          letterSpacing: letterSpacing,
        ),
        headlineMedium: TextStyle(
          height: baseTextHeight,
          color: defaultTextColor,
          fontSize: heading4FontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w600,
          letterSpacing: letterSpacing,
        ),
        bodyLarge: TextStyle(
          height: baseTextHeight,
          color: defaultTextColor,
          fontSize: paragraph1FontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w600,
          letterSpacing: letterSpacing,
        ),
        bodyMedium: TextStyle(
          height: baseTextHeight,
          color: defaultTextColor,
          fontSize: paragraph2FontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w600,
          letterSpacing: letterSpacing,
        ),
        bodySmall: TextStyle(
          height: baseTextHeight,
          color: defaultTextColor,
          fontSize: paragraph3FontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w600,
          letterSpacing: letterSpacing,
        ),
      ),
    );

const double letterSpacing = -0.33;

String defaultFont = 'RFDewi';
const double baseTextHeight = 1.5;
const double heading1FontSize = 28;
const double heading2FontSize = 22;
const double heading3FontSize = 20;
const double heading4FontSize = 18;
const double paragraph1FontSize = 16;
const double paragraph2FontSize = 14;
const double paragraph3FontSize = 12;

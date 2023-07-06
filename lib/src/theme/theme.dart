import 'package:flutter/material.dart';

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
ThemeData defaultTheme() => ThemeData(
      fontFamily: defaultFont,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          height: baseTextHeight,
          color: Colors.white,
          fontSize: titleLargeFontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.33,
        ),
        titleSmall: TextStyle(
          height: baseTextHeight,
          color: secondaryTextColor,
          fontSize: titleSmallFontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.33,
        ),
        bodyLarge: TextStyle(
          height: baseTextHeight,
          color: primaryTextColor,
          fontSize: bodyLargeFontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.33,
        ),
        bodyMedium: TextStyle(
          height: baseTextHeight,
          color: primaryTextColor,
          fontSize: bodyMediumFontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.33,
        ),
        bodySmall: TextStyle(
          height: baseTextHeight,
          color: primaryTextColor,
          fontSize: bodySmallFontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.33,
        ),
        labelLarge: TextStyle(
          height: baseTextHeight,
          color: accentTextColor,
          fontSize: bodySmallFontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.33,
        ),
        labelSmall: TextStyle(
          height: baseTextHeight,
          color: Colors.white,
          fontSize: labelSmallFontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.33,
        ),
      ),
    );

String defaultFont = 'RFDewi';
const double baseTextHeight = 1.5;

const double tinyFontSize = 11;

const double labelSmallFontSize = 13;

const double titleSmallFontSize = 12;
const double titleMediumFontSize = 20;
const double titleLargeFontSize = 24;

const double bodySmallFontSize = 17;
const double bodyMediumFontSize = 22;
const double bodyLargeFontSize = 28;

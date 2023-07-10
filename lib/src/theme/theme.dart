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

Color defaultTextColor = Colors.black;
ThemeData defaultTheme() => ThemeData(
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

        // следующие нужно потихоньку заменять в коде
        titleLarge: TextStyle(
          height: baseTextHeight,
          color: Colors.white,
          fontSize: titleLargeFontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w600,
          letterSpacing: letterSpacing,
        ),
        titleSmall: TextStyle(
          height: baseTextHeight,
          color: secondaryTextColor,
          fontSize: titleSmallFontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w700,
          letterSpacing: letterSpacing,
        ),

        labelLarge: TextStyle(
          height: baseTextHeight,
          color: accentTextColor,
          fontSize: bodySmallFontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w700,
          letterSpacing: letterSpacing,
        ),
        labelSmall: TextStyle(
          height: baseTextHeight,
          color: Colors.white,
          fontSize: labelSmallFontSize,
          fontFamily: defaultFont,
          fontWeight: FontWeight.w700,
          letterSpacing: letterSpacing,
        ),
      ),
    );

const double letterSpacing = -0.33;
const double tinyFontSize = 11;
const double labelSmallFontSize = 13;
const double titleSmallFontSize = 12;
const double titleMediumFontSize = 20;
const double titleLargeFontSize = 24;
const double bodySmallFontSize = 17;
const double bodyMediumFontSize = 22;
const double bodyLargeFontSize = 28;

//new
String defaultFont = 'RFDewi';
const double baseTextHeight = 1.5;
const double heading1FontSize = 28;
const double heading2FontSize = 22;
const double heading3FontSize = 20;
const double heading4FontSize = 18;
const double paragraph1FontSize = 16;
const double paragraph2FontSize = 14;
const double paragraph3FontSize = 11;

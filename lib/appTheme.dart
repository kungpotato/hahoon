import 'package:flutter/material.dart';

class AppTheme {
  static bool isLightTheme = true;
  static Color statusBarColors = HexColor("#1a1c20");
  static Color primaryColorsLight = HexColor("#DA4F2C");
  static Color primaryColorsDark = HexColor("#0f0f0f");
  static Color secondaryColors = HexColor("#f3f4ed");

  static TextTheme _buildTextTheme(TextTheme base) {
    var fontName = "FC Iconic";
    return base.copyWith(
      headline6: base.headline6!.copyWith(fontFamily: fontName),
      bodyText2: base.headline6!.copyWith(fontFamily: fontName),
      bodyText1: base.headline6!.copyWith(fontFamily: fontName),
      button: base.headline6!.copyWith(fontFamily: fontName),
      caption: base.headline6!.copyWith(fontFamily: fontName),
      headline4: base.headline6!.copyWith(fontFamily: fontName),
      headline3: base.headline6!.copyWith(fontFamily: fontName),
      headline2: base.headline6!.copyWith(fontFamily: fontName),
      headline1: base.headline6!.copyWith(fontFamily: fontName),
      headline5: base.headline6!.copyWith(fontFamily: fontName),
      overline: base.headline6!.copyWith(fontFamily: fontName),
      subtitle1: base.headline6!.copyWith(fontFamily: fontName),
      subtitle2: base.headline6!.copyWith(fontFamily: fontName),
    );
  }

  static ThemeData getTheme() {
    if (isLightTheme) {
      return newLightTheme();
    } else {
      return newDarkTheme();
    }
  }

  static ThemeData newLightTheme() {
    Color primaryColor = primaryColorsLight;
    Color secondaryColor = secondaryColors;
    final ColorScheme colorScheme = ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      appBarTheme: AppBarTheme(brightness: Brightness.dark),
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: Color(0xFFFFFFFF),
      scaffoldBackgroundColor: Color(0xFFF6F6F6),
      errorColor: Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }

  static ThemeData newDarkTheme() {
    Color primaryColor = primaryColorsDark;
    Color secondaryColor = secondaryColors;
    final ColorScheme colorScheme = ColorScheme.dark().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      appBarTheme: AppBarTheme(brightness: Brightness.dark),
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Color(0xFF0F0F0F),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

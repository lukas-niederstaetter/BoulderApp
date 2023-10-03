import 'package:flutter/material.dart';

class Styles {

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      secondaryHeaderColor: const Color.fromRGBO(217,18,26,1),
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      indicatorColor: isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor: Colors.grey,
      highlightColor: isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
      hoverColor: isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      focusColor: isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: isDarkTheme ? Colors.grey.shade800 : Colors.grey,
      //textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      cardColor: isDarkTheme ? Colors.black : Colors.white,
      canvasColor: isDarkTheme ? Colors.grey.shade900 : Colors.white,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()), colorScheme: ColorScheme.fromSwatch(primarySwatch: createMaterialColor(Color.fromRGBO(15,71,174,1))).copyWith(background: isDarkTheme ? Colors.grey : Color(0xffF1F5FB)).copyWith(secondary: Color.fromRGBO(15,71,174,1)),
    );
  }

}

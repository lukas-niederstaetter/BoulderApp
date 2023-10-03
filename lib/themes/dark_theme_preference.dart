import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const THEME_STATUS = "THEMESTATUS";

  /// This method sets the theme for the app
  /// [param] value, the theme to be set
  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  /// This method returns true if the current theme is dark.
  /// Since it gets added to the shared preferences,
  /// the theme will be the same throughout the app, until changed
  /// [bool], true if the theme is dark
  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}
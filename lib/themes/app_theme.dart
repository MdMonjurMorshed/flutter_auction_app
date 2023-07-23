import 'package:auction_bd24/themes/app_color.dart';
import 'package:auction_bd24/themes/app_text.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final appColor = AppColor();
  static final appText = AppText();

  AppTheme._();

  static ThemeData appThemeData() {
    return ThemeData(
        primaryColor: Colors.blue,
        appBarTheme: AppBarTheme(backgroundColor: Colors.purple[400]),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
            backgroundColor: Colors.purple[400],
            elevation: 10));
  }
}

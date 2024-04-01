import 'package:flutter/material.dart';

class AppTheme {
  final isDark;

  AppTheme({this.isDark = false});

  ThemeData getTheme() => ThemeData(
    brightness: isDark ? Brightness.dark : Brightness.light,
    useMaterial3: true,
    colorSchemeSeed: const Color(0xff2862f5)
  );


}
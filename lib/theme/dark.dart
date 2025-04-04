import 'package:flutter/material.dart';

import 'package:flutter_demo/theme/base.dart';

/* 
 * 深色主题变量
 */
final ThemeVars darkThemeVars = ThemeVars(
  scaffoldBackground: const Color.fromRGBO(20, 20, 20, 1),
  contentBackground: const Color.fromRGBO(32, 32, 32, 1),
  textColor: const Color.fromRGBO(220, 220, 220, 1),
  secondaryTextColor: const Color.fromRGBO(180, 180, 180, 1),
  placeholderTextColor: const Color.fromRGBO(120, 120, 120, 1),
  dangerColor: const Color.fromRGBO(180, 40, 40, 1),
);

/* 
 * 深色主题配色
 */
ColorScheme getDarkColorScheme() {
  return ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromRGBO(0, 62, 204, 1),
    primary: const Color.fromRGBO(0, 62, 204, 1),
  );
}

/* 
 * 深色主题
 */
ThemeData getDarkThemeData() {
  final colorScheme = getDarkColorScheme();
  final baseTheme = createBaseTheme(
    colorScheme: colorScheme,
    vars: darkThemeVars,
  );
  
  return baseTheme.copyWith(
    /* 
     * 文字
     */
    textTheme: baseTheme.textTheme.copyWith(
      bodyMedium: baseTheme.textTheme.bodyMedium?.copyWith(
        color: darkThemeVars.textColor,
      ),
    ),
    
    /*
     * AppBar
     */
    appBarTheme: baseTheme.appBarTheme.copyWith(
      backgroundColor: darkThemeVars.contentBackground,
    ),
  );
} 
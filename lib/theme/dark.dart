import 'package:flutter/material.dart';
import 'package:flutter_demo/theme/base.dart';

/* 
 * 深色主题变量
 */
final ThemeVars darkThemeVars = ThemeVars(
  scaffoldBackground: const Color.fromRGBO(30, 30, 30, 1),
  contentBackground: const Color.fromRGBO(45, 45, 45, 1),
);

/* 
 * 深色主题配色
 */
ColorScheme getDarkColorScheme() {
  return ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromRGBO(255, 92, 5, 1),
    primary: const Color.fromRGBO(255, 92, 5, 1),
    secondary: const Color.fromRGBO(255, 160, 120, 1),
    surface: const Color.fromRGBO(50, 30, 20, 1),
    onSurface: const Color.fromRGBO(255, 180, 140, 1),
  );
}

/* 
 * 深色主题
 */
ThemeData getDarkThemeData() {
  final colorScheme = getDarkColorScheme();
  
  return createBaseTheme(
    colorScheme: colorScheme,
    vars: darkThemeVars,
  ).copyWith(
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Color.fromRGBO(220, 220, 220, 1)),
    ),
  );
} 
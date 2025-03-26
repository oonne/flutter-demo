import 'package:flutter/material.dart';
import 'package:flutter_demo/theme/base.dart';

/* 
 * 浅色主题变量
 */
final ThemeVars lightThemeVars = ThemeVars(
  scaffoldBackground: const Color.fromRGBO(240, 240, 240, 1),
  contentBackground: const Color.fromRGBO(255, 255, 255, 1),
  textColor: const Color.fromRGBO(30, 30, 30, 1),
  secondaryTextColor: const Color.fromRGBO(100, 100, 100, 1),
);

/* 
 * 浅色主题配色
 */
ColorScheme getLightColorScheme() {
  return ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromRGBO(0, 62, 204, 1),
    primary: const Color.fromRGBO(0, 62, 204, 1),
  );
}

/* 
 * 浅色主题
 */
ThemeData getLightThemeData() {
  final colorScheme = getLightColorScheme();
  final baseTheme = createBaseTheme(
    colorScheme: colorScheme,
    vars: lightThemeVars,
  );
  
  return baseTheme.copyWith(
    /* 
     * 文字
     */
    textTheme: baseTheme.textTheme.copyWith(
      bodyMedium: baseTheme.textTheme.bodyMedium?.copyWith(
        color: lightThemeVars.textColor,
      ),
    ),
  );
} 
import 'package:flutter/material.dart';
import 'package:flutter_demo/theme/base.dart';

/* 
 * 浅色主题变量
 */
final ThemeVars lightThemeVars = ThemeVars(
  scaffoldBackground: const Color.fromRGBO(255, 255, 255, 1),
  cardColor: Colors.white,
);

/* 
 * 浅色主题配色
 */
ColorScheme getLightColorScheme() {
  return ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromRGBO(255, 92, 5, 1),
    primary: const Color.fromRGBO(255, 92, 5, 1),
    secondary: const Color.fromRGBO(255, 190, 155, 1),
    surface: const Color.fromRGBO(255, 239, 230, 1),
    onSurface: const Color.fromRGBO(255, 92, 5, 1),
  );
}

/* 
 * 浅色主题
 */
ThemeData getLightThemeData() {
  final colorScheme = getLightColorScheme();
  
  return createBaseTheme(
    colorScheme: colorScheme,
    vars: lightThemeVars,
  ).copyWith(
    // 浅色主题特有的设置可以在这里添加
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary,
      ),
    ),
  );
} 
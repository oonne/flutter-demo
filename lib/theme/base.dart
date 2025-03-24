import 'package:flutter/material.dart';

/* 
 * 全局主题变量
 */
class ThemeVars {
  final double radius;
  final double cardMargin;
  final Color scaffoldBackground;
  final Color cardColor;

  const ThemeVars({
    this.radius = 4,
    this.cardMargin = 10,
    required this.scaffoldBackground,
    required this.cardColor,
  });
}

/* 
 * 基础主题设置
 */
ThemeData createBaseTheme({
  required ColorScheme colorScheme,
  required ThemeVars vars,
}) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: vars.scaffoldBackground,

    /* 
     * 卡片主题
     */
    cardTheme: CardTheme(
      color: vars.cardColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(vars.radius),
      ),
      margin: EdgeInsets.all(vars.cardMargin),
    ),

    /* 
     * AppBar
     */
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),

    /* 
     * 页面转场动画
     * 所有平台统一使用 iOS 风格的转场动画
     */
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
} 
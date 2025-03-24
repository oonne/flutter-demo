import 'package:flutter/material.dart';

/* 
 * 全局主题变量
 */
class ThemeVars {
  final double radius;
  final double panelMargin;
  final Color scaffoldBackground;
  final Color contentBackground;

  const ThemeVars({
    this.radius = 8, // 圆角大小
    this.panelMargin = 10, // 卡片margin
    required this.scaffoldBackground, // 页面背景色
    required this.contentBackground, // 内容背景色
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
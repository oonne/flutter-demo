import 'package:flutter/material.dart';

/* 
 * 全局主题变量
 */
class ThemeVars {
  final double radius;
  final double panelMargin;
  final double buttonLargeHeight;
  final double buttonLargeFontSize;
  final Color scaffoldBackground;
  final Color contentBackground;
  final Color textColor;
  final Color secondaryTextColor;
  
  const ThemeVars({
    this.radius = 8, // 圆角大小
    this.panelMargin = 10, // 卡片margin

    this.buttonLargeHeight = 48, // 按钮Large高度 (与输入框对齐)
    this.buttonLargeFontSize = 16, // 按钮Large字体大小

    required this.scaffoldBackground, // 页面背景色
    required this.contentBackground, // 内容背景色
    required this.textColor, // 文字颜色
    required this.secondaryTextColor, // 次要文字颜色
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
     * 默认字体
     */
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontSize: 16,
      ),
    ),

    /* 
     * AppBar
     */
    appBarTheme: AppBarTheme(
      centerTitle: true,
    ),

    /* 
     * 按钮
     */
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: const Color.fromRGBO(220, 220, 220, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(vars.radius),
        ),
      ),
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
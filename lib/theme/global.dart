import 'package:flutter/material.dart';

/* 
 * 全局变量
 */
const double radius = 4; // 圆角大小

/* 
 * 主题色
 */
ColorScheme getGlobalColorScheme() {
  return ColorScheme.fromSeed(
    seedColor: Color.fromRGBO(255, 92, 5, 1),
    primary: Color.fromRGBO(255, 92, 5, 1),
    secondary: Color.fromRGBO(255, 190, 155, 1),
    surface: Color.fromRGBO(255, 239, 230, 1),
    onSurface: Color.fromRGBO(255, 92, 5, 1),
  );
}

/* 
 * 全局主题
 */
ThemeData getGlobalThemeData() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: getGlobalColorScheme(),
    scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),

    /* 
     * AppBar
     */
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),

    /* 
     * 按钮
     */
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
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

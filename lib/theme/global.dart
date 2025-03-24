import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/global/state.dart';

import 'package:flutter_demo/theme/light.dart';
import 'package:flutter_demo/theme/dark.dart';
import 'package:flutter_demo/theme/base.dart';

// 导出主题文件
export 'package:flutter_demo/theme/light.dart';
export 'package:flutter_demo/theme/dark.dart';
export 'package:flutter_demo/theme/base.dart';

/* 
 * 全局变量
 */
// 圆角大小
const double radius = 4;
// 卡片margin
const double cardMargin = 10;

/* 
 * 主题管理
 * 包含浅色主题和深色主题
 */

// 共享的基础主题设置
ThemeData _baseThemeData(ColorScheme colorScheme) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,

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
    background: const Color.fromRGBO(255, 255, 255, 1),
  );
}

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
    background: const Color.fromRGBO(30, 30, 30, 1),
  );
}

/* 
 * 浅色主题
 */
ThemeData getLightThemeData() {
  final colorScheme = getLightColorScheme();
  final baseTheme = _baseThemeData(colorScheme);
  
  return baseTheme.copyWith(
    scaffoldBackgroundColor: colorScheme.background,
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
  );
}

/* 
 * 深色主题
 */
ThemeData getDarkThemeData() {
  final colorScheme = getDarkColorScheme();
  final baseTheme = _baseThemeData(colorScheme);
  
  return baseTheme.copyWith(
    scaffoldBackgroundColor: colorScheme.background,
    cardTheme: CardTheme(
      color: const Color.fromRGBO(45, 45, 45, 1),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
  );
}

/* 
 * 获取当前主题的变量
 * 根据当前主题状态返回对应的主题变量
 */
ThemeVars getCurrentThemeVars(BuildContext context) {
  final globalState = Provider.of<GlobalState>(context);
  
  // 判断当前是否是深色模式
  final bool isDarkMode = globalState.isDarkMode || 
    (globalState.themeMode == ThemeMode.system && 
     MediaQuery.of(context).platformBrightness == Brightness.dark);
  
  // 返回对应的主题变量
  return isDarkMode ? darkThemeVars : lightThemeVars;
}

/* 
 * 向后兼容的方法，兼容旧版本代码
 * @deprecated 建议直接使用 getLightThemeData()
 */
ThemeData getGlobalThemeData() {
  return getLightThemeData();
}

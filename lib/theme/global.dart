import 'package:flutter/material.dart';

/* 
 * 全局主题
 */
ThemeData getGlobalThemeData() {
  return ThemeData(
    useMaterial3: true,
    // 为所有平台统一使用 iOS 风格的转场动画
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

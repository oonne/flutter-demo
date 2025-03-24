import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/global/state.dart';

import 'package:flutter_demo/theme/light.dart';
import 'package:flutter_demo/theme/dark.dart';
import 'package:flutter_demo/theme/base.dart';

// 导出主题
export 'package:flutter_demo/theme/light.dart';
export 'package:flutter_demo/theme/dark.dart';
export 'package:flutter_demo/theme/base.dart';

/* 
 * 判断当前是否是深色模式
 */
bool isDarkMode(BuildContext context) {
  final globalState = Provider.of<GlobalState>(context);
  return globalState.themeMode == ThemeMode.dark || 
    (globalState.themeMode == ThemeMode.system && 
     MediaQuery.of(context).platformBrightness == Brightness.dark);
}

/* 
 * 获取当前主题颜色
 */
ColorScheme getCurrentThemeColorScheme(BuildContext context) {
  return isDarkMode(context) ? getDarkColorScheme() : getLightColorScheme();
}

/* 
 * 获取当前主题的变量
 */
ThemeVars getCurrentThemeVars(BuildContext context) {
  return isDarkMode(context) ? darkThemeVars : lightThemeVars;
}
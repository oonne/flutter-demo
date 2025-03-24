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
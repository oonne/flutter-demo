import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
 * 全局的状态管理
 */
class GlobalState extends ChangeNotifier {
  /* 
   * 主题管理 （深色/浅色切换
   */
  ThemeMode themeMode = ThemeMode.system;
  
  // 设置主题模式
  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('THEME_MODE', mode.toString());
  }
  
  // 初始化全局状态
  Future<void> initThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('THEME_MODE');
    if (themeModeString != null) {
      if (themeModeString == ThemeMode.light.toString()) {
        themeMode = ThemeMode.light;
      } else if (themeModeString == ThemeMode.dark.toString()) {
        themeMode = ThemeMode.dark;
      } else {
        themeMode = ThemeMode.system;
      }
    }
  }


  /* 
   * 全局数字
   */
  int globalNum = 100;

  // 设置全局数字
  void setGlobalNum(int num) {
    globalNum = num;
    notifyListeners();
  }
}

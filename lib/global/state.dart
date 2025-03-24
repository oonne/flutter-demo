import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
 * 全局的状态管理
 */
class GlobalState extends ChangeNotifier {
  /* 
   * 主题管理
   */
  ThemeMode _themeMode = ThemeMode.system;
  
  // 获取当前主题模式
  ThemeMode get themeMode => _themeMode;
  
  // 是否是深色模式
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  // 切换主题模式
  Future<void> toggleThemeMode() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _saveThemeMode();
    notifyListeners();
  }
  
  // 设置特定主题模式
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _saveThemeMode();
    notifyListeners();
  }
  
  // 保存主题模式到本地存储
  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', _themeMode.toString());
  }
  
  // 从本地存储加载主题模式
  Future<void> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('theme_mode');
    if (themeModeString != null) {
      if (themeModeString == ThemeMode.light.toString()) {
        _themeMode = ThemeMode.light;
      } else if (themeModeString == ThemeMode.dark.toString()) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.system;
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

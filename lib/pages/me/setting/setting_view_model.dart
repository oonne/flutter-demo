import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/global/state.dart';

import 'setting_model.dart';

class SettingViewModel extends ChangeNotifier {
  final SettingModel model = SettingModel();

  /* 
   * 初始化
   */
  void init(BuildContext context) {
    initThemeMode(context);
  }

  /* 
   * 主题
   */
  // 获取主题模式
  ThemeMode get themeMode => model.themeMode;

  // 获取主题模式的中文描述
  String get themeModeText {
    switch (model.themeMode) {
      case ThemeMode.light:
        return '浅色';
      case ThemeMode.dark:
        return '深色';
      case ThemeMode.system:
        return '跟随系统';
    }
  }

  // 初始化主题模式
  void initThemeMode(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    model.themeMode = globalState.themeMode;
    notifyListeners();
  }

  // 切换主题模式
  Future<void> toggleThemeMode(BuildContext context) async {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    ThemeMode newMode;
    
    switch (model.themeMode) {
      case ThemeMode.light:
        newMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        newMode = ThemeMode.system;
        break;
      case ThemeMode.system:
        newMode = ThemeMode.light;
        break;
    }
    
    await globalState.setThemeMode(newMode);
    model.themeMode = newMode;
    notifyListeners();
  }
} 
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

  // 初始化主题模式
  void initThemeMode(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    model.themeMode = globalState.themeMode;
    notifyListeners();
  }

  // 主题模式映射
  final List<Map<String, dynamic>> themeModeOptions = [
    {'mode': ThemeMode.light, 'text': '浅色'},
    {'mode': ThemeMode.dark, 'text': '深色'},
    {'mode': ThemeMode.system, 'text': '跟随系统'},
  ];

  // 获取主题模式文案
  String get themeModeText {
    final option = themeModeOptions.firstWhere(
      (option) => option['mode'] == model.themeMode,
      orElse: () => themeModeOptions[0],
    );
    return option['text'];
  }

  // 切换主题模式
  Future<void> changeThemeMode(BuildContext context, ThemeMode newMode) async {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    await globalState.setThemeMode(newMode);
    model.themeMode = newMode;
    notifyListeners();
  }
} 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/generated/i18n/app_localizations.dart';

import 'package:flutter_demo/config/lang_list.dart';
import 'package:flutter_demo/global/state.dart';
import 'package:flutter_demo/utils/message.dart';
import 'package:flutter_demo/widget/bottom_sheet/selection_bottom_sheet.dart';

import 'setting_model.dart';

class SettingViewModel extends ChangeNotifier {
  final SettingModel model = SettingModel();

  /* 
   * 初始化
   */
  void init(BuildContext context) {
    initThemeMode(context);
    initLocale(context);
  }

  /* 
   * 主题
   */
  // 初始化主题模式
  void initThemeMode(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    model.themeMode = globalState.themeMode;
    notifyListeners();
  }

  // 主题模式映射
  List<Map<String, dynamic>> getThemeModeOptions(BuildContext context) {
    return [
      {'mode': ThemeMode.system, 'text': AppLocalizations.of(context)!.theme_follow_system},
      {'mode': ThemeMode.light, 'text': AppLocalizations.of(context)!.theme_light},
      {'mode': ThemeMode.dark, 'text': AppLocalizations.of(context)!.theme_dark},
    ];
  }

  // 获取主题模式文案
  String getThemeModeText(BuildContext context) {
    final options = getThemeModeOptions(context);
    final option = options.firstWhere(
      (option) => option['mode'] == model.themeMode,
      orElse: () => options[0],
    );
    return option['text'];
  }

  // 切换主题模式
  Future<void> changeThemeMode(BuildContext context) async {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    final themeModeOptions = getThemeModeOptions(context);

    // 使用 SelectionBottomSheet 组件
    final result = await SelectionBottomSheet.show<ThemeMode>(
      context: context,
      title: '选择主题模式',
      options:
          themeModeOptions.map((option) {
            return {'value': option['mode'], 'text': option['text']};
          }).toList(),
      selectedValue: model.themeMode,
    );

    // 如果用户选择了一个选项
    if (result == null) {
      return;
    }

    await globalState.setThemeMode(result);
    model.themeMode = result;
    notifyListeners();
  }

  /* 
   * 语言
   */
  // 获取语言
  String get localeText {
    final option = langList.firstWhere(
      (option) => option['code'] == model.localeCode,
      orElse: () => langList[0],
    );
    return option['name'];
  }

  // 初始化语言
  void initLocale(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    model.localeCode = globalState.lang;
    notifyListeners();
  }

  // 切换语言
  Future<void> changeLocale(BuildContext context) async {
    final globalState = Provider.of<GlobalState>(context, listen: false);

    // 使用 SelectionBottomSheet 组件
    final result = await SelectionBottomSheet.show<String>(
      context: context,
      title: AppLocalizations.of(context)!.language_setting,
      options:
          langList.map((option) {
            return {'value': option['code'], 'text': option['name']};
          }).toList(),
      selectedValue: model.localeCode,
    );

    // 如果用户选择了一个选项
    if (result == null) {
      return;
    }

    await globalState.changeLocale(result);
    model.localeCode = result;
    notifyListeners();
  }

  /* 
   * 退出登录
   */
  Future<void> logout(BuildContext context) async {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    await globalState.clear();
    if (!context.mounted) {
      return;
    }
    showTextSnackBar(context, msg: AppLocalizations.of(context)!.msg_logout);
  }
}

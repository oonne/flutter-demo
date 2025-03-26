import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:flutter_demo/utils/log.dart';

import 'setting_model.dart';

class SettingViewModel extends ChangeNotifier {
  final SettingModel model = SettingModel();

  /* 
   * 初始化
   */
  void init() {
    getVersion();
  }

  /* 
   * 版本号
   */
  String get version => model.version;

  // 获取版本号
  Future<void> getVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      model.version = '${packageInfo.version}(${packageInfo.buildNumber})';
    } catch (e) {
      log.severe('获取版本号失败', e);
      model.version = '-';
    }

    log.severe('版本号: ${model.version}');
    notifyListeners();
  }
} 
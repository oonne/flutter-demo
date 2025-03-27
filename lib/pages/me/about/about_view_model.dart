import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_demo/utils/log.dart';

import 'about_model.dart';

class AboutViewModel extends ChangeNotifier {
  final AboutModel model = AboutModel();

  /* 
   * 初始化
   */
  void init() {
    getVersion();
    initEnvironment();
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

  /* 
   * 环境
   */
  String get environment => model.environment;

  // 初始化环境
  Future<void> initEnvironment() async {
    model.environment = dotenv.env['ENV_NAME'] ?? '';
  }
} 
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_demo/utils/toast.dart';
import 'package:flutter_demo/widget/bottom_sheet/selection_bottom_sheet.dart';

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

  // 环境列表
  List<Map<String, dynamic>> get environmentList => [
    {'name': 'dev', 'text': 'dev 开发环境'},
    {'name': 'prod', 'text': 'prod 生产环境'},
  ];

  // 获取当前环境文案
  String get environmentText =>
      environmentList.firstWhere(
        (item) => item['name'] == environment,
        orElse: () => environmentList[0],
      )['text'];

  // 切换环境
  Future<void> changeEnv(BuildContext context) async {
    // 使用 SelectionBottomSheet 组件
    final result = await SelectionBottomSheet.show<String>(
      context: context,
      title: '选择环境',
      options:
          environmentList
              .map((item) => {'value': item['name'], 'text': item['text']})
              .toList(),
      selectedValue: environment,
    );

    // 如果用户选择了一个选项
    if (result == null) {
      return;
    }

    // 更新环境
    if (result == 'prod') {
      await dotenv.load(fileName: ".env");
    } else {
      await dotenv.load(fileName: ".env.$result");
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ENV', result);
    model.environment = result;
    notifyListeners();

    // 提示
    if (context.mounted) {
      showTextSnackBar(context, msg: '环境切换为: $result');
    }
  }
}

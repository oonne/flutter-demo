import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/global/state.dart';
import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_demo/utils/toast.dart';
import 'package:flutter_demo/widget/bottom_sheet/selection_bottom_sheet.dart';

import 'about_model.dart';

class AboutViewModel extends ChangeNotifier {
  final AboutModel model = AboutModel();

  /* 
   * 初始化
   */
  void init(BuildContext context) {
    getVersion();
    initEnvironment(context);
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
  // 初始化环境
  Future<void> initEnvironment(context) async {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    model.environment = globalState.env;
  }

  // 环境列表
  List<Map<String, dynamic>> get environmentList => [
    {'name': 'dev', 'text': 'dev 开发环境'},
    {'name': 'prod', 'text': 'prod 生产环境'},
  ];

  // 获取当前环境文案
  String getEnvText(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    return environmentList.firstWhere((item) => item['name'] == globalState.env)['text'];
  }

  // 切换环境
  Future<void> changeEnv(BuildContext context) async {
    final globalState = Provider.of<GlobalState>(context, listen: false);

    // 使用 SelectionBottomSheet 组件
    final result = await SelectionBottomSheet.show<String>(
      context: context,
      title: '选择环境',
      options:
          environmentList
              .map((item) => {'value': item['name'], 'text': item['text']})
              .toList(),
      selectedValue: globalState.env,
    );

    // 如果用户选择了一个选项
    if (result == null) {
      return;
    }

    // 更新环境
    await globalState.changeEnv(result);
    model.environment = result;
    notifyListeners();

    // 提示
    if (context.mounted) {
      showTextSnackBar(context, msg: '环境切换为: $result');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_demo/database/database_service.dart';
import 'splash_model.dart';

class SplashViewModel extends ChangeNotifier {
  final SplashModel model = SplashModel();

  // 广告是否已展示（从Model获取）
  bool get isAdShown => model.isAdShown;

  // 是否已完成隐私协议读取
  bool get privacyChecked => model.privacyChecked;

  // 是否已同意用户协议和隐私政策
  bool get acceptedPrivacyPolicy => model.acceptedPrivacyPolicy;

  /*
   * 进入逻辑
   */
  Future<void> enter(BuildContext context) async {
    // 后台预初始化数据库（不阻塞广告展示）
    DatabaseService.instance.preInitialize();

    // 读取隐私协议同意状态，只有已同意才加载开屏广告
    final prefs = await SharedPreferences.getInstance();
    final accepted = prefs.getBool('ACCEPTED_PRIVACY_POLICY') ?? false;
    model.setAcceptedPrivacyPolicy(accepted);
    notifyListeners();
  }

  /*
   * 同意用户协议和隐私政策
   */
  Future<void> agreePrivacyPolicy(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ACCEPTED_PRIVACY_POLICY', true);
    model.setAcceptedPrivacyPolicy(true);

    // 同意后直接进入首页
    if (!context.mounted) {
      return;
    }
    _navigateToHome(context);
  }

  /*
   * 广告展示成功回调
   */
  void onAdShow() {
    // 广告展示成功，更新Model状态并通知UI
    model.setAdShown(true);
    notifyListeners();
  }

  /*
   * 用户点击跳过回调
   */
  void onAdSkip(BuildContext context) {
    _navigateToHome(context);
  }

  /*
   * 广告倒计时结束回调
   */
  void onAdFinish(BuildContext context) {
    _navigateToHome(context);
  }

  /*
   * 广告加载超时回调
   */
  void onAdTimeOut(BuildContext context) {
    _navigateToHome(context);
  }

  /*
   * 广告加载失败回调
   */
  void onAdFail(BuildContext context, String error) {
    _navigateToHome(context);
  }

  /*
   * 跳转到首页
   */
  void _navigateToHome(BuildContext context) {
    context.goNamed('home');
  }
}

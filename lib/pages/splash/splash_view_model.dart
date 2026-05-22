import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'splash_model.dart';

class SplashViewModel extends ChangeNotifier {
  final SplashModel model = SplashModel();

  // 广告是否已展示（从Model获取）
  bool get isAdShown => model.isAdShown;

  /* 
   * 进入逻辑
   */
  Future<void> enter(BuildContext context) async {
    // 开屏广告组件会处理广告展示，跳转逻辑在回调中处理。此处暂时没有其他业务逻辑。
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
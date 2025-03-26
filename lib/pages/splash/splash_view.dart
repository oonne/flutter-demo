import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'splash_view_model.dart';

/* 
 * Splash页面
 */
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final SplashViewModel _viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    _viewModel = SplashViewModel();

    // 执行进入逻辑
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.enter(context);
    });
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<SplashViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/img/logo.png', width: 100, height: 100),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

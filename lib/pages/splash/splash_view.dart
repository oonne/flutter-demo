import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'splash_view_model.dart';
import 'package:flutter_demo/widget/ad/widgets/splash_ad_widget.dart';

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
            body: Stack(
              children: [
                // 背景Logo：广告未展示时显示
                if (!viewModel.isAdShown)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/img/logo.png', width: 100, height: 100),
                      ],
                    ),
                  ),
                // 开屏广告
                SplashAdWidget(
                  hideSkip: false,
                  timeout: 3000,
                  onShow: viewModel.onAdShow,
                  onSkip: () => viewModel.onAdSkip(context),
                  onFinish: () => viewModel.onAdFinish(context),
                  onTimeOut: () => viewModel.onAdTimeOut(context),
                  onFail: (error) => viewModel.onAdFail(context, error),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

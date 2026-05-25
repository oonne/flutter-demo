import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'splash_view_model.dart';
import 'package:flutter_demo/widget/ad/widgets/splash_ad_widget.dart';
import 'package:flutter_demo/generated/i18n/app_localizations.dart';

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
          return Scaffold(
            body: Column(
              children: [
                // 开屏广告 - 占屏幕85%
                Expanded(
                  flex: 85,
                  child: SplashAdWidget(
                    heightFraction: 0.85,
                    onShow: viewModel.onAdShow,
                    onSkip: () => viewModel.onAdSkip(context),
                    onFinish: () => viewModel.onAdFinish(context),
                    onTimeOut: () => viewModel.onAdTimeOut(context),
                    onFail: (error) => viewModel.onAdFail(context, error),
                  ),
                ),
                // 底部Logo和App名称 - 占屏幕15%
                Expanded(
                  flex: 15,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/img/logo.png', width: 36, height: 36),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)!.app_name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

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

  @override
  void initState() {
    super.initState();
    _viewModel = SplashViewModel();
    
    // 执行进入逻辑
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.enter(context);
    });
  }

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
            appBar: AppBar(title: Text('Splash页面')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('LOGO'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

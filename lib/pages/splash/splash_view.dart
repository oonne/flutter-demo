import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart'; 

import 'splash_view_model.dart';

/* 
 * Splash页面
 */
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = SplashViewModel();
        return viewModel;
      },
      child: Consumer<SplashViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(title: Text('Splash页面')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('LOGO'),
                  const SizedBox(height: 20),
                  CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.goNamed('home');
                    },
                    child: const Text('跳转首页'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

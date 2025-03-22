import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'splash_model.dart';

class SplashViewModel extends ChangeNotifier {
  final SplashModel model = SplashModel();

  /* 
   * 进入逻辑
   */
  Future<void> enter(BuildContext context) async {
    context.goNamed('home');
  }
} 
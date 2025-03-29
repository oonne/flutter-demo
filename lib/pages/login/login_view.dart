import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_view_model.dart';

/* 
 * 登录页
 */
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = LoginViewModel();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* 
                   * LOGO
                   */
                  Image.asset('assets/img/logo.png', width: 100, height: 100),

                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        /* 
                          * 账号
                          */
                        TextField(
                          controller: viewModel.nameController,
                          decoration: const InputDecoration(labelText: '账号'),
                        ),

                        /* 
                          * 密码
                          */
                        TextField(
                          controller: viewModel.passwordController,
                          decoration: const InputDecoration(labelText: '密码'),
                        ),
                      ],
                    ),
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

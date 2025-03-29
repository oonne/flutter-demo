import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/theme/global.dart';

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
    final themeVars = getCurrentThemeVars(context);

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

                  /* 
                  * 账号
                  */
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: viewModel.nameController,
                      decoration: InputDecoration(
                        labelText: '账号',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                        errorText: viewModel.nameError,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  /* 
                  * 密码
                  */
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: viewModel.passwordController,
                      obscureText: !viewModel.isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: '密码',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                        errorText: viewModel.passwordError,
                        suffixIcon: IconButton(
                          icon: Icon(
                            viewModel.isPasswordVisible 
                              ? Icons.visibility 
                              : Icons.visibility_off,
                            size: 16,
                          ),
                          onPressed: () {
                            viewModel.togglePasswordVisibility();
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  /* 
                  * 登录按钮
                  */
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    height: themeVars.buttonLargeHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.login();
                      },
                      child: Text(
                        '登录',
                        style: TextStyle(
                          fontSize: themeVars.buttonLargeFontSize,
                        ),
                      ),
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

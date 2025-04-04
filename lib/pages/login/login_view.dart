import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/theme/global.dart';
import 'package:flutter_demo/generated/i18n/app_localizations.dart';

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
                  const SizedBox(height: 36),

                  /* 
                  * 账号
                  */
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: themeVars.panelMargin),
                    child: TextField(
                      controller: viewModel.nameController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.account,
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                        errorText: viewModel.model.nameError,
                      ),
                    ),
                  ),
                  SizedBox(height: themeVars.panelMargin),

                  /* 
                  * 密码
                  */
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: themeVars.panelMargin),
                    child: TextField(
                      controller: viewModel.passwordController,
                      obscureText: !viewModel.model.isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.password,
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                        errorText: viewModel.model.passwordError,
                        suffixIcon: IconButton(
                          icon: Icon(
                            viewModel.model.isPasswordVisible
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
                  SizedBox(height: themeVars.panelMargin),

                  /* 
                  * 登录按钮
                  */
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: themeVars.panelMargin),
                    width: double.infinity,
                    height: themeVars.buttonLargeHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.login(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (viewModel.model.isLoading) ...[
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            AppLocalizations.of(context)!.btn_login,
                            style: TextStyle(
                              fontSize: themeVars.buttonLargeFontSize,
                            ),
                          ),
                        ],
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/generated/i18n/app_localizations.dart';

import 'package:flutter_demo/theme/global.dart';
import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/panel/panel.dart';
import 'package:flutter_demo/widget/panel/panel_item.dart';

import 'setting_view_model.dart';

/* 
 * 设置页面
 */
class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  late final SettingViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = SettingViewModel();

    // 在下一帧初始化 viewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(context);
    });
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<SettingViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(
              title: Text(AppLocalizations.of(context)!.title_setting),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Panel(
                    children: [
                      /* 主题 */
                      PanelItem(
                        label: AppLocalizations.of(context)!.theme,
                        value: viewModel.getThemeModeText(context),
                        showArrow: true,
                        onTap: () {
                          viewModel.changeThemeMode(context);
                        },
                      ),
                      /* 语言 */
                      PanelItem(
                        label: AppLocalizations.of(context)!.language,
                        value: viewModel.localeText,
                        showArrow: true,
                        onTap: () {
                          viewModel.changeLocale(context);
                        },
                      ),
                    ],
                  ),

                  /* 
                  * 退出登录按钮
                  */
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: themeVars.panelMargin),
                    width: double.infinity,
                    height: themeVars.buttonLargeHeight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        AppLocalizations.of(context)!.btn_login,
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

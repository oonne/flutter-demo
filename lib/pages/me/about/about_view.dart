import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_demo/generated/i18n/app_localizations.dart';

import 'package:flutter_demo/global/state.dart';
import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/panel/panel.dart';
import 'package:flutter_demo/widget/panel/panel_item.dart';
import 'package:flutter_demo/widget/panel/form_switch.dart';

import 'about_view_model.dart';

/* 
 * 关于页面
 */
class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  late final AboutViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = AboutViewModel();

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
    final globalState = Provider.of<GlobalState>(context, listen: true);

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<AboutViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(
              title: Text(AppLocalizations.of(context)!.title_about),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Panel(
                    children: [
                      // Logo 和 App名称
                      PanelItem(
                        footer: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Column(
                              children: [
                                // Logo
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                      image: AssetImage('assets/img/logo.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // App名称
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    AppLocalizations.of(context)!.app_name,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 版本号
                      PanelItem(
                        label: AppLocalizations.of(context)!.title_version,
                        value: viewModel.model.version,
                      ),
                      // 开发者
                      PanelItem(
                        label: AppLocalizations.of(context)!.title_developer,
                        value: 'JAY',
                      ),
                    ],
                  ),

                  /* 
                   * 非正式环境
                   * 调试用功能
                   */
                  if (!globalState.isRelease || globalState.env != 'prod') ...[
                    Panel(
                      children: [
                        // Flavor
                      PanelItem(label: AppLocalizations.of(context)!.title_channel, value: globalState.flavor),

                      // 环境
                      PanelItem(
                        label: AppLocalizations.of(context)!.title_environment,
                        value: viewModel.getEnvText(context),
                        onTap: () => viewModel.changeEnv(context),
                      ),

                      // 是否开启广告
                      FormSwitch(
                        label: AppLocalizations.of(context)!.title_show_ad,
                        switchValue: viewModel.model.isShowAd,
                        onChanged: (value) {
                          viewModel.setIsShowAd(context, value);
                        },
                      ),

                        // Demo
                        PanelItem(
                          label: 'DEMO',
                          showArrow: true,
                          onTap: () {
                            GoRouter.of(context).pushNamed('demo');
                          },
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

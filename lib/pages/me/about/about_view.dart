import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_demo/generated/i18n/app_localizations.dart';

import 'package:flutter_demo/global/state.dart';
import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/panel/panel.dart';
import 'package:flutter_demo/widget/panel/panel_item.dart';

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
                      // 版本号
                      PanelItem(
                        label: AppLocalizations.of(context)!.title_version,
                        value: viewModel.version,
                      ),

                      // 环境
                      if (!globalState.isRelease) ...[
                        PanelItem(
                          label: '环境',
                          value: viewModel.getEnvText(context),
                          onTap: () => viewModel.changeEnv(context),
                        ),
                      ],

                      // Demo
                      // if (globalState.env != 'prod') ...[
                        PanelItem(
                          label: 'DEMO',
                          showArrow: true,
                          onTap: () {
                            GoRouter.of(context).pushNamed('demo');
                          },
                        ),
                      // ],
                    ],
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

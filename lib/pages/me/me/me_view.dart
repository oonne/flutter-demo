import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_demo/global/state.dart';
import 'package:flutter_demo/widget/panel/panel.dart';
import 'package:flutter_demo/widget/panel/panel_item.dart';

import 'me_view_model.dart';

/* 
 * 个人中心
 */
class MeView extends StatefulWidget {
  const MeView({super.key});

  @override
  State<MeView> createState() => _MeViewState();
}

class _MeViewState extends State<MeView> {
  late final MeViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = MeViewModel();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: true);

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<MeViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Panel(
                      children: [
                        // Demo
                        if (globalState.env != 'prod') ...[
                          PanelItem(
                            label: 'DEMO',
                            showArrow: true,
                            onTap: () {
                              GoRouter.of(context).pushNamed('demo');
                            },
                          ),
                        ],

                        // 设置
                        PanelItem(
                          label: AppLocalizations.of(context)!.title_setting,
                          showArrow: true,
                          onTap: () {
                            GoRouter.of(context).pushNamed('me/setting');
                          },
                        ),

                        // 关于
                        PanelItem(
                          label: AppLocalizations.of(context)!.title_about,
                          showArrow: true,
                          onTap: () {
                            GoRouter.of(context).pushNamed('me/about');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

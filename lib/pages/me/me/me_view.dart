import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

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
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<MeViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: AppBar(title: Text('个人中心')),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  /* 标准卡片 */
                  Panel(
                    children: [
                      PanelItem(
                        label: 'DEMO',
                        showArrow: true,
                        onTap: () {
                          GoRouter.of(context).pushNamed('demo');
                        },
                      ),
                      PanelItem(
                        label: '设置',
                        showArrow: true,
                        onTap: () {
                          GoRouter.of(context).pushNamed('me/setting');
                        },
                      ),
                      PanelItem(
                        label: '关于',
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
          );
        },
      ),
    );
  }
}

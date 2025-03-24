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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MeViewModel(),
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
                        label: 'DEMO哈哈愤怒额风格w欧回复飞牛网广佛我刚好耿耿个',
                        value: '哈哈',
                        showArrow: true,
                        onTap: () {
                          GoRouter.of(context).pushNamed('demo');
                        },
                      ),

                      // const Text('设置'),
                      // const Text('关于'),
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

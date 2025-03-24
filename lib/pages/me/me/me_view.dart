import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_demo/theme/global.dart';

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
    // 获取当前主题变量
    final themeVars = getCurrentThemeVars(context);

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
                  Container(
                    margin: EdgeInsets.all(themeVars.panelMargin),
                    decoration: BoxDecoration(
                      color: themeVars.contentBackground,
                      borderRadius: BorderRadius.circular(themeVars.radius),
                    ),
                  ),
                  Center(child: Text('个人中心')),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed('demo');
                    },
                    child: const Text('Demo'),
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

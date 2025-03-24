import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_demo/widget/panel/panel.dart';

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
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).pushNamed('demo');
                        },
                        child: Row(
                          children: [
                            Text('DEMO'),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                      const Text('设置'),
                      const Text('关于'),
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

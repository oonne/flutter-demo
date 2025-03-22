import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'me_view_model.dart';

/* 
 * 个人中心
 */
class MeView extends StatelessWidget {
  const MeView({super.key});

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
            body: Column(
              children: [Text('个人中心')],
            ),
          );
        },
      ),
    );
  }
}

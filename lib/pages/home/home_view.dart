import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart'; 
import 'package:flutter_demo/global/state.dart';

import 'home_view_model.dart';

/* 
 * 首页
 */
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: true);

    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = HomeViewModel();
        viewModel.init();
        return viewModel;
      },
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: AppBar(title: Text('首页测试')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* 
                   * 页面数字
                   */
                  Text('页面数字：${viewModel.number}'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: viewModel.add,
                        child: const Text('+'),
                      ),
                      ElevatedButton(
                        onPressed: viewModel.sub,
                        child: const Text('-'),
                      ),
                    ],
                  ),

                  /* 
                   * 全局数字
                   */
                  Text('全局数字：${globalState.globalNum}'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          globalState.setGlobalNum(globalState.globalNum + 1);
                        },
                        child: const Text('+'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          globalState.setGlobalNum(globalState.globalNum - 1);
                        },
                        child: const Text('-'),
                      ),
                    ],
                  ),

                  /* 跳转DEMO页面 */
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed('demo', extra: {
                        'num': viewModel.number,
                      });
                    },
                    child: const Text('跳转DEMO'),
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

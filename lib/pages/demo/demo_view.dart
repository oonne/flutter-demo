import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_demo/global/state.dart';

import 'demo_view_model.dart';

/* 
 * DEMO页面
 */
class DemoView extends StatelessWidget {
  const DemoView({super.key});

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = DemoViewModel();
        // 获取路由参数
        final queryParameters = GoRouterState.of(context).extra as Map<String, dynamic>?;
        viewModel.init(queryParameters);
        return viewModel;
      },
      child: Consumer<DemoViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: AppBar(title: Text('DEMO页面')),
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

                  /* 
                   * 跳转
                   */
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text('返回'),
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

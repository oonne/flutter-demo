import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_demo/global/state.dart';

import 'mvvm_view_model.dart';

/* 
 * MVVM页面
 */
class MvvmView extends StatefulWidget {
  const MvvmView({super.key});

  @override
  State<MvvmView> createState() => _MvvmViewState();
}

class _MvvmViewState extends State<MvvmView> {
  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: true);

    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = MvvmViewModel();
        // 获取路由参数
        final queryParameters = GoRouterState.of(context).extra as Map<String, dynamic>?;
        viewModel.init(queryParameters);
        return viewModel;
      },
      child: Consumer<MvvmViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: AppBar(title: Text('MVVM示例')),
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

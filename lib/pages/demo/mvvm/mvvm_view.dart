import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/modal/modal_dialog.dart';

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
  late final MvvmViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = MvvmViewModel();

    // 在下一帧初始化 viewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final queryParameters =
          GoRouterState.of(context).extra as Map<String, dynamic>?;
      viewModel.init(queryParameters);
    });
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<MvvmViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(title: const Text('MVVM示例')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* 
                   * 页面数字
                   */
                  Text('页面数字：${viewModel.model.number}'),
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
                   * 模态弹框
                   */
                  ElevatedButton(
                    onPressed: () {
                      showModal(
                        context: context,
                        showCancelButton: true,
                        barrierDismissible: true,
                        onConfirm: () {
                          debugPrint('点击了确定按钮');
                        },
                        child: const Text('模态弹框'),
                      );
                    },
                    child: const Text('模态弹框'),
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

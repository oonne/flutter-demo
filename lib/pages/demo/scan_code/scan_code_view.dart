import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/utils/message.dart';

import 'scan_code_view_model.dart';

/* 
 * ScanCode页面
 */
class ScanCodeView extends StatefulWidget {
  const ScanCodeView({super.key});

  @override
  State<ScanCodeView> createState() => _ScanCodeViewState();
}

class _ScanCodeViewState extends State<ScanCodeView> {
  late final ScanCodeViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = ScanCodeViewModel();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ScanCodeViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(title: const Text('扫码')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final result = await context.pushNamed(
                        'scan',
                        extra: {'returnAfterScan': true},
                      );
                      if (result != null && context.mounted) {
                        showTextSnackBar(context, msg: '扫码结果: $result');
                      }
                    },
                    child: const Text('扫码并返回'),
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed('scan');
                    },
                    child: const Text('扫码并跳到结果页面'),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/utils/message.dart';

import 'calc_sha_view_model.dart';

/* 
 * CalcSha页面
 */
class CalcShaView extends StatefulWidget {
  const CalcShaView({super.key});

  @override
  State<CalcShaView> createState() => _CalcShaViewState();
}

class _CalcShaViewState extends State<CalcShaView> {
  late final CalcShaViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = CalcShaViewModel();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<CalcShaViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(title: const Text('计算SHA')),
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

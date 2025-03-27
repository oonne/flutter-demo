import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/modal/modal_dialog.dart';

import 'req_view_model.dart';

/* 
 * 网络请求
 */
class ReqView extends StatefulWidget {
  const ReqView({super.key});

  @override
  State<ReqView> createState() => _ReqViewState();
}

class _ReqViewState extends State<ReqView> {
  late final ReqViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = ReqViewModel();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ReqViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(title: const Text('网络请求')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 
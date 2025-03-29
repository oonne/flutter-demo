import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/layout/custom_app_bar.dart';

import 'scan_result_view_model.dart';

/* 
 * 扫码结果
 */
class ScanResultView extends StatefulWidget {
  const ScanResultView({super.key});

  @override
  State<ScanResultView> createState() => _ScanResultViewState();
}

class _ScanResultViewState extends State<ScanResultView> {
  late final ScanResultViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = ScanResultViewModel();

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
      child: Consumer<ScanResultViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(
              title: Text(AppLocalizations.of(context)!.title_scan_result),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  /* 
                   * 扫码结果
                   */
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: viewModel.resultTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                  ),

                  /* 
                   * 复制按钮
                   */
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(AppLocalizations.of(context)!.btn_copy),
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

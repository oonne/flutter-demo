import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'scan_view_model.dart';

/* 
 * 扫描页面
 */
class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  late final ScanViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = ScanViewModel();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ScanViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(children: [
                  Placeholder(),
                  const SizedBox(height: 20),
                  Text('扫描页面TODO'),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

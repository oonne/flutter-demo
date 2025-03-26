import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';

import 'index_view_model.dart';

/* 
 * Demo
 */
class IndexView extends StatefulWidget {
  const IndexView({super.key});

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  late final IndexViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = IndexViewModel();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<IndexViewModel>(
        builder: (context, viewModel, child) {
          /* 
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(
              title: const Text('Demo'),
            ),
            body: Column(
              children: [
                /* Mvvm示例 */
                const SizedBox(height: 20, width: double.infinity),
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed('demo/mvvm', extra: {'num': 123});
                  },
                  child: const Text('Mvvm示例'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

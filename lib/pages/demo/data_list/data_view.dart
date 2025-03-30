import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';

import 'data_view_model.dart';

/* 
 * 网络请求
 */
class DataListView extends StatefulWidget {
  const DataListView({super.key});

  @override
  State<DataListView> createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> {
  late final DataListViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = DataListViewModel();
  }

  /* 
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<DataListViewModel>(
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
                   * 请求
                   */
                  Text('请求结果: ${viewModel.model.result}'),
                  Text('请求错误: ${viewModel.model.error}'),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      viewModel.request(context);
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (viewModel.model.isLoading) ...[
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          const Text('请求'),
                        ],
                      ),
                    ),
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
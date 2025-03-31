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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* 
                  * 头部内容
                  */
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.red.shade600,
                  child: Text(
                    '头部内容',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                /* 
                 * 列表内容
                 */
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Text('列表内容');
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

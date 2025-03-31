import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/widget/data_list/data_list_view.dart';

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
                 * 列表内容
                 */
                Expanded(
                  child: EasyRefreshDataList(
                    dataList: viewModel.model.dataList,
                    itemBuilder: (context, item, index) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          item['redeemCode'] ?? '',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    isLoading: viewModel.model.isLoading,
                    onRefresh: () async {
                      await viewModel.refresh(context);
                    },
                    onLoad: () async {
                      await viewModel.loadMore(context);
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

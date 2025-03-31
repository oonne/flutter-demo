import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';

import 'easy_refresh.dart';

typedef ItemBuilder<T> =
    Widget Function(BuildContext context, T item, int index);

class EasyRefreshDataList<T> extends StatelessWidget {
  /// 数据列表
  final List<T> dataList;

  /// 下拉刷新回调
  final Future<void> Function()? onRefresh;

  /// 上拉加载更多回调
  final Future<void> Function()? onLoad;

  /// 列表项构建器
  final ItemBuilder<T> itemBuilder;

  const EasyRefreshDataList({
    Key? key,
    required this.dataList,
    required this.itemBuilder,
    this.onRefresh,
    this.onLoad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: CustomRefreshHeader(context),
      footer: CustomRefreshFooter(context),
      refreshOnStart: true,
      onRefresh: onRefresh,
      onLoad: onLoad,
      child: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return itemBuilder(context, dataList[index], index);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/api/modules/redeem.dart';
import 'package:flutter_demo/config/config.dart';
import 'package:flutter_demo/utils/message.dart';

import 'data_model.dart';

class DataListViewModel extends ChangeNotifier {
  final DataListModel model = DataListModel();

  /* 
   * 请求列表数据
   */
  Future<void> requestList(BuildContext context) async {
    if (model.isLoading) {
      return;
    }

    model.isLoading = true;
    notifyListeners();

    var [err, res] = await RedeemApi.getList({
      'pageNo': model.pageNo,
      'pageSize': pageSize,
    });

    model.isLoading = false;
    notifyListeners();

    if (err != null) {
      showTextSnackBar(context, msg: getErrorMessage(context, err, defaultMessage: AppLocalizations.of(context)!.msg_query_failed));
      return;
    }

    model.total = res['data']['total'];
    model.pageNo = res['data']['pageNo'];
    if (model.pageNo == 1) {
      model.dataList = [];
      if (res['data']['list'].isEmpty) {
        model.isEmpty = true;
      }
    }
    model.dataList.addAll(res['data']['list']);
    notifyListeners();
  }

  // 刷新
  Future<void> refresh(BuildContext context) async {
    model.pageNo = 1;
    model.total = 0;
    model.isEmpty = false;
    await requestList(context);
  }

  // 加载更多
  Future<void> loadMore(BuildContext context) async {
    if (model.pageNo * pageSize >= model.total || model.isLoading) {
      return;
    }
    model.pageNo++;
    await requestList(context);
  }
} 
import 'package:flutter/material.dart';

import 'package:flutter_demo/database/database.dart';
import 'package:flutter_demo/database/database_service.dart';
import 'package:flutter_demo/config/config.dart';

import 'database_list_model.dart';

class DatabaseListViewModel extends ChangeNotifier {
  final DatabaseListModel model = DatabaseListModel();

  Future<void> requestList(BuildContext context) async {
    if (model.isLoading) {
      return;
    }

    model.isLoading = true;
    notifyListeners();

    final database = DemoDatabase();
    final dao = database.demoDao;

    List<Demo?> results;
    if (model.searchKeyword.isNotEmpty) {
      results = await dao.searchDemos(model.searchKeyword, model.pageNo, pageSize);
    } else {
      results = await dao.getDemosPaged(model.pageNo, pageSize);
    }

    model.isLoading = false;

    if (model.pageNo == 1) {
      model.dataList = [];
      model.isEmpty = results.isEmpty;
    }
    model.dataList.addAll(results);
    
    if (model.pageNo == 1) {
      if (model.searchKeyword.isNotEmpty) {
        model.total = await dao.countSearchDemos(model.searchKeyword);
      } else {
        model.total = await dao.countDemos();
      }
    }
    
    notifyListeners();
  }

  Future<void> refresh(BuildContext context) async {
    model.pageNo = 1;
    model.total = 0;
    model.isEmpty = false;
    await requestList(context);
  }

  Future<void> loadMore(BuildContext context) async {
    if (model.pageNo * pageSize >= model.total || model.isLoading) {
      return;
    }
    model.pageNo++;
    await requestList(context);
  }

  void setSearchKeyword(String keyword) {
    model.searchKeyword = keyword;
    model.pageNo = 1;
    model.total = 0;
    model.isEmpty = false;
  }

  Future<void> deleteDemo(int id) async {
    final database = DemoDatabase();
    await database.demoDao.deleteDemo(id);
  }
} 

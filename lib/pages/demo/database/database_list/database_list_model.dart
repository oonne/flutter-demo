import 'package:flutter_demo/database/database.dart';

class DatabaseListModel {
  bool isLoading = false;
  bool isEmpty = false;
  List<Demo?> dataList = [];
  int total = 0;
  int pageNo = 1;
  String searchKeyword = '';
} 

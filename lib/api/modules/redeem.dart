import 'package:flutter_demo/api/http.dart';

class RedeemApi {
  // 查询兑换码列表
  static getList(Map<String, dynamic> data) async {
    return await req(
      url: '/redeem/get-list',
      data: data,
    );
  }
}

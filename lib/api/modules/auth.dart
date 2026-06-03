import 'package:flutter_demo/api/http.dart';

class AuthApi {
  // 获取登录pow
  static Future<List<dynamic>> getLoginPow(Map<String, dynamic> data) async {
    return await req(
      url: '/auth/get-login-pow',
      data: data,
    );
  }

  // 登录
  static Future<List<dynamic>> login(Map<String, dynamic> data) async {
    return await req(
      url: '/auth/login',
      data: data,
    );
  }

  // 换票
  static Future<List<dynamic>> refreshToken(Map<String, dynamic> data) async {
    return await req(
      url: '/auth/refresh-token',
      data: data,
    );
  }
}

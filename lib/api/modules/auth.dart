import 'package:flutter_demo/api/http.dart';

class AuthApi {
  // 获取登录的pow校验
  static getLoginPow(Map<String, dynamic> data) async {
    return await req(
      url: '/auth/get-login-pow',
      data: data,
    );
  }

  // 登录
  static login(Map<String, dynamic> data) async {
    return await req(
      url: '/auth/login',
      data: data,
    );
  }

  // 换票
  static refreshToken(Map<String, dynamic> data) async {
    return await req(
      url: '/auth/refresh-token',
      data: data,
    );
  }
  
}

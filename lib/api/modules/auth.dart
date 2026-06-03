import 'package:flutter_demo/api/http.dart';

class AuthApi {
  static Future<List<dynamic>> getLoginPow(Map<String, dynamic> data) async {
    return await req(
      url: '/auth/get-login-pow',
      data: data,
    );
  }

  static Future<List<dynamic>> login(Map<String, dynamic> data) async {
    return await req(
      url: '/auth/login',
      data: data,
    );
  }

  static Future<List<dynamic>> refreshToken(Map<String, dynamic> data) async {
    return await req(
      url: '/auth/refresh-token',
      data: data,
    );
  }
  
}

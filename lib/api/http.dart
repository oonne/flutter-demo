import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:flutter_demo/config/config.dart';
import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_demo/utils/utils.dart';

/*
 * 生成请求id
 * 格式： 毫秒时间戳 - UUID末4位 - 4位随机数
 */
Future<String> getRequestId() async {
  final prefs = await SharedPreferences.getInstance();
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final uuid = prefs.getString('UUID') ?? '000000000000';
  final random = randomString(4);
  return '$timestamp-${uuid.substring(uuid.length - 4)}-$random';
}

/*
 * 请求
 */
Dio getDioInstance() {
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['API_URL'] ?? '',
      connectTimeout: const Duration(seconds: apiTimeOut),
    ),
  );

  // 只有在生产环境才使用http2
  if (dotenv.env['ENV_NAME'] == 'prod') {
    dio.httpClientAdapter = Http2Adapter(
      ConnectionManager(idleTimeout: Duration(seconds: apiTimeOut)),
    );
  }

  /*
  * 拦截器
  */
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final prefs = await SharedPreferences.getInstance();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String? token = prefs.getString('TOKEN');
      
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      options.headers['x-version'] = packageInfo.version;
      options.headers['x-uuid'] = prefs.getString('UUID');
      options.headers['x-lang'] = prefs.getString('LANG');
      options.headers['x-reqid'] = await getRequestId();

      return handler.next(options);
    },
  ));

  return dio;
}

/*
 * 异步封装
 */
Future<List<dynamic>> req({String method = 'POST', required String url, Map<String, dynamic>? data, Object? formData}) async {
  Dio dio = getDioInstance();
  dynamic err;
  dynamic res;

  log.finest('🚀发起请求', {'url': '${dio.options.baseUrl}$url', '请求数据': data});

  try {
    Response response;
    switch (method.toUpperCase()) {
      case 'GET':
        response = await dio.get(url, queryParameters: data);
        break;
      case 'POST':
        response = await dio.post(url, data: formData ?? data);
        break;
      case 'PUT':
        response = await dio.put(url, data: data);
        break;
      case 'DELETE':
        response = await dio.delete(url);
        break;
      default:
        throw ArgumentError('Unsupported HTTP method: $method');
    }
    res = response.data;
    log.finest('🎉请求成功', {'url': url, '接口返回': res});
  } catch (e) {
    /* 错误拦截 */
    if (e is DioException && e.type == DioExceptionType.badResponse) {
      err = {
        "code": "status_${(e.response?.statusCode ?? 500).toString()}",
        "message": e.response?.data['message'],
      };
    } else {
      err = {
        "code": 'request_error',
        "message": '请求错误',
      };
    }
    log.warning('💥请求错误', {'url': url, '错误信息': e});
  }

  // 当Code不为0时，抛出异常
  if (res != null && res['code'] != 0) {
    err = {
      ...res,
      "code": 'code_${res['code']}',
    };
    return [err, null];
  }

  // 正常返回
  return [err, res];
}

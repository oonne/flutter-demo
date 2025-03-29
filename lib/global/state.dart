import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_demo/global/event_bus.dart';
import 'package:flutter_demo/config/lang_list.dart';
import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_demo/utils/utils.dart';
import 'package:flutter_demo/models/staff.dart';

/*
 * 全局的状态管理
 */
class GlobalState extends ChangeNotifier {
  /* 
   * 设备信息
   */
  Map<String, dynamic> deviceInfo = {};
  String uuid = '';

  // 获取设备信息
  Future<void> initDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceInfo = androidInfo.data;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      deviceInfo = iosInfo.data;
    }
  }

  // 获取UUID
  Future<void> initUUID() async {
    await initDeviceInfo();
    final prefs = await SharedPreferences.getInstance();

    // iOS 不获取广告id，因为广告id需要用户授权，影响体验
    if (Platform.isIOS && deviceInfo['identifierForVendor'] != null) {
      uuid = deviceInfo['identifierForVendor'];
    }

    // Android 因为没有获取权限，正常来说 serialNumber 是 unknown
    if (Platform.isAndroid && deviceInfo['serialNumber'] != 'unknown') {
      uuid = deviceInfo['serialNumber'];
    }

    // 如果uuid是空的，生成一个随机字符串，并保存到本地
    if (uuid == '') {
      uuid = prefs.getString('UUID') ?? randomString(12);
    }

    // 存储到本地
    await prefs.setString('UUID', uuid);
  }
  
  /* 
   * 主题管理 （深色/浅色）
   */
  ThemeMode themeMode = ThemeMode.system;
  
  // 设置主题模式
  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('THEME_MODE', mode.toString());
  }
  
  // 初始化主题模式
  Future<void> initThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('THEME_MODE');
    if (themeModeString != null) {
      if (themeModeString == ThemeMode.light.toString()) {
        themeMode = ThemeMode.light;
      } else if (themeModeString == ThemeMode.dark.toString()) {
        themeMode = ThemeMode.dark;
      } else {
        themeMode = ThemeMode.system;
      }
    }
  }


  /*
   * 语言
   */
  Locale locale = Locale.fromSubtags(languageCode: 'zh');
  String lang = 'zh';

  // 更改语言
  Future<void> changeLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    var res = getLanguageCode(code);

    // 设置语言
    lang = res['code'];
    locale = Locale.fromSubtags(
        languageCode: res['languageCode'], scriptCode: res['scriptCode']);
    notifyListeners();

    // 保存语言
    await prefs.setString('LANG', res['code']);
    log.config("设置语言: lang $locale");
  }

  // 初始化语言
  Future<void> initLocale() async {
    final prefs = await SharedPreferences.getInstance();
    var prefsLang = prefs.getString('LANG');

    // 如果没有设置过语言，则使用系统语言
    if (prefsLang == null) {
      var languageCode = locale.languageCode;
      var scriptCode = locale.scriptCode;
      var countryCode = locale.countryCode;
      prefsLang = languageCode;
      if (languageCode == 'zh' &&
          (scriptCode == 'Hant' ||
              countryCode == 'HK' ||
              countryCode == 'TW')) {
        prefsLang = 'zh_TW';
      }
    }
    changeLocale(prefsLang);
  }

  /* 
   * 环境
   */
  String env = 'prod'; // 当前环境
  bool isRelease = true; // 是否为release模式

  // 初始化环境
  Future<void> initEnv() async {
    env = dotenv.env['ENV_NAME'] ?? '';
    isRelease = kReleaseMode;
  }

  // 切换环境
  Future<void> changeEnv(String newEnv) async {
    if (newEnv == 'prod') {
      await dotenv.load(fileName: ".env");
    } else {
      await dotenv.load(fileName: ".env.$newEnv");
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ENV', newEnv);

    env = newEnv;
    notifyListeners();
  }

  /* 
   * 账户信息
   */
  IStaff? staffInfo;

  // 记录账户信息
  Future<void> setStaffInfo(IStaff info) async {
    staffInfo = info;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('STAFF_INFO', jsonEncode(info.toJson()));
  }

  // 读取账户信息
  Future<void> getStaffInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final staffInfoString = prefs.getString('STAFF_INFO');
    if (staffInfoString != null) {
      staffInfo = IStaff.fromJson(jsonDecode(staffInfoString));
    }
  }

  /*
   * 清空所有信息
   * （退出登录的时候调用）
   */
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('TOKEN');
    prefs.remove('REFRESH_TOKEN');
    prefs.remove('STAFF_INFO');
    prefs.remove('TOKEN_REFRESH_TIME');

    staffInfo = null;
    notifyListeners();
  }

  /* 
   * 全局初始化
   */
  Future<void> init() async {
    await Future.wait([
      initUUID(),
      initThemeMode(),
      initLocale(),
      initEnv(),
      getStaffInfo(),
    ]);

    // 监听退出登录事件
    eventBus.on<LogoutEvent>().listen((event) {
      clear();
    });
  }
}

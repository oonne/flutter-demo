import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_demo/utils/utils.dart';

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
   * 主题管理 （深色/浅色切换
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
   * 全局初始化
   */
  Future<void> init() async {
    await initThemeMode();
    await initDeviceInfo();
    await initUUID();
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_demo/global/state.dart';
import 'scan_model.dart';

// 是否已向系统申请过相机权限（用于区分「从未申请」与「申请被拒」）
const String _cameraPermissionRequestedKey = 'CAMERA_PERMISSION_REQUESTED';

class ScanViewModel extends ChangeNotifier {
  final ScanModel model = ScanModel();
  final player = AudioPlayer();

  /* 
   * 初始化：只查询权限状态，不主动申请（符合应用市场隐私规范）
   */
  Future<void> init(Map<String, dynamic>? extra) async {
    // 清空扫码结果
    model.result = '';
    // 扫码后是否返回，默认不返回，跳转到结果页
    model.returnAfterScan = extra?['returnAfterScan'] == true;

    await _refreshPermissionState();
  }

  /* 
   * 查询当前相机权限状态并同步到 model
   */
  Future<void> _refreshPermissionState() async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      model.cameraState = CameraPermissionState.granted;
    } else if (status.isPermanentlyDenied) {
      model.cameraState = CameraPermissionState.permanentlyDenied;
    } else {
      // 系统不区分「从未申请」和「申请被拒」，用本地标记区分
      final prefs = await SharedPreferences.getInstance();
      final requested = prefs.getBool(_cameraPermissionRequestedKey) ?? false;
      model.cameraState = requested
          ? CameraPermissionState.denied
          : CameraPermissionState.notDetermined;
    }

    notifyListeners();
  }

  /* 
   * 用户主动点击后申请相机权限，返回申请后的状态
   */
  Future<CameraPermissionState> requestCameraPermission() async {
    // 记录已向系统发起过申请（无论结果如何）
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_cameraPermissionRequestedKey, true);

    final status = await Permission.camera.request();

    if (status.isGranted) {
      log.info('相机权限已授予');
      model.cameraState = CameraPermissionState.granted;
    } else if (status.isPermanentlyDenied) {
      log.warning('相机权限被永久拒绝');
      model.cameraState = CameraPermissionState.permanentlyDenied;
    } else {
      log.warning('相机权限被拒绝');
      model.cameraState = CameraPermissionState.denied;
    }

    notifyListeners();
    return model.cameraState;
  }

  /* 
   * App 从系统设置返回时复查权限，已授予则由 MobileScanner 挂载时自动启动
   */
  Future<void> recheckPermission() async {
    if (model.cameraState == CameraPermissionState.granted) {
      return;
    }

    final status = await Permission.camera.status;
    if (status.isGranted) {
      model.cameraState = CameraPermissionState.granted;
      notifyListeners();
    }
  }

  /* 
   * 离开页面
   */
  Future<void> cleanup() async {
    // 释放扫描器资源
    await controller.dispose();
    // 释放音频播放器资源
    await player.dispose();
  }

  /* 
   * 扫码控制器
   */
  late MobileScannerController controller = initController();

  // 初始化扫码控制器
  // 仅在权限已授予后才挂载 MobileScanner，挂载时自动启动，未授权不会开启相机
  MobileScannerController initController() => MobileScannerController();

  /* 
   * 扫码回调
   */
  Future<void> onDetect(BuildContext context, BarcodeCapture barcode) async {
    // 防止重复触发
    if (model.result.isNotEmpty) {
      return;
    }

    String result = barcode.barcodes.first.rawValue ?? '';
    if (result.isEmpty) {
      return;
    }

    model.result = result;
    log.info('扫码结果: $result');

    // 根据全局配置决定是否播放声音
    final globalState = Provider.of<GlobalState>(context, listen: false);
    if (globalState.isSoundEnabled) {
      await player.setSource(AssetSource('audio/di.mp3'));
      await player.resume();
    }
    if (!context.mounted) {
      return;
    }

      // 扫码后返回
    if (model.returnAfterScan) {
      GoRouter.of(context).pop(result);
      return;
    }

    // 扫码后跳到结果页面
    GoRouter.of(context).pushReplacementNamed('scan/result', extra: {'result': result});
  }
}

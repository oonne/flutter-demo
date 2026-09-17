import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_demo/theme/global.dart';
import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/utils/message.dart';
import 'package:flutter_demo/widget/modal/modal_dialog.dart';

import 'scan_model.dart';
import 'scan_view_model.dart';
import 'widget/scanner_error_widget.dart';
import 'widget/custom_scan_window_overlay.dart';

/*
 * 扫码页面
 */
class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> with WidgetsBindingObserver {
  late final ScanViewModel viewModel;

  /*
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    viewModel = ScanViewModel();

    // 在下一帧初始化 viewModel（仅查询权限状态，不主动申请系统权限）
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final queryParameters =
          GoRouterState.of(context).extra as Map<String, dynamic>?;
      await viewModel.init(queryParameters);
      if (!mounted) {
        return;
      }

      // 从未申请过：进入页面直接弹出权限用途说明框；
      // 用户在说明框点「允许」后才会唤起系统弹窗，点「取消」不触发申请。
      // 已拒绝/永久拒绝状态不自动弹，由用户点击占位页按钮主动触发。
      if (viewModel.model.cameraState ==
          CameraPermissionState.notDetermined) {
        await startScan();
      }
    });
  }

  /*
   * App 生命周期变化：从系统设置返回时复查权限
   */
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      viewModel.recheckPermission();
    }
  }

  /*
   * 离开页面
   */
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(viewModel.cleanup());
    super.dispose();
  }

  /*
   * 用户点击「开启相机扫码」：先说明权限用途，用户同意后才唤起系统弹窗
   */
  Future<void> startScan() async {
    // 永久拒绝：弹窗说明后引导去系统设置
    if (viewModel.model.cameraState ==
        CameraPermissionState.permanentlyDenied) {
      await _showPermanentlyDeniedDialog();
      return;
    }

    if (!mounted) {
      return;
    }

    // 申请前同步告知权限用途
    final confirmed = await showModal<bool>(
      context: context,
      child: Text(
        AppLocalizations.of(context)!.msg_scan_camera_permission_request, // 扫码功能需要使用相机权限，用于扫描二维码和条形码，是否允许开启？
      ),
    );
    if (confirmed != true || !mounted) {
      return;
    }

    // 用户主动同意后才申请系统权限
    final state = await viewModel.requestCameraPermission();
    if (!mounted) {
      return;
    }

    if (state == CameraPermissionState.denied) {
      // 普通拒绝：仅提示
      showTextSnackBar(
        context,
        msg: AppLocalizations.of(context)!.msg_scan_permission_denied, // 申请扫码权限被拒绝
      );
    } else if (state == CameraPermissionState.permanentlyDenied) {
      await _showPermanentlyDeniedDialog();
    }
  }

  /*
   * 永久拒绝说明弹窗，用户确认后跳转系统设置
   */
  Future<void> _showPermanentlyDeniedDialog() async {
    if (!mounted) {
      return;
    }

    final confirmed = await showModal<bool>(
      context: context,
      showCancelButton: true,
      child: Text(
        // 需要使用相机权限以扫描二维码和条形码。由于权限已被拒绝,请在系统设置中开启相机权限后重试。
        AppLocalizations.of(context)!.msg_camera_permission_permanently_denied,
      ),
    );
    if (confirmed == true) {
      await openAppSettings();
    }
  }

  /*
   * 选择照片
   */
  Future<void> pickImage(BuildContext context) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) {
      return;
    }

    final barcodes = await viewModel.controller.analyzeImage(image.path);
    if (barcodes == null && context.mounted) {
      showTextSnackBar(
        context,
        msg: AppLocalizations.of(context)!.msg_no_barcode_detected,
      );
      return;
    }

    if (context.mounted && barcodes != null) {
      viewModel.onDetect(context, barcodes);
    }
  }

  /*
   * 未授权占位视图：不初始化相机，由用户主动点击开启
   */
  Widget _buildPermissionPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.camera_alt_outlined,
              size: 56,
              color: Colors.white54,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.info_scan_camera_hint, // 开启相机后即可扫描二维码和条形码
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: startScan,
              child: Text(AppLocalizations.of(context)!.btn_enable_camera_scan), // 开启相机扫码
            ),
          ],
        ),
      ),
    );
  }

  /*
   * 底部圆形操作按钮
   */
  Widget _buildCircleButton({
    required String icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          icon,
          width: 32,
          height: 32,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  /*
   * 页面构建
   */
  @override
  Widget build(BuildContext context) {
    final themeVars = getCurrentThemeVars(context);

    // 定义扫描窗口区域
    late final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(const Offset(0, -150)),
      width: 300,
      height: 300,
    );

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<ScanViewModel>(
        builder: (context, viewModel, child) {
          // 仅在已授权时挂载相机组件
          final granted =
              viewModel.model.cameraState == CameraPermissionState.granted;

          /*
           * 页面
           */
          return Scaffold(
            appBar: CustomAppBar(
              title: Text(AppLocalizations.of(context)!.title_scan),
            ),
            body: Stack(
              children: [
                /*
                 * 相机区域：已授权显示扫描器，未授权显示占位视图
                 */
                if (granted) ...[
                  MobileScanner(
                    scanWindow: scanWindow,
                    controller: viewModel.controller,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error) {
                      return ScannerErrorWidget(error: error);
                    },
                    onDetect: (barcode) {
                      viewModel.onDetect(context, barcode);
                    },
                  ),
                  CustomScanWindowOverlay(
                    scanWindow: scanWindow,
                    borderRadius: BorderRadius.circular(themeVars.radius),
                    controller: viewModel.controller,
                  ),
                ] else
                  _buildPermissionPlaceholder(),

                /*
                 * 底部按钮组（相册选图不依赖相机权限，始终可用）
                 */
                Positioned(
                  left: MediaQuery.sizeOf(context).width / 2 - 150,
                  right: MediaQuery.sizeOf(context).width / 2 - 150,
                  bottom: MediaQuery.sizeOf(context).height / 2 - 200,
                  child: Row(
                    mainAxisAlignment: granted
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: [
                      if (granted) ...[
                        /*
                         * 切换相机
                         */
                        _buildCircleButton(
                          icon: 'assets/icon/switch-camera.svg',
                          onTap: () {
                            viewModel.controller.switchCamera();
                          },
                        ),

                        /*
                         * 手电筒
                         */
                        _buildCircleButton(
                          icon: 'assets/icon/flashlight.svg',
                          onTap: () {
                            viewModel.controller.toggleTorch();
                          },
                        ),
                      ],

                      /*
                       * 选择照片
                       */
                      _buildCircleButton(
                        icon: 'assets/icon/picture-fill.svg',
                        onTap: () {
                          pickImage(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

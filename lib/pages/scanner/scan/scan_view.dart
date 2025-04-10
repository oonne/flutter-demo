import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_demo/theme/global.dart';
import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/utils/message.dart';

import 'scan_view_model.dart';
import 'widget/scanner_error_widget.dart';
import 'widget/scan_window_overlay.dart';

/* 
 * 扫码页面
 */
class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  late final ScanViewModel viewModel;

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = ScanViewModel();

    // 在下一帧初始化 viewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final queryParameters =
          GoRouterState.of(context).extra as Map<String, dynamic>?;
      viewModel.init(queryParameters);
    });
  }

  /* 
   * 离开页面
   */
  @override
  Future<void> dispose() async {
    super.dispose();
    await viewModel.cleanup();
  }

  /* 
   * 选择照片
   */
  Future<void> pickImage(context) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) {
      return;
    }

    final barcodes = await viewModel.controller.analyzeImage(image.path);
    if (barcodes == null) {
      showTextSnackBar(
        context,
        msg: AppLocalizations.of(context)!.msg_no_barcode_detected,
      );
      return;
    }

    viewModel.onDetect(context, barcodes);
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
                 * 扫描器
                 */
                MobileScanner(
                  scanWindow: scanWindow,
                  controller: viewModel.controller,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, child) {
                    return ScannerErrorWidget(error: error);
                  },
                  onDetect: (barcode) {
                    viewModel.onDetect(context, barcode);
                  },
                ),

                /* 
                 * 扫描窗口覆盖层
                 */
                ScanWindowOverlay(
                  scanWindow: scanWindow,
                  borderRadius: BorderRadius.circular(themeVars.radius),
                  controller: viewModel.controller,
                ),

                /* 
                 * 底部按钮组
                 */
                Positioned(
                  left: MediaQuery.sizeOf(context).width / 2 - 150,
                  right: MediaQuery.sizeOf(context).width / 2 - 150,
                  bottom: MediaQuery.sizeOf(context).height / 2 - 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /* 
                       * 切换相机
                       */
                      InkWell(
                        onTap: () {
                          viewModel.controller.switchCamera();
                        },
                        child: Container(
                          width: 64,
                          height: 64,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/icon/switch-camera.svg',
                            width: 32,
                            height: 32,
                            colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),

                      /* 
                       * 手电筒
                       */
                      InkWell(
                        onTap: () {
                          viewModel.controller.toggleTorch();
                        },
                        child: Container(
                          width: 64,
                          height: 64,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/icon/flashlight.svg',
                            width: 32,
                            height: 32,
                            colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),

                      /* 
                       * 选择照片
                       */
                      InkWell(
                        onTap: () {
                          pickImage(context);
                        },
                        child: Container(
                          width: 64,
                          height: 64,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/icon/picture-fill.svg',
                            width: 32,
                            height: 32,
                            colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
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

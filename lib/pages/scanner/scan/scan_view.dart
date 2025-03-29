import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:flutter_demo/theme/global.dart';
import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/layout/custom_app_bar.dart';

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
  final player = AudioPlayer();

  /* 
   * 初始化
   */
  @override
  void initState() {
    super.initState();
    viewModel = ScanViewModel();

    // 在下一帧初始化 viewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init();
    });
  }

  /* 
   * 离开页面
   */
  @override
  Future<void> dispose() async {
    await viewModel.cleanup();
    super.dispose();
  }

  /* 
   * 播放声音
   */
  Future<void> playSound() async {
    await player.setSource(AssetSource('audio/di.mp3'));
    await player.resume();
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
                  // 扫描器
                  MobileScanner(
                    scanWindow: scanWindow,
                    controller: viewModel.controller,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, child) {
                      return ScannerErrorWidget(error: error);
                    },
                  ),
                  // 扫描窗口覆盖层
                  ScanWindowOverlay(
                    scanWindow: scanWindow,
                    borderRadius: BorderRadius.circular(themeVars.radius),
                    controller: viewModel.controller,
                  ),
                ],
              ),
          );
        },
      ),
    );
  }
}

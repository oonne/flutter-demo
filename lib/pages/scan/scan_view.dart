import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter_demo/generated/i18n/app_localizations.dart';
import 'package:flutter_demo/layout/custom_app_bar.dart';

import 'scan_view_model.dart';

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
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(children: [
                  ElevatedButton(
                    onPressed: () {
                      playSound();
                    },
                    child: Text('播放声音'),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

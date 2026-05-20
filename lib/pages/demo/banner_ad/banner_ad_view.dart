import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';
import 'package:flutter_demo/ad/widgets/banner_ad_widget.dart';
import 'package:flutter_demo/config/config.dart';
import 'package:flutter_demo/utils/log.dart';

import 'banner_ad_view_model.dart';

class BannerAdView extends StatefulWidget {
  const BannerAdView({super.key});

  @override
  State<BannerAdView> createState() => _BannerAdViewState();
}

class _BannerAdViewState extends State<BannerAdView> {
  late final BannerAdViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = BannerAdViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<BannerAdViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(title: const Text('Banner广告')),
            body: Column(
              children: [
                const Expanded(
                  child: Center(
                    child: Text('页面内容'),
                  ),
                ),
                Container(
                  height: adBannerHeight,
                  color: Colors.grey[200],
                  child: Center(
                    child: BannerAdWidget(
                      width: adBannerWidth,
                      height: adBannerHeight,
                      onShow: () {
                        log.info('Banner广告展示成功');
                      },
                      onFail: (error) {
                        log.info('Banner广告加载失败: $error');
                      },
                    ),
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
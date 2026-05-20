import 'package:flutter/material.dart';
import 'package:flutter_demo/ad/widgets/splash_ad_widget.dart';
import 'package:flutter_demo/ad/widgets/banner_ad_widget.dart';

class AdExamplePage extends StatelessWidget {
  const AdExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('广告示例'),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text('页面内容'),
            ),
          ),
          Container(
            height: 120,
            color: Colors.grey[200],
            child: Center(
              child: BannerAdWidget(
                width: 600.5,
                height: 120.5,
                onShow: () {
                  print('Banner广告展示成功');
                },
                onFail: (error) {
                  print('Banner广告加载失败: $error');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashAdExamplePage extends StatelessWidget {
  const SplashAdExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashAdWidget(
        timeout: 5000,
        onShow: () {
          print('开屏广告展示');
        },
        onFinish: () {
          print('开屏广告结束，跳转到主页');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AdExamplePage(),
            ),
          );
        },
        onSkip: () {
          print('开屏广告跳过');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AdExamplePage(),
            ),
          );
        },
        onFail: (error) {
          print('开屏广告加载失败: $error');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AdExamplePage(),
            ),
          );
        },
      ),
    );
  }
}

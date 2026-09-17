import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';

import 'webview_model.dart';
import 'webview_view_model.dart';

class WebViewDemoView extends StatefulWidget {
  const WebViewDemoView({super.key});

  @override
  State<WebViewDemoView> createState() => _WebViewDemoViewState();
}

class _WebViewDemoViewState extends State<WebViewDemoView> {
  late final WebViewViewModel viewModel;
  WebViewController? controller;

  @override
  void initState() {
    super.initState();
    viewModel = WebViewViewModel(model: WebViewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final queryParameters =
          GoRouterState.of(context).extra as Map<String, dynamic>?;
      final url = queryParameters?['url'] as String?;
      if (url != null) {
        viewModel.model.url = url;
        controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(url));
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<WebViewViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(title: const Text('WebView')),
            body: viewModel.hasUrl
                ? WebViewWidget(controller: controller!)
                : const Center(
                    child: Text('请传入URL参数'),
                  ),
          );
        },
      ),
    );
  }
}

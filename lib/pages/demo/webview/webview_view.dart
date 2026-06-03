import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';

import 'webview_model.dart';
import 'webview_view_model.dart';

class WebViewDemoView extends StatefulWidget {
  final String? url;

  const WebViewDemoView({super.key, this.url});

  @override
  State<WebViewDemoView> createState() => _WebViewDemoViewState();
}

class _WebViewDemoViewState extends State<WebViewDemoView> {
  late final WebViewViewModel viewModel;
  WebViewController? controller;

  @override
  void initState() {
    super.initState();
    viewModel = WebViewViewModel(model: WebViewModel(url: widget.url));
    if (viewModel.hasUrl) {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.url!));
    }
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

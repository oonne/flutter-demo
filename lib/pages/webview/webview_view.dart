import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_demo/layout/custom_app_bar.dart';

import 'webview_model.dart';
import 'webview_view_model.dart';

class WebViewView extends StatefulWidget {
  const WebViewView({super.key});

  @override
  State<WebViewView> createState() => _WebViewViewState();
}

class _WebViewViewState extends State<WebViewView> {
  late final WebViewViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = WebViewViewModel(model: WebViewModel());

    // 在下一帧初始化 viewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final queryParameters =
          GoRouterState.of(context).extra as Map<String, dynamic>?;
      viewModel.init(queryParameters);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<WebViewViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: CustomAppBar(title: Text(viewModel.title ?? 'WebView')),
            body: viewModel.hasUrl
                ? WebViewWidget(controller: viewModel.controller!)
                : const Center(
                    child: Text('请传入URL参数'),
                  ),
          );
        },
      ),
    );
  }
}

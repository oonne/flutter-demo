import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'webview_model.dart';

class WebViewViewModel extends ChangeNotifier {
  final WebViewModel model;
  WebViewController? controller;

  WebViewViewModel({required this.model});

  String? get url => model.url;
  bool get hasUrl => model.hasUrl;
  String? get title => model.title;

  /* 
   * 初始化
   */
  void init(Map<String, dynamic>? extra) {
    final url = extra?['url'] as String?;
    final title = extra?['title'] as String?;
    if (url != null) {
      model.url = url;
      model.title = title;
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(url));
    }
    notifyListeners();
  }
}

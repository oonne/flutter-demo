import 'package:flutter/foundation.dart';

import 'webview_model.dart';

class WebViewViewModel extends ChangeNotifier {
  final WebViewModel model;
  WebViewViewModel({required this.model});

  String? get url => model.url;
  bool get hasUrl => model.hasUrl;
}

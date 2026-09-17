class WebViewModel {
  String? url;
  String? title;
  WebViewModel({this.url, this.title});

  bool get hasUrl => url != null && url!.isNotEmpty;
}

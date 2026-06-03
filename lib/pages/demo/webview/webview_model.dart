class WebViewModel {
  String? url;
  WebViewModel({this.url});

  bool get hasUrl => url != null && url!.isNotEmpty;
}

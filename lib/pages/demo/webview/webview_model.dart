class WebViewModel {
  final String? url;
  WebViewModel({this.url});

  bool get hasUrl => url != null && url!.isNotEmpty;
}

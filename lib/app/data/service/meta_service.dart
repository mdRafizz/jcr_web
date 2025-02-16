import 'dart:js' as js;

class MetaService {
  static void updateMetaTags({
    required String title,
    required String description,
    required String keywords,
    required String url,
  }) {
    js.context.callMethod('updateMetaTags', [
      title,
      description,
      keywords,
      url
    ]);
  }
}

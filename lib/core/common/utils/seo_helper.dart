import 'package:universal_html/html.dart' as html;

abstract final class SEOHelper {
  static void addInfo({
    String? title,
    String? imageLink,
    String? imageAlt,
    String? locale,
    bool addLink = false,
  }) {
    final html.Document document = html.document;

    final head = document.querySelector('head');
    if (head != null) {
      if (title != null) {
        final elements = head.children;

        final index =
            elements.indexWhere((element) => element is html.TitleElement);

        if (index == -1) {
          head.append(html.TitleElement()..text = title);
        } else {
          head.children[index] = html.TitleElement()..text = title;
        }
      }
      if (locale != null) {
        document.documentElement?.setAttribute('lang', locale);
      }

      if (addLink) {
        head.append(
          html.LinkElement()
            ..rel = 'canonical'
            ..href = 'http://127.0.0.1',
        );
      }

      if (imageLink != null) {
        head.append(
          html.ImageElement()
            ..src = imageLink
            ..alt = imageAlt,
        );
      }
    }
  }
}

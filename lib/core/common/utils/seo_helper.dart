import 'package:universal_html/html.dart' as html;
import 'package:universal_html/html.dart';

abstract final class SEOHelper {
  static void addH1({
    String? h1Title,
    String? h1Id,
  }) {
    final html.Document document = html.document;

    if (h1Title != null && h1Id != null) {
      document.getElementById(h1Id)?.innerHtml = h1Title;
    }
  }

  static void addTitle({
    String? title,
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
    }
  }

  static void setLocale({
    String? locale,
  }) {
    final html.Document document = html.document;

    if (locale != null) {
      document.documentElement?.setAttribute('lang', locale);
    }
  }

  static void setCanonicalLink({String? href}) {
    final html.Document document = html.document;

    final head = document.querySelector('head');
    if (head != null) {
      if (href != null) {
        head.append(
          html.LinkElement()
            ..rel = 'canonical'
            ..href = href,
          //'http://127.0.0.1'
        );
      }
    }
  }

  static void addImage({
    String? imageLink,
    String? imageAlt,
  }) {
    final html.Document document = html.document;

    final head = document.querySelector('head');
    if (head != null) {
      if (imageLink != null) {
        head.append(
          html.ImageElement()
            ..src = imageLink
            ..alt = imageAlt,
        );
      }
    }
  }

  static void disposeInfo({
    String? imageLink,
    String? imageAlt,
    String? h1Id,
  }) {
    final html.Document document = html.document;

    final head = document.querySelector('head');
    if (head != null) {
      if (imageLink != null && imageAlt != null) {
        head.children
            .firstWhere(
              (element) =>
                  (element as ImageElement).alt == imageAlt &&
                  element.src == imageLink,
            )
            .remove();
      }
    }

    if (h1Id != null) {
      final html.Document document = html.document;

      document.getElementById(h1Id)?.remove();
    }
  }
}

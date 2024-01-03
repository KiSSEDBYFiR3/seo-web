import 'package:auto_route/auto_route.dart';
import 'package:seo_web/core/common/utils/seo_helper.dart';
import 'package:seo_web/generated/l10n.dart';

class SeoNavigationObserver extends AutoRouteObserver {
  final AppLocalizationDelegate delegate;

  SeoNavigationObserver({required this.delegate});

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    final locale = S();
    switch (route.path) {
      case 'catalog-tab':
        SEOHelper.addInfo(title: locale.catalog);
        break;
      case 'cart-tab':
        SEOHelper.addInfo(title: locale.cart);
        break;
      case 'favorites-tab':
        SEOHelper.addInfo(title: locale.favorites);
        break;
    }
    super.didChangeTabRoute(route, previousRoute);
  }
}

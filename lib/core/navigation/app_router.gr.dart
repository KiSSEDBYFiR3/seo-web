// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    MainRouter.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeRouterTabScreen(),
      );
    },
    CatalogTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CatalogTabScreen(),
      );
    },
    CartTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CartTabScreen(),
      );
    },
    FavoritesTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoritesTabScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    FavoritesRoute.name: (routeData) {
      final args = routeData.argsAs<FavoritesRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FavoritesScreen(
          args.wmFactory,
          key: args.key,
        ),
      );
    },
    CatalogRoute.name: (routeData) {
      final args = routeData.argsAs<CatalogRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CatalogScreen(
          args.wmFactory,
          key: args.key,
        ),
      );
    },
    CartRoute.name: (routeData) {
      final args = routeData.argsAs<CartRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CartScreen(
          args.wmFactory,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [HomeRouterTabScreen]
class MainRouter extends PageRouteInfo<void> {
  const MainRouter({List<PageRouteInfo>? children})
      : super(
          MainRouter.name,
          initialChildren: children,
        );

  static const String name = 'MainRouter';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CatalogTabScreen]
class CatalogTab extends PageRouteInfo<void> {
  const CatalogTab({List<PageRouteInfo>? children})
      : super(
          CatalogTab.name,
          initialChildren: children,
        );

  static const String name = 'CatalogTab';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CartTabScreen]
class CartTab extends PageRouteInfo<void> {
  const CartTab({List<PageRouteInfo>? children})
      : super(
          CartTab.name,
          initialChildren: children,
        );

  static const String name = 'CartTab';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoritesTabScreen]
class FavoritesTab extends PageRouteInfo<void> {
  const FavoritesTab({List<PageRouteInfo>? children})
      : super(
          FavoritesTab.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesTab';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoritesScreen]
class FavoritesRoute extends PageRouteInfo<FavoritesRouteArgs> {
  FavoritesRoute({
    required WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel>
            Function(BuildContext)
        wmFactory,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          FavoritesRoute.name,
          args: FavoritesRouteArgs(
            wmFactory: wmFactory,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static const PageInfo<FavoritesRouteArgs> page =
      PageInfo<FavoritesRouteArgs>(name);
}

class FavoritesRouteArgs {
  const FavoritesRouteArgs({
    required this.wmFactory,
    this.key,
  });

  final WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel> Function(
      BuildContext) wmFactory;

  final Key? key;

  @override
  String toString() {
    return 'FavoritesRouteArgs{wmFactory: $wmFactory, key: $key}';
  }
}

/// generated route for
/// [CatalogScreen]
class CatalogRoute extends PageRouteInfo<CatalogRouteArgs> {
  CatalogRoute({
    required WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel>
            Function(BuildContext)
        wmFactory,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CatalogRoute.name,
          args: CatalogRouteArgs(
            wmFactory: wmFactory,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CatalogRoute';

  static const PageInfo<CatalogRouteArgs> page =
      PageInfo<CatalogRouteArgs>(name);
}

class CatalogRouteArgs {
  const CatalogRouteArgs({
    required this.wmFactory,
    this.key,
  });

  final WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel> Function(
      BuildContext) wmFactory;

  final Key? key;

  @override
  String toString() {
    return 'CatalogRouteArgs{wmFactory: $wmFactory, key: $key}';
  }
}

/// generated route for
/// [CartScreen]
class CartRoute extends PageRouteInfo<CartRouteArgs> {
  CartRoute({
    required WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel>
            Function(BuildContext)
        wmFactory,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CartRoute.name,
          args: CartRouteArgs(
            wmFactory: wmFactory,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const PageInfo<CartRouteArgs> page = PageInfo<CartRouteArgs>(name);
}

class CartRouteArgs {
  const CartRouteArgs({
    required this.wmFactory,
    this.key,
  });

  final WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel> Function(
      BuildContext) wmFactory;

  final Key? key;

  @override
  String toString() {
    return 'CartRouteArgs{wmFactory: $wmFactory, key: $key}';
  }
}

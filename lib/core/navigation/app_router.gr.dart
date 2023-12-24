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
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoritesScreen(),
      );
    },
    CatalogRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CatalogScreen(),
      );
    },
    CartRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CartScreen(),
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
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CatalogScreen]
class CatalogRoute extends PageRouteInfo<void> {
  const CatalogRoute({List<PageRouteInfo>? children})
      : super(
          CatalogRoute.name,
          initialChildren: children,
        );

  static const String name = 'CatalogRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CartScreen]
class CartRoute extends PageRouteInfo<void> {
  const CartRoute({List<PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

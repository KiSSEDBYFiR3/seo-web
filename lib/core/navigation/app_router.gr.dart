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
    ProductsRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<ProductsRouteArgs>(
          orElse: () =>
              ProductsRouteArgs(category: queryParams.optString('category')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductsScreen(
          category: args.category,
        ),
      );
    },
    CategoriesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CategoriesScreen(),
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
/// [ProductsScreen]
class ProductsRoute extends PageRouteInfo<ProductsRouteArgs> {
  ProductsRoute({
    String? category,
    List<PageRouteInfo>? children,
  }) : super(
          ProductsRoute.name,
          args: ProductsRouteArgs(
            category: category,
          ),
          rawQueryParams: {'category': category},
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static const PageInfo<ProductsRouteArgs> page =
      PageInfo<ProductsRouteArgs>(name);
}

class ProductsRouteArgs {
  const ProductsRouteArgs({
    this.category,
  });

  final String? category;

  @override
  String toString() {
    return 'ProductsRouteArgs{category: $category}';
  }
}

/// generated route for
/// [CategoriesScreen]
class CategoriesRoute extends PageRouteInfo<void> {
  const CategoriesRoute({List<PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

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

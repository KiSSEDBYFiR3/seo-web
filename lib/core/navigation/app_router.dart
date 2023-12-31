import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seo_web/feature/presentation/screens/cart/cart_screen.dart';
import 'package:seo_web/feature/presentation/screens/catalog/categories/categories_screen.dart';
import 'package:seo_web/feature/presentation/screens/catalog/product_card/product_card_screen.dart';
import 'package:seo_web/feature/presentation/screens/catalog/products/products_screen.dart';
import 'package:seo_web/feature/presentation/screens/favorites/favorites_screen.dart';
import 'package:seo_web/feature/presentation/screens/home/home_screen.dart';
part 'app_router.gr.dart';

@RoutePage(name: "MainRouter")
class HomeRouterTabScreen extends AutoRouter {
  const HomeRouterTabScreen({super.key});
}

@RoutePage(name: "CatalogTab")
class CatalogTabScreen extends AutoRouter {
  const CatalogTabScreen({super.key});
}

@RoutePage(name: "CartTab")
class CartTabScreen extends AutoRouter {
  const CartTabScreen({super.key});
}

@RoutePage(name: "FavoritesTab")
class FavoritesTabScreen extends AutoRouter {
  const FavoritesTabScreen({super.key});
}

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainRouter.page,
          path: '/',
          children: [
            AutoRoute(
              path: '',
              page: HomeRoute.page,
              children: [
                AutoRoute(
                  path: 'catalog-tab',
                  page: CatalogTab.page,
                  children: [
                    AutoRoute(
                      page: CategoriesRoute.page,
                      initial: true,
                    ),
                    AutoRoute(
                      page: ProductsRoute.page,
                      path: 'products',
                    ),
                    AutoRoute(
                      page: ProductCardRoute.page,
                      path: 'product',
                    ),
                  ],
                ),
                AutoRoute(
                  path: 'cart-tab',
                  page: CartTab.page,
                  children: [
                    AutoRoute(
                      page: CartRoute.page,
                      initial: true,
                    ),
                    AutoRoute(
                      page: ProductCardRoute.page,
                      path: 'product',
                    ),
                  ],
                ),
                AutoRoute(
                  path: 'favorites-tab',
                  page: FavoritesTab.page,
                  children: [
                    AutoRoute(
                      page: FavoritesRoute.page,
                      initial: true,
                    ),
                    AutoRoute(
                      page: ProductCardRoute.page,
                      path: 'product',
                    ),
                  ],
                )
              ],
            ),
          ],
        )
      ];
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seo_web/feature/presentation/screens/cart/cart_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/categories/categories_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/products/products_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/favorites/favorites_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/home/home_screen_model.dart';

class DependenciesProvider extends StatelessWidget {
  final ICartModel cartModel;
  final IProductsModel catalogModel;
  final IFavoritesModel favoritesModel;
  final ICategoriesModel categoriesModel;
  final IHomeModel homeModel;
  final Widget child;

  const DependenciesProvider({
    super.key,
    required this.cartModel,
    required this.catalogModel,
    required this.favoritesModel,
    required this.categoriesModel,
    required this.homeModel,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => cartModel,
        ),
        Provider(
          create: (context) => catalogModel,
        ),
        Provider(
          create: (context) => favoritesModel,
        ),
        Provider(
          create: (context) => categoriesModel,
        ),
        Provider(
          create: (context) => homeModel,
        ),
        ChangeNotifierProvider<ValueNotifier<ThemeMode>>(
          create: (context) => ValueNotifier(ThemeMode.system),
          child: child,
        ),
      ],
      child: child,
    );
  }
}

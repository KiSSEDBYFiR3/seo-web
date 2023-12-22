import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seo_web/feature/presentation/screens/cart/cart_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/catalog_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/favorites/favorites_screen_model.dart';

class DependenciesProvider extends StatelessWidget {
  final ICartModel cartModel;
  final ICatalogModel catalogModel;
  final IFavoritesModel favoritesModel;
  final Widget child;

  const DependenciesProvider({
    super.key,
    required this.cartModel,
    required this.catalogModel,
    required this.favoritesModel,
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
        ChangeNotifierProvider<ValueNotifier<ThemeMode>>(
          create: (context) => ValueNotifier(ThemeMode.system),
          child: child,
        ),
      ],
      child: child,
    );
  }
}

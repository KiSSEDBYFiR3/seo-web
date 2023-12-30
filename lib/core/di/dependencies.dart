import 'package:seo_web/feature/presentation/screens/cart/cart_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/categories/categories_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/product_card/product_card_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/catalog/products/products_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/favorites/favorites_screen_model.dart';
import 'package:seo_web/feature/presentation/screens/home/home_screen_model.dart';

class Dependencies {
  final ICartModel cartModel;
  final IProductsModel catalogModel;
  final IFavoritesModel favoritesModel;
  final ICategoriesModel categoriesModel;
  final IHomeModel homeModel;
  final IProductModel productModel;

  Dependencies({
    required this.cartModel,
    required this.catalogModel,
    required this.favoritesModel,
    required this.categoriesModel,
    required this.homeModel,
    required this.productModel,
  });
}

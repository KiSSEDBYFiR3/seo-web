import 'package:seo_web/core/exception/app_exceptions.dart';

abstract final class Exceptions {
  static const addToFavoritesException =
      FavoritesException('Возникла ошибка при добавлении товара в избранное');

  static const addToCartException =
      CartException('Возникла ошибка при добавлении товара в корзину');

  static const deleteFromFavoritesException =
      FavoritesException('Возникла ошибка при удалении товара из корзины');

  static const deleteFromCartException =
      CartException('Возникла ошибка при удалении товара из избранного');

  static const getFavoritesException =
      FavoritesException('Возникла ошибка при загрузке избранных товаров');

  static const getCatalogException =
      CatalogException('Возникла ошибка при загрузке каталога');

  static const getCartException =
      CartException('Возникла ошибка при загрузке корзины');

  static const orderException =
      OrderException('Возникла ошибка при создании заказа');
}

sealed class AppException implements Exception {
  final String message;

  const AppException(this.message);
}

final class AuthException extends AppException {
  const AuthException(super.message);
}

final class CartException extends AppException {
  const CartException(super.message);
}

final class CatalogException extends AppException {
  const CatalogException(super.message);
}

final class FavoritesException extends AppException {
  const FavoritesException(super.message);
}

final class OrderException extends AppException {
  const OrderException(super.message);
}

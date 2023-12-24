import 'package:equatable/equatable.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

final class LoadFavoritesEvent extends FavoritesEvent {}

final class AddToFavoritesEvent extends FavoritesEvent {
  final ProductEntity product;

  const AddToFavoritesEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

final class UpdateStateEvent extends FavoritesEvent {
  final List<ProductEntity> products;

  const UpdateStateEvent({required this.products});

  @override
  List<Object?> get props => [products];
}

final class RemoveFromFavoritesEvent extends FavoritesEvent {
  final ProductEntity product;

  const RemoveFromFavoritesEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

final class FavoritesErrorEvent extends FavoritesEvent {
  final String message;

  const FavoritesErrorEvent(this.message);

  @override
  List<Object?> get props => [];
}

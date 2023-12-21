import 'package:equatable/equatable.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

final class LoadCartEvent extends CartEvent {}

final class AddToCartEvent extends CartEvent {
  final ProductEntity product;

  const AddToCartEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

final class RemoveFromCartEvent extends CartEvent {
  final ProductEntity product;

  const RemoveFromCartEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

final class CartErrorEvent extends CartEvent {
  final String message;

  const CartErrorEvent(this.message);

  @override
  List<Object?> get props => [];
}

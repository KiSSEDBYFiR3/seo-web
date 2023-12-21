import 'package:equatable/equatable.dart';
import 'package:seo_web/feature/domain/entity/cart_entity.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

final class InitialCartState extends CartState {}

final class LoadingState extends CartState {
  final CartEntity? cart;
  const LoadingState(this.cart);

  @override
  List<Object?> get props => [cart];
}

final class LoadedState extends CartState {
  final CartEntity? cart;
  const LoadedState(this.cart);

  @override
  List<Object?> get props => [cart];
}

final class ErrorState extends CartState {
  final CartEntity? cart;
  final String message;

  const ErrorState({
    required this.message,
    this.cart,
  });

  @override
  List<Object?> get props => [];
}

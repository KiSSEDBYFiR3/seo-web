import 'package:equatable/equatable.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

final class InitialFavoritesState extends FavoritesState {}

final class LoadingState extends FavoritesState {
  final List<ProductEntity> favorites;
  const LoadingState(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

final class LoadedState extends FavoritesState {
  final List<ProductEntity> favorites;
  const LoadedState(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

final class ErrorState extends FavoritesState {
  final List<ProductEntity> favorites;
  final String message;

  const ErrorState({
    required this.message,
    this.favorites = const [],
  });

  @override
  List<Object?> get props => [];
}

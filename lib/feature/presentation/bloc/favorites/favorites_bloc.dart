import 'dart:async';

import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seo_web/core/exception/app_exceptions.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/cart/i_cart_manager.dart';
import 'package:seo_web/feature/domain/managers/favorites/i_favorites_manager.dart';
import 'package:seo_web/feature/domain/providers/cart/cart_provider.dart';
import 'package:seo_web/feature/presentation/bloc/favorites/favorites_events.dart';
import 'package:seo_web/feature/presentation/bloc/favorites/favorites_states.dart';

final class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState>
    with CartProvider {
  final IFavoritesManager _favoritesManager;

  @override
  final ICartManager cartManager;

  List<ProductEntity> get favorites =>
      _favoritesManager.favoritesState.value.data ?? [];

  EntityStateNotifier<List<ProductEntity>> get _favoritesState =>
      _favoritesManager.favoritesState;

  late final StreamSubscription _favoritesChangeSubscription;

  FavoritesBloc({
    required this.cartManager,
    required IFavoritesManager favoritesManager,
  })  : _favoritesManager = favoritesManager,
        super(InitialFavoritesState()) {
    on<LoadFavoritesEvent>(_onLoadEvent);
    on<AddToFavoritesEvent>(_onAddToFavoritesEvent);
    on<RemoveFromFavoritesEvent>(_onRemoveFromFavoritesEvent);
    on<FavoritesErrorEvent>(_onFavoritesErrorEvent);
    on<UpdateStateEvent>(_onUpdateStateEvent);

    init();
  }

  void init() {
    _favoritesChangeSubscription = _favoritesManager.favoritesChangedController
        .listen(_onFavoritesChanged);

    loadFavoritesEvent();
  }

  void _onFavoritesChanged(List<ProductEntity> products) {
    addUpdateStateEvent(products);
  }

  void dispose() {
    _favoritesState.dispose();
    _favoritesManager.dispose();
    _favoritesChangeSubscription.cancel();
    cartState.dispose();
  }

  void _onLoadEvent(
      LoadFavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit(LoadingState(favorites));

    try {
      await _favoritesManager.getFavorites();
      emit(LoadedState(favorites));
    } on FavoritesException catch (e) {
      addErrorEvent(e.message);
    }
  }

  void addUpdateStateEvent(List<ProductEntity> products) {
    add(UpdateStateEvent(products: products));
  }

  void _onUpdateStateEvent(
      UpdateStateEvent event, Emitter<FavoritesState> emit) {
    emit(LoadingState(event.products));

    emit(LoadedState(event.products));
  }

  void _onAddToFavoritesEvent(
      AddToFavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit(LoadingState(favorites));

    try {
      await _favoritesManager.addToFavorites(product: event.product);

      emit(LoadedState(favorites));
    } on FavoritesException catch (e) {
      addErrorEvent(e.message);
    }
  }

  void _onRemoveFromFavoritesEvent(
      RemoveFromFavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit(LoadingState(favorites));
    try {
      await _favoritesManager.deleteFromFavorites(product: event.product);

      emit(LoadedState(favorites));
    } on FavoritesException catch (e) {
      addErrorEvent(e.message);
    }
  }

  void _onFavoritesErrorEvent(
      FavoritesErrorEvent event, Emitter<FavoritesState> emit) {
    emit(ErrorState(message: event.message, favorites: favorites));
  }

  void addToFavoritesEvent(ProductEntity product) {
    add(AddToFavoritesEvent(product: product));
  }

  void removeFromFavoritesEvent(ProductEntity product) {
    add(RemoveFromFavoritesEvent(product: product));
  }

  void loadFavoritesEvent() {
    add(LoadFavoritesEvent());
  }

  void addErrorEvent(String message) {
    add(FavoritesErrorEvent(message));
  }
}

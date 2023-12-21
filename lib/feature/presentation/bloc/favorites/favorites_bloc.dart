import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  FavoritesBloc({
    required this.cartManager,
    required IFavoritesManager favoritesManager,
  })  : _favoritesManager = favoritesManager,
        super(InitialFavoritesState()) {
    on<LoadFavoritesEvent>(_onLoadEvent);
    on<AddToFavoritesEvent>(_onAddToFavoritesEvent);
    on<RemoveFromFavoritesEvent>(_onRemoveFromFavoritesEvent);
    on<FavoritesErrorEvent>(_onFavoritesErrorEvent);

    init();
  }

  void init() {
    _favoritesState.addListener(loadFavoritesEvent);
  }

  void dispose() {
    _favoritesState.removeListener(loadFavoritesEvent);
    _favoritesState.dispose();
    cartState.dispose();
  }

  void _onLoadEvent(
      LoadFavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit(LoadingState(favorites));

    await _favoritesManager.getFavorites();

    emit(LoadedState(favorites));
  }

  void _onAddToFavoritesEvent(
      AddToFavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit(LoadingState(favorites));

    await _favoritesManager.addToFavorites(product: event.product);

    emit(LoadedState(favorites));
  }

  void _onRemoveFromFavoritesEvent(
      RemoveFromFavoritesEvent event, Emitter<FavoritesState> emit) async {
    emit(LoadingState(favorites));

    await _favoritesManager.deleteFromFavorites(product: event.product);

    emit(LoadedState(favorites));
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

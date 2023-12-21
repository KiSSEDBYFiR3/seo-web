import 'package:elementary_helper/src/relations/notifier/entity_state_notifier.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/favorites/i_favorites_manager.dart';
import 'package:seo_web/feature/domain/repository/favorites/i_favorites_repository.dart';

class FavoritesManager implements IFavoritesManager {
  final IFavoritesRepository _favoritesRepository;

  FavoritesManager({required IFavoritesRepository favoritesRepository})
      : _favoritesRepository = favoritesRepository;

  @override
  EntityStateNotifier<List<ProductEntity>> get favoritesState =>
      _favoritesState;

  final EntityStateNotifier<List<ProductEntity>> _favoritesState =
      EntityStateNotifier();

  @override
  Future<void> addToFavorites({required ProductEntity product}) async {
    final oldFavorites = _favoritesState.value.data ?? [];

    oldFavorites.add(product);
    _favoritesState.loading(oldFavorites);

    final favorites = await _favoritesRepository.addToFavorites(id: product.id);
    _favoritesState.content(favorites);
  }

  @override
  Future<void> deleteFromFavorites({required ProductEntity product}) async {
    final oldFavorites = _favoritesState.value.data ?? [];

    final index =
        oldFavorites.indexWhere((element) => element.id == product.id);
    oldFavorites.removeAt(index);

    _favoritesState.loading(oldFavorites);

    final favorites =
        await _favoritesRepository.deleteFromFavorites(id: product.id);
    _favoritesState.content(favorites);
  }

  @override
  Future<void> getFavorites() async {
    final oldFavorites = _favoritesState.value.data ?? [];
    _favoritesState.loading(oldFavorites);

    final favorites = await _favoritesRepository.getFavorites();
    _favoritesState.content(favorites);
  }

  @override
  void init() async {
    await getFavorites();
  }

  @override
  void dispose() {
    _favoritesState.dispose();
    favoritesState.dispose();
  }
}

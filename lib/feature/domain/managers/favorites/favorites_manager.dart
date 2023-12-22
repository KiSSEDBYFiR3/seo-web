import 'package:elementary_helper/elementary_helper.dart';
import 'package:seo_web/core/common/errors_bus/errors_bus.dart';
import 'package:seo_web/core/exception/exceptions.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/managers/favorites/i_favorites_manager.dart';
import 'package:seo_web/feature/domain/repository/favorites/i_favorites_repository.dart';

class FavoritesManager implements IFavoritesManager {
  final IFavoritesRepository _favoritesRepository;
  final IErrorsBus _errorsBus;

  FavoritesManager({
    required IFavoritesRepository favoritesRepository,
    required IErrorsBus errorsBus,
  })  : _favoritesRepository = favoritesRepository,
        _errorsBus = errorsBus;

  @override
  EntityStateNotifier<List<ProductEntity>> get favoritesState =>
      _favoritesState;

  final EntityStateNotifier<List<ProductEntity>> _favoritesState =
      EntityStateNotifier();

  @override
  Future<void> addToFavorites({required ProductEntity product}) async {
    try {
      final oldFavorites = _favoritesState.value.data ?? [];

      oldFavorites.add(product);
      _favoritesState.loading(oldFavorites);

      final favorites =
          await _favoritesRepository.addToFavorites(id: product.id);
      _favoritesState.content(favorites);
    } catch (e) {
      _errorsBus.addException(Exceptions.addToFavoritesException);
      throw Exceptions.addToFavoritesException;
    }
  }

  @override
  Future<void> deleteFromFavorites({required ProductEntity product}) async {
    try {
      final oldFavorites = _favoritesState.value.data ?? [];

      final index =
          oldFavorites.indexWhere((element) => element.id == product.id);
      oldFavorites.removeAt(index);

      _favoritesState.loading(oldFavorites);

      final favorites =
          await _favoritesRepository.deleteFromFavorites(id: product.id);
      _favoritesState.content(favorites);
    } catch (e) {
      _errorsBus.addException(Exceptions.deleteFromFavoritesException);
      throw Exceptions.deleteFromFavoritesException;
    }
  }

  @override
  Future<void> getFavorites() async {
    try {
      final oldFavorites = _favoritesState.value.data ?? [];
      _favoritesState.loading(oldFavorites);

      final favorites = await _favoritesRepository.getFavorites();
      _favoritesState.content(favorites);
    } catch (e) {
      _errorsBus.addException(Exceptions.getFavoritesException);
      throw Exceptions.getFavoritesException;
    }
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

import 'package:seo_web/feature/data/data_source/remote_data_source/favorites/i_favorites_data_source.dart';
import 'package:seo_web/feature/data/model/product/product_dto.dart';
import 'package:seo_web/feature/data/services/favorites/favorites_service.dart';

class FavoritesDataSource implements IFavoritesDataSource {
  final FavoritesService _favoritesService;

  const FavoritesDataSource({required FavoritesService favoritesService})
      : _favoritesService = favoritesService;

  @override
  Future<List<ProductDto>> addToFavorites({required int id}) async =>
      await _favoritesService.addToFavorites(id: id);

  @override
  Future<List<ProductDto>> deleteFromFavorites({required int id}) async =>
      await _favoritesService.deleteFromFavorites(id: id);

  @override
  Future<List<ProductDto>> getFavorites() async =>
      await _favoritesService.getFavorites();
}

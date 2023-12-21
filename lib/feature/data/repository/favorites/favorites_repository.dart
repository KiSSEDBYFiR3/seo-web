import 'package:seo_web/feature/data/data_source/remote_data_source/favorites/i_favorites_data_source.dart';
import 'package:seo_web/feature/data/model/product/mapper/mapper.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/domain/repository/favorites/i_favorites_repository.dart';

class FavoritesRepository implements IFavoritesRepository {
  final IFavoritesDataSource _dataSource;

  const FavoritesRepository({required IFavoritesDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<List<ProductEntity>> addToFavorites({required int id}) async =>
      (await _dataSource.addToFavorites(id: id))
          .map(dtoToProductMapper)
          .toList();

  @override
  Future<List<ProductEntity>> deleteFromFavorites({required int id}) async =>
      (await _dataSource.deleteFromFavorites(id: id))
          .map(dtoToProductMapper)
          .toList();

  @override
  Future<List<ProductEntity>> getFavorites() async =>
      (await _dataSource.getFavorites()).map(dtoToProductMapper).toList();
}

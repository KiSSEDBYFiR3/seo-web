import 'package:seo_web/feature/data/data_source/local_data_source/i_local_data_source.dart';
import 'package:seo_web/feature/domain/repository/i_local_repository.dart';

class LocalRepository implements ILocalAuthRepository {
  final ILocalAuthDataSource _localDataSource;

  const LocalRepository(this._localDataSource);

  @override
  Future<String> getAccessToken() async =>
      await _localDataSource.getAccessToken();
  @override
  Future<String> getRefreshToken() async =>
      await _localDataSource.getRefreshToken();

  @override
  Future<void> setAccessToken(String token) async =>
      await _localDataSource.setAccessToken(token);

  @override
  Future<void> setRefreshToken(String token) async =>
      await _localDataSource.setRefreshToken(token);

  @override
  Future<void> setUuid(String uuid) async =>
      await _localDataSource.setUuid(uuid);

  @override
  Future<String> getUuid() async => await _localDataSource.getUuid();
}

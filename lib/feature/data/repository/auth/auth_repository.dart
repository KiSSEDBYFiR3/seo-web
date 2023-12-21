import 'package:seo_web/feature/data/data_source/remote_data_source/auth/i_auth_data_source.dart';
import 'package:seo_web/feature/domain/repository/auth/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDataSource _remoteDataSource;
  const AuthRepository(this._remoteDataSource);

  @override
  Future<(String, String)> authorize() async =>
      await _remoteDataSource.authorize();

  @override
  Future<(String, String)> updateToken() async =>
      await _remoteDataSource.updateToken();
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:seo_web/feature/data/data_source/local_data_source/i_local_data_source.dart';

class LocalAuthDataSource implements ILocalAuthDataSource {
  final FlutterSecureStorage _secureStorage;

  const LocalAuthDataSource({
    required FlutterSecureStorage secureStorage,
  }) : _secureStorage = secureStorage;

  @override
  Future<String> getAccessToken() async =>
      await _secureStorage.read(key: 'access_token') ?? '';

  @override
  Future<String> getRefreshToken() async =>
      await _secureStorage.read(key: 'refresh_token') ?? '';

  @override
  Future<void> setAccessToken(String token) async =>
      await _secureStorage.write(key: 'access_token', value: token);

  @override
  Future<void> setRefreshToken(String token) =>
      _secureStorage.write(key: 'refresh_token', value: token);
}

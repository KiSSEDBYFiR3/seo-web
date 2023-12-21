abstract interface class ILocalAuthDataSource {
  Future<String> getRefreshToken();
  Future<void> setRefreshToken(String token);

  Future<String> getAccessToken();
  Future<void> setAccessToken(String token);

  Future<void> setUuid(String uuid);
  Future<String> getUuid();
}

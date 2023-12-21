abstract interface class ILocalAuthRepository {
  Future<String> getRefreshToken();
  Future<void> setRefreshToken(String token);

  Future<String> getAccessToken();
  Future<void> setAccessToken(String token);
}

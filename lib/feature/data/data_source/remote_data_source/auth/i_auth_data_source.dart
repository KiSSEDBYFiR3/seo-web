abstract interface class IAuthDataSource {
  Future<void> authorize(String token);
  Future<void> updateToken();
}

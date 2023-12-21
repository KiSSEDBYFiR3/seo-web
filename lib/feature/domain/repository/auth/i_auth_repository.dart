abstract interface class IAuthRepository {
  Future<void> authorize(String token);
  Future<void> updateToken();
}

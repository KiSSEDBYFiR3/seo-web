abstract interface class IAuthRepository {
  Future<(String, String)> authorize();
  Future<(String, String)> updateToken();
}

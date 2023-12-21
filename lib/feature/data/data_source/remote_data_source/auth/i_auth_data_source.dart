abstract interface class IAuthDataSource {
  Future<(String, String)> authorize();
  Future<(String, String)> updateToken();
}

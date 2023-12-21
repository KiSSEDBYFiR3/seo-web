import 'package:seo_web/feature/data/data_source/remote_data_source/auth/i_auth_data_source.dart';
import 'package:seo_web/feature/data/services/auth/auth_service.dart';
import 'package:seo_web/feature/domain/repository/i_local_repository.dart';

class AuthDataSource implements IAuthDataSource {
  final AuthService authService;
  final ILocalAuthRepository localRepository;

  const AuthDataSource({
    required this.authService,
    required this.localRepository,
  });

  @override
  Future<(String, String)> authorize() async {
    final response = await authService.authorize();
    await localRepository.setAccessToken(response.accessToken);
    await localRepository.setRefreshToken(response.refreshToken);
    return (response.accessToken, response.refreshToken);
  }

  @override
  Future<(String, String)> updateToken() async {
    final token = await localRepository.getRefreshToken();

    if (token.isEmpty) {
      final tokens = await authorize();
      return tokens;
    }

    final response = await authService.refresh();

    await localRepository.setAccessToken(response.accessToken);
    await localRepository.setRefreshToken(response.refreshToken);

    return (response.accessToken, response.refreshToken);
  }
}

import 'package:seo_web/feature/data/data_source/remote_data_source/auth/i_auth_data_source.dart';
import 'package:seo_web/feature/data/model/auth/auth_request_dto.dart';
import 'package:seo_web/feature/data/model/auth/free_token_request_dto.dart';
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
  Future<void> authorize(String token) async {
    final response = await authService.authorize(
      request: AuthRequestDto(accessToken: token),
    );
    await localRepository.setAccessToken(response.accessToken);
    await localRepository.setRefreshToken(response.refreshToken);
  }

  @override
  Future<void> updateToken() async {
    final token = await localRepository.getRefreshToken();

    if (token.isEmpty) {
      await authorize(token);
      return;
    }

    final response = await authService.freeToken(
      request: FreeTokenRequestDto(refreshToken: token),
    );

    await localRepository.setAccessToken(response.accessToken);
    await localRepository.setRefreshToken(response.refreshToken);
  }
}

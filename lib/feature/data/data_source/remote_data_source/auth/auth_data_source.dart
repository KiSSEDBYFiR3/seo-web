import 'package:dio/dio.dart';
import 'package:seo_web/core/exception/app_exceptions.dart';
import 'package:seo_web/feature/data/data_source/remote_data_source/auth/i_auth_data_source.dart';
import 'package:seo_web/feature/data/services/auth/auth_service.dart';
import 'package:seo_web/feature/domain/repository/i_local_repository.dart';

import 'dart:developer' as dev;

class AuthDataSource implements IAuthDataSource {
  final AuthService authService;
  final ILocalAuthRepository localRepository;

  const AuthDataSource({
    required this.authService,
    required this.localRepository,
  });

  @override
  Future<(String, String)> authorize() async {
    try {
      final response = await authService.authorize();

      await localRepository.setAccessToken(response.accessToken);
      await localRepository.setRefreshToken(response.refreshToken);

      return (response.accessToken, response.refreshToken);
    } on DioException catch (e, stackTrace) {
      dev.log(e.message.toString(), stackTrace: stackTrace);
      throw AuthException(e.message.toString());
    } catch (e, stackTrace) {
      dev.log(e.toString(), stackTrace: stackTrace);
      throw AuthException(e.toString());
    }
  }

  @override
  Future<(String, String)> updateToken() async {
    try {
      final token = await localRepository.getRefreshToken();

      if (token.isEmpty) {
        final tokens = await authorize();
        return tokens;
      }

      final response = await authService.refresh();

      await localRepository.setAccessToken(response.accessToken);
      await localRepository.setRefreshToken(response.refreshToken);

      return (response.accessToken, response.refreshToken);
    } on DioException catch (e, stackTrace) {
      dev.log(e.message.toString(), stackTrace: stackTrace);

      throw AuthException(e.message.toString());
    } catch (e, stackTrace) {
      dev.log(e.toString(), stackTrace: stackTrace);

      throw AuthException(e.toString());
    }
  }
}

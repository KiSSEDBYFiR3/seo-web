import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:seo_web/core/common/urls/urls.dart';
import 'package:seo_web/feature/data/model/auth/auth_request_dto.dart';
import 'package:seo_web/feature/data/model/auth/auth_response_dto.dart';
import 'package:seo_web/feature/data/model/auth/free_token_request_dto.dart';
import 'package:seo_web/feature/data/model/auth/free_token_response_dto.dart';

part 'auth_service.g.dart';

@RestApi(parser: Parser.FlutterCompute)
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST(Urls.auth)
  Future<AuthResponseDto> authorize({
    @Body() required AuthRequestDto request,
  });

  @POST(Urls.freeToken)
  Future<FreeTokenResponseDto> freeToken({
    @Body() required FreeTokenRequestDto request,
  });
}

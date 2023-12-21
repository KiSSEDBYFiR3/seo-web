import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:seo_web/core/common/utils/json.dart';

part 'auth_response_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createFactory: true,
  createToJson: false,
)
class AuthResponseDto {
  final String accessToken;
  final String refreshToken;

  const AuthResponseDto({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthResponseDto.fromJson(Json json) =>
      _$AuthResponseDtoFromJson(json);
}

FutureOr<AuthResponseDto> deserializeAuthResponseDto(Json json) =>
    AuthResponseDto.fromJson(json);

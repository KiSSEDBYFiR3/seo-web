import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:seo_web/core/common/utils/json.dart';

part 'auth_request_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createFactory: false,
  createToJson: true,
)
class AuthRequestDto {
  final String accessToken;

  const AuthRequestDto({
    required this.accessToken,
  });

  Json toJson() => _$AuthRequestDtoToJson(this);
}

FutureOr<Json> serializeAuthRequestDto(AuthRequestDto object) =>
    object.toJson();

import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:seo_web/core/common/utils/json.dart';

part 'free_token_response_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createFactory: true,
  createToJson: false,
)
class FreeTokenResponseDto {
  final String accessToken;
  final String refreshToken;

  const FreeTokenResponseDto({
    required this.accessToken,
    required this.refreshToken,
  });

  factory FreeTokenResponseDto.fromJson(Json json) =>
      _$FreeTokenResponseDtoFromJson(json);
}

FutureOr<FreeTokenResponseDto> deserializeFreeTokenResponseDto(Json json) =>
    FreeTokenResponseDto.fromJson(json);

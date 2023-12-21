import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:seo_web/core/common/utils/json.dart';

part 'free_token_request_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createFactory: false,
  createToJson: true,
)
class FreeTokenRequestDto {
  final String refreshToken;

  const FreeTokenRequestDto({
    required this.refreshToken,
  });

  Json toJson() => _$FreeTokenRequestDtoToJson(this);
}

FutureOr<Json> serializeFreeTokenRequestDto(FreeTokenRequestDto object) =>
    object.toJson();

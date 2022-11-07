import 'package:json_annotation/json_annotation.dart';

part 'token_entity.g.dart';

@JsonSerializable()
class TokenEntity {
  @JsonKey()
  String accessToken;
  @JsonKey()
  String refreshToken;
  @JsonKey()
  bool isNewUser;

  TokenEntity({
    this.accessToken = "",
    this.refreshToken = "",
    this.isNewUser = true,
  });

  factory TokenEntity.fromJson(Map<String, dynamic> json) =>
      _$TokenEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TokenEntityToJson(this);
}

import 'package:commons_infra/exceptions/app_exceptions.dart';

class TokenDto {
  const TokenDto({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory TokenDto.fromJson(Map<String, dynamic> json) {
    String require(String key) {
      final value = json[key] as String?;
      if (value == null || value.isEmpty) {
        throw ParseException('Missing required field: "$key"');
      }
      return value;
    }

    return TokenDto(
      accessToken:  require('access_token'),
      refreshToken: require('refresh_token'),
    );
  }

  Map<String, dynamic> toJson() => {
        'access_token':  accessToken,
        'refresh_token': refreshToken,
      };
}

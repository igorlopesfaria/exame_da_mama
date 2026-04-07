import 'package:feature_otp/domain/model/otp_channel.dart';

class OtpVerifyCodeRequest {
  const OtpVerifyCodeRequest({
    required this.channel,
    required this.value,
    required this.code,
  });

  final OtpChannel channel;
  final String value;
  final String code;

  Map<String, dynamic> toJson() => {
        'channel': channel.name,
        'value': value,
        'code': code,
      };
}

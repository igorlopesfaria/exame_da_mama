import 'package:feature_otp/domain/model/otp_channel.dart';

class OtpSendCodeRequest {
  const OtpSendCodeRequest({
    required this.channel,
    required this.value,
  });

  final OtpChannel channel;
  final String value;

  Map<String, dynamic> toJson() => {
        'channel': channel.name,
        'value': value,
      };
}

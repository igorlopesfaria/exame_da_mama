import 'package:feature_otp/data/models/response/otp_send_code_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OtpSendCodeResponse.fromJson', () {
    test('parses otp_next_request_in as int', () {
      final json = <String, dynamic>{'otp_next_request_in': 60};

      final response = OtpSendCodeResponse.fromJson(json);

      expect(response.otpNextRequestIn, 60);
    });

    test('converts double to int', () {
      final json = <String, dynamic>{'otp_next_request_in': 60.0};

      final response = OtpSendCodeResponse.fromJson(json);

      expect(response.otpNextRequestIn, 60);
    });

    test('parses zero value', () {
      final json = <String, dynamic>{'otp_next_request_in': 0};

      final response = OtpSendCodeResponse.fromJson(json);

      expect(response.otpNextRequestIn, 0);
    });
  });
}

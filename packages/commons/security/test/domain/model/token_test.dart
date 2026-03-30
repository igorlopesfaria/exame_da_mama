import 'package:commons_security/domain/model/token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tToken = Token(accessToken: 'access-abc', refreshToken: 'refresh-xyz');

  group('Token', () {
    test('holds accessToken and refreshToken', () {
      expect(tToken.accessToken, 'access-abc');
      expect(tToken.refreshToken, 'refresh-xyz');
    });

    test('two tokens with same values are equal', () {
      const other = Token(accessToken: 'access-abc', refreshToken: 'refresh-xyz');
      expect(tToken, equals(other));
    });

    test('two tokens with different accessToken are not equal', () {
      const other = Token(accessToken: 'different', refreshToken: 'refresh-xyz');
      expect(tToken, isNot(equals(other)));
    });

    test('two tokens with different refreshToken are not equal', () {
      const other = Token(accessToken: 'access-abc', refreshToken: 'different');
      expect(tToken, isNot(equals(other)));
    });

    test('equal tokens have the same hashCode', () {
      const other = Token(accessToken: 'access-abc', refreshToken: 'refresh-xyz');
      expect(tToken.hashCode, equals(other.hashCode));
    });

    test('props contains accessToken and refreshToken', () {
      expect(tToken.props, [tToken.accessToken, tToken.refreshToken]);
    });
  });
}

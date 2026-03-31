import 'package:commons_infra/exceptions/app_exceptions.dart';
import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_infra/repository/base_repository.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestRepository extends BaseRepository {}

void main() {
  late _TestRepository repository;

  setUp(() {
    repository = _TestRepository();
  });

  group('BaseRepository.safeCall', () {
    test('returns Right with value on success', () async {
      final result = await repository.safeCall(() async => 42);
      result.fold(
        (_) => fail('expected Right'),
        (v) => expect(v, 42),
      );
    });

    test('NetworkException → Left(NetworkFailure)', () async {
      final result = await repository.safeCall<int>(
        () async => throw const NetworkException(),
      );
      result.fold(
        (f) => expect(f, isA<NetworkFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('UnauthorizedException → Left(UnauthorizedFailure)', () async {
      final result = await repository.safeCall<int>(
        () async => throw const UnauthorizedException(),
      );
      result.fold(
        (f) => expect(f, isA<UnauthorizedFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('NotFoundException → Left(NotFoundFailure)', () async {
      final result = await repository.safeCall<int>(
        () async => throw const NotFoundException(),
      );
      result.fold(
        (f) => expect(f, isA<NotFoundFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('ParseException → Left(ParseFailure)', () async {
      final result = await repository.safeCall<int>(
        () async => throw const ParseException(),
      );
      result.fold(
        (f) => expect(f, isA<ParseFailure>()),
        (_) => fail('expected Left'),
      );
    });

    test('ServerException → Left(ServerFailure) with message', () async {
      final result = await repository.safeCall<int>(
        () async => throw const ServerException(message: 'timeout'),
      );
      result.fold(
        (f) {
          expect(f, isA<GenericFailure>());
          expect(f.message, 'timeout');
        },
        (_) => fail('expected Left'),
      );
    });

    test('unhandled exception → Left(ServerFailure)', () async {
      final result = await repository.safeCall<int>(
        () async => throw Exception('unexpected'),
      );
      result.fold(
        (f) => expect(f, isA<GenericFailure>()),
        (_) => fail('expected Left'),
      );
    });
  });
}

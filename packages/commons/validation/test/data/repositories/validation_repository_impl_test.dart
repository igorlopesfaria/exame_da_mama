import 'package:commons_validation/data/datasources/validation_remote_datasource.dart';
import 'package:commons_validation/data/repositories/validation_repository_impl.dart';
import 'package:commons_validation/domain/failures/validation_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockValidationRemoteDatasource extends Mock
    implements IValidationRemoteDatasource {}

void main() {
  late MockValidationRemoteDatasource mockDatasource;
  late ValidationRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockValidationRemoteDatasource();
    repository = ValidationRepositoryImpl(mockDatasource);
  });

  group('ValidationRepositoryImpl.validateEmail', () {
    test('returns Right(unit) when datasource succeeds', () async {
      when(() => mockDatasource.validateEmail(any()))
          .thenAnswer((_) async => right(unit));

      final result = await repository.validateEmail('user@example.com');
      expect(result, right(unit));
    });

    test('returns Left(AlreadyInUse) when datasource returns AlreadyInUse', () async {
      when(() => mockDatasource.validateEmail(any()))
          .thenAnswer((_) async => left(const AlreadyInUse()));

      final result = await repository.validateEmail('user@example.com');
      result.fold((f) => expect(f, isA<AlreadyInUse>()), (_) => fail('expected Left'));
    });

    test('delegates email value to datasource', () async {
      when(() => mockDatasource.validateEmail(any()))
          .thenAnswer((_) async => right(unit));

      await repository.validateEmail('user@example.com');
      verify(() => mockDatasource.validateEmail('user@example.com')).called(1);
    });
  });

  group('ValidationRepositoryImpl.validatePhone', () {
    test('returns Right(unit) when datasource succeeds', () async {
      when(() => mockDatasource.validatePhone(any()))
          .thenAnswer((_) async => right(unit));

      final result = await repository.validatePhone('11999887766');
      expect(result, right(unit));
    });

    test('returns Left(AlreadyInUse) when datasource returns AlreadyInUse', () async {
      when(() => mockDatasource.validatePhone(any()))
          .thenAnswer((_) async => left(const AlreadyInUse()));

      final result = await repository.validatePhone('11999887766');
      result.fold((f) => expect(f, isA<AlreadyInUse>()), (_) => fail('expected Left'));
    });

    test('delegates phone value to datasource', () async {
      when(() => mockDatasource.validatePhone(any()))
          .thenAnswer((_) async => right(unit));

      await repository.validatePhone('11999887766');
      verify(() => mockDatasource.validatePhone('11999887766')).called(1);
    });
  });

  group('ValidationRepositoryImpl.validateCpf', () {
    test('returns Right(unit) when datasource succeeds', () async {
      when(() => mockDatasource.validateCpf(any()))
          .thenAnswer((_) async => right(unit));

      final result = await repository.validateCpf('52998224725');
      expect(result, right(unit));
    });

    test('returns Left(AlreadyInUse) when datasource returns AlreadyInUse', () async {
      when(() => mockDatasource.validateCpf(any()))
          .thenAnswer((_) async => left(const AlreadyInUse()));

      final result = await repository.validateCpf('52998224725');
      result.fold((f) => expect(f, isA<AlreadyInUse>()), (_) => fail('expected Left'));
    });

    test('returns Left(ServerError) when datasource returns ServerError', () async {
      when(() => mockDatasource.validateCpf(any()))
          .thenAnswer((_) async => left(const ServerError()));

      final result = await repository.validateCpf('52998224725');
      result.fold((f) => expect(f, isA<ServerError>()), (_) => fail('expected Left'));
    });

    test('delegates cpf value to datasource', () async {
      when(() => mockDatasource.validateCpf(any()))
          .thenAnswer((_) async => right(unit));

      await repository.validateCpf('52998224725');
      verify(() => mockDatasource.validateCpf('52998224725')).called(1);
    });
  });
}

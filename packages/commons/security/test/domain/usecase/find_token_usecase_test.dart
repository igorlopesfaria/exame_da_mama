import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_security/domain/model/token.dart';
import 'package:commons_security/domain/repository/i_security_local_repository.dart';
import 'package:commons_security/domain/usecase/find_token_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockSecurityLocalRepository extends Mock
    implements ISecurityLocalRepository {}

void main() {
  late MockSecurityLocalRepository mockLocalRepo;
  late FindTokenUseCase useCase;

  const tToken = Token(accessToken: 'access-abc', refreshToken: 'refresh-xyz');

  setUp(() {
    mockLocalRepo = MockSecurityLocalRepository();
    useCase       = FindTokenUseCase(mockLocalRepo);
  });

  group('FindTokenUseCase', () {
    test('returns Right(token) when token exists', () async {
      when(() => mockLocalRepo.findToken())
          .thenAnswer((_) async => const Right(tToken));

      final result = await useCase.call();

      result.fold(
        (_) => fail('expected Right'),
        (token) => expect(token, tToken),
      );
    });

    test('returns Right(null) when no token is stored', () async {
      when(() => mockLocalRepo.findToken())
          .thenAnswer((_) async => const Right(null));

      final result = await useCase.call();

      result.fold(
        (_) => fail('expected Right'),
        (token) => expect(token, isNull),
      );
    });

    test('returns Left(failure) when repository fails', () async {
      when(() => mockLocalRepo.findToken())
          .thenAnswer((_) async => const Left(ServerFailure('storage error')));

      final result = await useCase.call();

      result.fold(
        (f) {
          expect(f, isA<ServerFailure>());
          expect(f.message, 'storage error');
        },
        (_) => fail('expected Left'),
      );
    });

    test('delegates to local repository', () async {
      when(() => mockLocalRepo.findToken())
          .thenAnswer((_) async => const Right(tToken));

      await useCase.call();

      verify(() => mockLocalRepo.findToken()).called(1);
    });
  });
}

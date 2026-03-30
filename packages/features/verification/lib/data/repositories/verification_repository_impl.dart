import 'package:dio/dio.dart';
import 'package:feature_verification/data/datasources/verification_remote_data_source.dart';
import 'package:feature_verification/domain/failures/verification_failure.dart';
import 'package:feature_verification/domain/repositories/verification_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: VerificationRepository)
class VerificationRepositoryImpl implements VerificationRepository {
  const VerificationRepositoryImpl(this._dataSource);

  final VerificationRemoteDataSource _dataSource;

  @override
  Future<Either<VerificationFailure, Unit>> sendEmailVerificationCode(String email) async {
    try {
      await _dataSource.sendEmailVerificationCode(email);
      return right(unit);
    } on DioException catch (e) {
      return left(_mapError(e));
    }
  }

  @override
  Future<Either<VerificationFailure, Unit>> sendPhoneVerificationCode(String phone) async {
    try {
      await _dataSource.sendPhoneVerificationCode(phone);
      return right(unit);
    } on DioException catch (e) {
      return left(_mapError(e));
    }
  }

  @override
  Future<Either<VerificationFailure, String>> verifyEmailCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _dataSource.verifyEmailCode(email: email, code: code);
      return right(response.verificationToken);
    } on DioException catch (e) {
      return left(_mapError(e));
    }
  }

  @override
  Future<Either<VerificationFailure, String>> verifyPhoneCode({
    required String phone,
    required String code,
  }) async {
    try {
      final response = await _dataSource.verifyPhoneCode(phone: phone, code: code);
      return right(response.verificationToken);
    } on DioException catch (e) {
      return left(_mapError(e));
    }
  }

  VerificationFailure _mapError(DioException e) {
    final error = e.response?.data?['error'] as String?;
    return switch (error) {
      'INVALID_CODE' => const VerificationFailure.invalidCode(),
      'EXPIRED_CODE' => const VerificationFailure.expiredCode(),
      'TOO_MANY_ATTEMPTS' => const VerificationFailure.tooManyAttempts(),
      _ => const VerificationFailure.serverError(),
    };
  }
}

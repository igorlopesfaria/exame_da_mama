import 'package:commons_infra/failures/app_failures.dart';
import 'package:fake_async/fake_async.dart';
import 'package:feature_otp/domain/failures/otp_failure.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/usecases/send_otp_code_use_case.dart';
import 'package:feature_otp/domain/usecases/verify_otp_code_use_case.dart';
import 'package:feature_otp/presentation/cubit/otp_cubit.dart';
import 'package:feature_otp/presentation/cubit/otp_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockSendOtpCodeUseCase extends Mock implements SendOtpCodeUseCase {}
class MockVerifyOtpCodeUseCase extends Mock implements VerifyOtpCodeUseCase {}

void main() {
  late MockSendOtpCodeUseCase mockSendOtp;
  late MockVerifyOtpCodeUseCase mockVerifyOtp;
  late OtpCubit cubit;

  const tChannel       = OtpChannel.email;
  const tContact       = 'user@test.com';
  const tCode          = '12345';
  const tToken         = 'verification-token-abc';
  const tNextRequestIn = 60;

  setUpAll(() {
    registerFallbackValue(OtpChannel.email);
  });

  setUp(() {
    mockSendOtp   = MockSendOtpCodeUseCase();
    mockVerifyOtp = MockVerifyOtpCodeUseCase();
    cubit = OtpCubit(mockSendOtp, mockVerifyOtp);
  });

  tearDown(() => cubit.close());

  // ── helpers ────────────────────────────────────────────────────────────────

  void stubSendSuccess([int nextRequestIn = tNextRequestIn]) =>
      when(() => mockSendOtp.call(any(), any()))
          .thenAnswer((_) async => right(nextRequestIn));

  void stubSendFailure(Failure failure) =>
      when(() => mockSendOtp.call(any(), any()))
          .thenAnswer((_) async => left(failure));

  void stubVerifySuccess([String token = tToken]) =>
      when(() => mockVerifyOtp.call(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenAnswer((_) async => right(token));

  void stubVerifyFailure(Failure failure) =>
      when(() => mockVerifyOtp.call(any(), value: any(named: 'value'), code: any(named: 'code')))
          .thenAnswer((_) async => left(failure));

  /// Captures [count] states emitted during [action].
  Future<List<OtpState>> captureStates(int count, Future<void> Function() action) async {
    final future = cubit.stream.take(count).toList();
    await action();
    return future;
  }

  // ── init ───────────────────────────────────────────────────────────────────

  group('init', () {
    test('sets state with provided countdownSeconds', () {
      cubit.init(tChannel, tContact, 30);

      expect(cubit.state.countdownSeconds, 30);
      expect(cubit.state.verifyCodeState, isA<OtpVerifyCodeIdle>());
      expect(cubit.state.resendCodeState, isA<OtpResendCodeIdle>());
    });

    test('sets countdownSeconds to 0 when 0 provided', () {
      cubit.init(tChannel, tContact, 0);

      expect(cubit.state.countdownSeconds, 0);
    });
  });

  // ── countdown ──────────────────────────────────────────────────────────────

  group('countdown', () {
    test('ticks down by 1 each second', () {
      fakeAsync((fake) {
        final seconds = <int>[];
        cubit.stream.listen((s) => seconds.add(s.countdownSeconds));

        cubit.init(tChannel, tContact, 3);
        fake.elapse(const Duration(seconds: 1));
        fake.elapse(const Duration(seconds: 1));
        fake.elapse(const Duration(seconds: 1));

        expect(seconds, [3, 2, 1, 0]);
      });
    });

    test('stops at zero and does not go negative', () {
      fakeAsync((fake) {
        cubit.init(tChannel, tContact, 2);
        fake.elapse(const Duration(seconds: 10));

        expect(cubit.state.countdownSeconds, 0);
      });
    });

    test('does not start timer when countdownSeconds is 0', () {
      fakeAsync((fake) {
        final states = <OtpState>[];
        cubit.stream.listen(states.add);

        cubit.init(tChannel, tContact, 0);
        fake.elapse(const Duration(seconds: 3));

        expect(states.length, 1);
        expect(states.first.countdownSeconds, 0);
      });
    });
  });

  // ── onCodeChanged ──────────────────────────────────────────────────────────

  group('onCodeChanged', () {
    test('sets isCodeComplete true when code has 5 chars', () {
      cubit.onCodeChanged('12345');

      expect(cubit.state.isCodeComplete, isTrue);
    });

    test('sets isCodeComplete false for less than 5 chars', () {
      cubit.onCodeChanged('123');

      expect(cubit.state.isCodeComplete, isFalse);
    });

    test('preserves countdownSeconds from current state', () {
      fakeAsync((fake) {
        cubit.init(tChannel, tContact, 30);
        cubit.onCodeChanged('12345');

        expect(cubit.state.countdownSeconds, 30);
      });
    });

    test('does not emit when loading', () async {
      stubVerifySuccess();
      cubit.init(tChannel, tContact, 0);
      cubit.onCodeChanged('12345');

      final emitted = <OtpState>[];
      cubit.stream.listen(emitted.add);

      final verifyFuture = cubit.verifyCode();
      cubit.onCodeChanged('99999'); // ignored — state.isLoading is true
      await verifyFuture;

      expect(
        emitted.any((s) =>
            s.verifyCodeState is OtpVerifyCodeLoading && !s.isCodeComplete),
        isFalse,
      );
    });
  });

  // ── verifyCode ─────────────────────────────────────────────────────────────

  group('verifyCode', () {
    setUp(() {
      cubit.init(tChannel, tContact, 0);
      cubit.onCodeChanged(tCode);
    });

    test('emits OtpVerifyCodeLoading then OtpVerifyCodeSuccess on success', () async {
      stubVerifySuccess();

      final states = await captureStates(2, cubit.verifyCode);

      expect(states[0].verifyCodeState, isA<OtpVerifyCodeLoading>());
      expect(states[1].verifyCodeState, isA<OtpVerifyCodeSuccess>());
      expect((states[1].verifyCodeState as OtpVerifyCodeSuccess).token, tToken);
    });

    test('emits OtpVerifyCodeLoading then OtpVerifyCodeError(InvalidCode)', () async {
      stubVerifyFailure(const InvalidCode());

      final states = await captureStates(2, cubit.verifyCode);

      expect(states[0].verifyCodeState, isA<OtpVerifyCodeLoading>());
      expect(states[1].verifyCodeState, isA<OtpVerifyCodeError>());
      expect(
        (states[1].verifyCodeState as OtpVerifyCodeError).failure,
        isA<InvalidCode>(),
      );
    });

    test('emits OtpVerifyCodeError(TooManyAttempts) on TooManyAttempts failure', () async {
      stubVerifyFailure(const TooManyAttempts());

      final states = await captureStates(2, cubit.verifyCode);

      expect(
        (states[1].verifyCodeState as OtpVerifyCodeError).failure,
        isA<TooManyAttempts>(),
      );
    });

    test('preserves countdownSeconds across loading and error states', () async {
      cubit.init(tChannel, tContact, 30);
      cubit.onCodeChanged(tCode);
      stubVerifyFailure(const NetworkFailure());

      final states = await captureStates(2, cubit.verifyCode);

      for (final s in states) {
        expect(s.countdownSeconds, 30);
      }
    });

    test('delegates channel, contact and code to use case', () async {
      stubVerifySuccess();
      await captureStates(2, cubit.verifyCode);

      verify(() => mockVerifyOtp.call(
        tChannel,
        value: tContact,
        code: tCode,
      )).called(1);
    });
  });

  // ── resendCode ─────────────────────────────────────────────────────────────

  group('resendCode', () {
    setUp(() => cubit.init(tChannel, tContact, 0));

    test('emits OtpResendCodeLoading then OtpResendCodeSuccess with nextRequestIn', () async {
      stubSendSuccess(45);

      final states = await captureStates(2, cubit.resendCode);

      expect(states[0].resendCodeState, isA<OtpResendCodeLoading>());
      expect(states[1].resendCodeState, isA<OtpResendCodeSuccess>());
      expect(states[1].countdownSeconds, 45);
    });

    test('emits OtpResendCodeError on failure', () async {
      stubSendFailure(const NetworkFailure());

      final states = await captureStates(2, cubit.resendCode);

      expect(states[1].resendCodeState, isA<OtpResendCodeError>());
      expect(
        (states[1].resendCodeState as OtpResendCodeError).failure,
        isA<NetworkFailure>(),
      );
    });

    test('resets countdown to nextRequestIn after resend success', () async {
      stubSendSuccess(45);

      final states = await captureStates(2, cubit.resendCode);

      expect(states.last.countdownSeconds, 45);
    });

    test('delegates channel and contact to use case', () async {
      stubSendSuccess();
      await captureStates(2, cubit.resendCode);

      verify(() => mockSendOtp.call(tChannel, tContact)).called(1);
    });
  });

  // ── resetToIdle ────────────────────────────────────────────────────────────

  group('resetToIdle', () {
    test('resets verifyCodeState and resendCodeState to idle, preserves countdownSeconds', () {
      fakeAsync((fake) {
        cubit.init(tChannel, tContact, 20);
        cubit.resetToIdle();

        expect(cubit.state.verifyCodeState, isA<OtpVerifyCodeIdle>());
        expect(cubit.state.resendCodeState, isA<OtpResendCodeIdle>());
        expect(cubit.state.countdownSeconds, 20);
      });
    });

    test('isCodeComplete true when code is complete', () {
      cubit.init(tChannel, tContact, 0);
      cubit.onCodeChanged('12345');
      cubit.resetToIdle();

      expect(cubit.state.isCodeComplete, isTrue);
    });

    test('isCodeComplete false when code is incomplete', () {
      cubit.init(tChannel, tContact, 0);
      cubit.onCodeChanged('123');
      cubit.resetToIdle();

      expect(cubit.state.isCodeComplete, isFalse);
    });
  });
}

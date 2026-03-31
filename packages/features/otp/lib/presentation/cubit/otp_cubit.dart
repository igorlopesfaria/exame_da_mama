import 'dart:async';

import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/usecases/send_otp_code_use_case.dart';
import 'package:feature_otp/domain/usecases/verify_otp_code_use_case.dart';
import 'package:feature_otp/presentation/cubit/otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this._sendOtp, this._verifyOtp) : super(const OtpState());

  final SendOtpCodeUseCase _sendOtp;
  final VerifyOtpCodeUseCase _verifyOtp;

  late OtpChannel _channel;
  late String _contact;
  String _currentCode = '';
  Timer? _timer;

  void init(OtpChannel channel, String contact, int countdownSeconds) {
    _channel = channel;
    _contact = contact;
    emit(OtpState(countdownSeconds: countdownSeconds));
    _startCountdown(countdownSeconds);
  }

  void _startCountdown(int seconds) {
    _timer?.cancel();
    _timer = null;
    if (seconds <= 0) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final remaining = state.countdownSeconds - 1;
      if (remaining <= 0) {
        _timer?.cancel();
        _timer = null;
        emit(state.copyWith(countdownSeconds: 0));
      } else {
        emit(state.copyWith(countdownSeconds: remaining));
      }
    });
  }

  void onCodeChanged(String code) {
    _currentCode = code;
    final isLoading = state.verifyCodeState is OtpVerifyCodeLoading ||
        state.resendCodeState is OtpResendCodeLoading;
    if (!isLoading) {
      emit(state.copyWith(
        isCodeComplete: code.length == 5,
        verifyCodeState: const OtpVerifyCodeIdle(),
      ));
    }
  }

  Future<void> verifyCode() async {
    emit(state.copyWith(verifyCodeState: const OtpVerifyCodeLoading()));
    final result =
        await _verifyOtp(_channel, value: _contact, code: _currentCode);
    result.fold(
      (failure) =>
          emit(state.copyWith(verifyCodeState: OtpVerifyCodeError(failure))),
      (token) =>
          emit(state.copyWith(verifyCodeState: OtpVerifyCodeSuccess(token))),
    );
  }

  Future<void> resendCode() async {
    emit(state.copyWith(resendCodeState: const OtpResendCodeLoading()));
    final result = await _sendOtp(_channel, _contact);
    result.fold(
      (failure) =>
          emit(state.copyWith(resendCodeState: OtpResendCodeError(failure))),
      (nextRequestIn) {
        emit(state.copyWith(
          resendCodeState: const OtpResendCodeSuccess(),
          countdownSeconds: nextRequestIn,
        ));
        _startCountdown(nextRequestIn);
      },
    );
  }

  void resetToIdle() {
    emit(state.copyWith(
      verifyCodeState: const OtpVerifyCodeIdle(),
      resendCodeState: const OtpResendCodeIdle(),
      isCodeComplete: _currentCode.length == 5,
    ));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

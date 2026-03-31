import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/domain/usecases/send_otp_code_use_case.dart';
import 'package:feature_otp/domain/usecases/verify_otp_code_use_case.dart';
import 'package:feature_otp/presentation/cubit/otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this._sendOtp, this._verifyOtp) : super(const OtpIdle());

  final SendOtpCodeUseCase _sendOtp;
  final VerifyOtpCodeUseCase _verifyOtp;

  late OtpChannel _channel;
  late String _contact;
  String _currentCode = '';

  void init(OtpChannel channel, String contact) {
    _channel = channel;
    _contact = contact;
  }

  void onCodeChanged(String code) {
    _currentCode = code;
    if (!state.isLoading) {
      emit(OtpIdle(isCodeComplete: code.length == 5));
    }
  }

  Future<void> verifyCode() async {
    emit(OtpVerifying(isCodeComplete: state.isCodeComplete));
    final result = await _verifyOtp(
      _channel,
      value: _contact,
      code: _currentCode,
    );
    result.fold(
      (failure) => emit(OtpVerifyError(failure, isCodeComplete: true)),
      (token) => emit(OtpVerifySuccess(token)),
    );
  }

  Future<void> resendCode() async {
    emit(OtpResending(isCodeComplete: state.isCodeComplete));
    final result = await _sendOtp(_channel, _contact);
    result.fold(
      (failure) => emit(
        OtpResendError(failure, isCodeComplete: state.isCodeComplete),
      ),
      (_) => emit(OtpResendSuccess(isCodeComplete: state.isCodeComplete)),
    );
  }

  void resetToIdle() {
    emit(OtpIdle(isCodeComplete: _currentCode.length == 5));
  }
}

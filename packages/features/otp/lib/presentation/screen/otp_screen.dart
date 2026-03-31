import 'package:commons_infra/failures/app_failures.dart';
import 'package:feature_otp/domain/failures/otp_failure.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/presentation/cubit/otp_cubit.dart';
import 'package:feature_otp/presentation/cubit/otp_state.dart';
import 'package:feature_otp/presentation/string/otp_localizations.dart';
import 'package:feature_otp/presentation/widget/otp_actions_widget.dart';
import 'package:feature_otp/presentation/widget/otp_code_input_widget.dart';
import 'package:feature_otp/presentation/widget/otp_header_widget.dart';
import 'package:flora/flora.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({
    super.key,
    required this.channel,
    required this.contact,
    this.onSuccess,
  });

  final OtpChannel channel;
  final String contact;
  final void Function(String token)? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<OtpCubit>()..init(channel, contact),
      child: _OtpView(
        channel: channel,
        contact: contact,
        onSuccess: onSuccess,
      ),
    );
  }
}

class _OtpView extends StatelessWidget {
  const _OtpView({
    required this.channel,
    required this.contact,
    this.onSuccess,
  });

  final OtpChannel channel;
  final String contact;
  final void Function(String token)? onSuccess;

  String _toastMessage(BuildContext context, Failure failure) {
    final l10n = OtpLocalizations.of(context);
    return switch (failure) {
      TooManyAttempts() => l10n.errorTooManyAttempts,
      NetworkFailure() => l10n.errorNoInternet,
      _ => l10n.errorGeneric,
    };
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OtpCubit>();

    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        switch (state) {
          case OtpVerifySuccess(:final token):
            onSuccess?.call(token);
            Navigator.of(context).pop(token);
          case OtpVerifyError(:final failure):
            if (failure is InvalidCode) {
              // Shown as error text on the input — no toast, no reset
            } else {
              FloraToast.show(context, position: FloraToastPosition.top,
                message: _toastMessage(context, failure),
                variant: FloraToastVariant.error,
              );
              cubit.resetToIdle();
            }
          case OtpResendError(:final failure):
            FloraToast.show(context, position: FloraToastPosition.top,
              message: _toastMessage(context, failure),
              variant: FloraToastVariant.error,
            );
            cubit.resetToIdle();
          case OtpResendSuccess():
            FloraToast.show(context, position: FloraToastPosition.top,
              message: OtpLocalizations.of(context).resendSuccess,
              variant: FloraToastVariant.success,
            );
            cubit.resetToIdle();
          default:
            break;
        }
      },
      child: BlocBuilder<OtpCubit, OtpState>(
        builder: (context, state) {
          final invalidCodeError = state is OtpVerifyError &&
              state.failure is InvalidCode
              ? OtpLocalizations.of(context).errorInvalidCode
              : null;

          return Padding(
            padding: EdgeInsets.fromLTRB(
              FloraSpacing.s2,
              FloraSpacing.s4,
              FloraSpacing.s2,
              FloraSpacing.s4
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                OtpHeaderWidget(channel: channel, contact: contact),
                const SizedBox(height: FloraSpacing.s6),
                Center(
                  child: OtpCodeInputWidget(
                    onChanged: cubit.onCodeChanged,
                    errorText: invalidCodeError,
                  ),
                ),
                const SizedBox(height: FloraSpacing.s4),
                OtpActionsWidget(
                  isCodeComplete: state.isCodeComplete,
                  isVerifying: state is OtpVerifying,
                  isResending: state is OtpResending,
                  onValidate: cubit.verifyCode,
                  onResend: cubit.resendCode,
                ),
                SizedBox(height: MediaQuery.paddingOf(context).bottom),
              ],
            ),
          );
        },
      ),
    );
  }
}

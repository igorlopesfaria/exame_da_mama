import 'package:commons_infra/failures/app_failures.dart';
import 'package:commons_navigation/commons_navigation.dart';
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
    required this.initialCountdownSeconds,
    this.onSuccess,
  });

  final OtpChannel channel;
  final String contact;
  final int initialCountdownSeconds;
  final void Function(String token)? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<OtpCubit>()
        ..init(channel, contact, initialCountdownSeconds),
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            canSizeOverlay: true,
            builder: (_) => FloraToastOverlay(
              child: _OtpView(
                channel: channel,
                contact: contact,
                onSuccess: onSuccess,
              ),
            ),
          ),
        ],
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

  void _showToast(
    BuildContext context, {
    required String message,
    required FloraToastVariant variant,
  }) {
    FloraToast.show(
      context,
      position: FloraToastPosition.top,
      message: message,
      variant: variant,
    );
  }

  String _failureMessage(BuildContext context, Failure failure) {
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
        switch (state.verifyStatus) {
          case OtpVerifySuccess(:final token):
            onSuccess?.call(token);
            AppNavigator.pop(context, token);
          case OtpVerifyError(:final failure):
            if (failure is! InvalidCode) {
              _showToast(context,
                message: _failureMessage(context, failure),
                variant: FloraToastVariant.error,
              );
              cubit.resetToIdle();
            }
          default:
            break;
        }
        switch (state.resendStatus) {
          case OtpResendError(:final failure):
            _showToast(context,
              message: _failureMessage(context, failure),
              variant: FloraToastVariant.error,
            );
            cubit.resetToIdle();
          case OtpResendSuccess():
            _showToast(context,
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
          final invalidCodeError =
              state.verifyStatus is OtpVerifyError &&
                      (state.verifyStatus as OtpVerifyError).failure
                          is InvalidCode
                  ? OtpLocalizations.of(context).errorInvalidCode
                  : null;

          return Padding(
            padding: EdgeInsets.fromLTRB(
              FloraSpacing.s2,
              FloraSpacing.s4,
              FloraSpacing.s2,
              FloraSpacing.s4,
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
                  isVerifying: state.verifyStatus is OtpVerifying,
                  isResending: state.resendStatus is OtpResending,
                  countdownSeconds: state.countdownSeconds,
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

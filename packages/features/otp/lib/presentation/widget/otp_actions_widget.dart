import 'package:feature_otp/presentation/string/otp_localizations.dart';
import 'package:flora/flora.dart';
import 'package:flutter/material.dart';

class OtpActionsWidget extends StatelessWidget {
  const OtpActionsWidget({
    super.key,
    required this.isCodeComplete,
    required this.isVerifying,
    required this.isResending,
    required this.onValidate,
    required this.onResend,
  });

  final bool isCodeComplete;
  final bool isVerifying;
  final bool isResending;
  final VoidCallback onValidate;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final l10n = OtpLocalizations.of(context);
    final isLoading = isVerifying || isResending;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FloraButton(
          label: l10n.resendCode,
          variant: FloraButtonVariant.text,
          size: FloraButtonSize.large,
          isLoading: isResending,
          onPressed: isLoading ? null : onResend,
        ),
        const SizedBox(height: FloraSpacing.s2),
        FloraButton(
          label: l10n.validateCode,
          variant: FloraButtonVariant.filled,
          size: FloraButtonSize.large,
          isLoading: isVerifying,
          onPressed: isCodeComplete && !isLoading ? onValidate : null,
        ),
      ],
    );
  }
}

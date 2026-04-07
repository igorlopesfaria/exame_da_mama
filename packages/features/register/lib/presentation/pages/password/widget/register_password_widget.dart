import 'package:feature_register/presentation/pages/password/string/register_password_localizations.dart';
import 'package:flora/flora.dart';
import 'package:flutter/material.dart';

class RegisterPasswordWidget extends StatelessWidget {
  const RegisterPasswordWidget({
    super.key,
    required this.onContinue,
  });

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = RegisterPasswordLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        FloraSpacing.s2,
        FloraSpacing.s4,
        FloraSpacing.s2,
        FloraSpacing.s4 + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FloraText.titleLarge(l10n.title),
          const SizedBox(height: FloraSpacing.s2),
          FloraText.bodyMedium(l10n.description),
          const SizedBox(height: FloraSpacing.s6),
          // Password text field — to be wired with cubit
          const Spacer(),
          FloraButton(
            label: l10n.continueButton,
            onPressed: onContinue,
          ),
        ],
      ),
    );
  }
}

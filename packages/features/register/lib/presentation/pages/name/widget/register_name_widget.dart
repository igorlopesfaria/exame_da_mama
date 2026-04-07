import 'package:feature_register/presentation/pages/name/string/register_name_localizations.dart';
import 'package:flora/flora.dart';
import 'package:flutter/material.dart';

class RegisterNameWidget extends StatelessWidget {
  const RegisterNameWidget({
    super.key,
    required this.onContinue,
  });

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = RegisterNameLocalizations.of(context);

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
          // Name text field — to be wired with cubit
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

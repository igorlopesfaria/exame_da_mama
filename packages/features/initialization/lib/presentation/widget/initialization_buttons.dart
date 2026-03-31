import 'package:feature_initialization/presentation/cubit/initialization_cubit.dart';
import 'package:feature_initialization/presentation/string/initialization_localizations.dart';
import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/presentation/screen/otp_screen.dart';
import 'package:flora/flora.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitializationButtons extends StatelessWidget {
  const InitializationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InitializationCubit>();
    final l10n  = InitializationLocalizations.of(context);

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(FloraRadius.largeValue)),
      ),
      padding: EdgeInsets.fromLTRB(
        FloraSpacing.s4,
        FloraSpacing.s8,
        FloraSpacing.s4,
        FloraSpacing.s4 + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FloraText.headlineMedium(
            l10n.appTitle,
            color: FloraTextColor.primary,
          ),
          const SizedBox(height: FloraSpacing.s1),
          FloraText.titleMedium(
            l10n.appSubtitle,
            color: FloraTextColor.secondary,
          ),
          const SizedBox(height: FloraSpacing.s4),
          FloraButton(
            label: l10n.createAccount,
            onPressed: cubit.goToRegister,
            variant: FloraButtonVariant.filled,
            size: FloraButtonSize.large,
          ),
          const SizedBox(height: FloraSpacing.s2),
          FloraButton(
            label: l10n.signIn,
            // onPressed: cubit.goToLogin,
            variant: FloraButtonVariant.outlined,
            size: FloraButtonSize.large,
            onPressed: () async {
              final token = await FloraBottomSheet.show(
                context,
                child: OtpScreen(
                  channel: OtpChannel.phone,       // or OtpChannel.phone
                  contact: '+5511976800990',     // email or phone number
                  initialCountdownSeconds: 60,
                  onSuccess: (token) {
                    // called immediately on success, before the sheet closes
                    // use token here if you need it synchronously
                  },
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}

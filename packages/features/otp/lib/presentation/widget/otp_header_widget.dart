import 'package:feature_otp/domain/model/otp_channel.dart';
import 'package:feature_otp/presentation/string/otp_localizations.dart';
import 'package:flora/flora.dart';
import 'package:flutter/material.dart';

class OtpHeaderWidget extends StatelessWidget {
  const OtpHeaderWidget({
    super.key,
    required this.channel,
    required this.contact,
  });

  final OtpChannel channel;
  final String contact;

  @override
  Widget build(BuildContext context) {
    final l10n = OtpLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FloraText.titleLarge(
            l10n.title,
          color: FloraTextColor.primary,
        ),
        const SizedBox(height: FloraSpacing.s1),
        FloraText.bodyMedium(
            channel == OtpChannel.email
                ? l10n.descriptionEmail(contact)
                : l10n.descriptionPhone(contact),
            color: FloraTextColor.secondary),
      ],
    );
  }
}

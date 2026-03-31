/// Flora DS — Feedback State Component
library;

import 'package:flutter/material.dart';
import 'flora_feedback_attributes.dart';
import 'flora_feedback_style.dart';
import '../../core/strings/localizations/flora_localizations.dart';

class FloraFeedbackState extends StatelessWidget {
  FloraFeedbackState({
    super.key,
    required FloraFeedbackType type,
    String? title,
    String? description,
    VoidCallback? primaryAction,
    String? primaryActionLabel,
    VoidCallback? secondaryAction,
    String? secondaryActionLabel,
  }) : _attributes = FloraFeedbackAttributes(
         type: type,
         title: title,
         description: description,
         primaryAction: primaryAction,
         primaryActionLabel: primaryActionLabel,
         secondaryAction: secondaryAction,
         secondaryActionLabel: secondaryActionLabel,
       );

  final FloraFeedbackAttributes _attributes;

  @override
  Widget build(BuildContext context) {
    final style = FloraFeedbackStateStyle.resolve(context, _attributes.type);
    final cs    = Theme.of(context).colorScheme;
    final tt    = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(color: style.containerColor, shape: BoxShape.circle),
              child: Icon(style.icon, size: 56, color: style.iconColor),
            ),
            const SizedBox(height: 24),
            Text(
              _attributes.title ??
                  FloraFeedbackContent.title(context, _attributes.type),
              style: tt.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              _attributes.description ??
                  FloraFeedbackContent.description(context, _attributes.type),
              style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _attributes.primaryAction,
              child: Text(
                _attributes.primaryActionLabel ??
                    FloraFeedbackContent.primaryLabel(context, _attributes.type),
              ),
            ),
            if (_attributes.secondaryAction != null) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: _attributes.secondaryAction,
                child: Text(
                  _attributes.secondaryActionLabel ??
                      FloraLocalizations.of(context)!.feedbackSecondaryBackHome,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

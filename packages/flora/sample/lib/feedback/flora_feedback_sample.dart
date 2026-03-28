import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraFeedbackSample extends StatelessWidget {
  const FloraFeedbackSample({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Feedback',
      children: [
        for (final type in FloraFeedbackType.values)
          SampleSection(
            title: type.name,
            children: [
              FloraFeedbackState(
                type: type,
                primaryAction: () {},
                secondaryAction: () {},
              ),
            ],
          ),
      ],
    );
  }
}
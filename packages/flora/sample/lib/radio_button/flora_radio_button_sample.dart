import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

enum _Option { optionA, optionB, optionC }

class FloraRadioButtonSample extends StatefulWidget {
  const FloraRadioButtonSample({super.key});

  @override
  State<FloraRadioButtonSample> createState() => _FloraRadioButtonSampleState();
}

class _FloraRadioButtonSampleState extends State<FloraRadioButtonSample> {
  _Option _selected = _Option.optionA;

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Radio Button',
      children: [
        SampleSection(
          title: 'Group',
          children: [
            for (final option in _Option.values)
              FloraRadioButton<_Option>(
                value: option,
                groupValue: _selected,
                label: option.name,
                onChanged: (v) => setState(() => _selected = v ?? _selected),
              ),
          ],
        ),
        SampleSection(
          title: 'States',
          children: [
            FloraRadioButton<String>(
              value: 'a',
              groupValue: 'a',
              label: 'Disabled selected',
              enabled: false,
              onChanged: null,
            ),
            FloraRadioButton<String>(
              value: 'b',
              groupValue: 'a',
              label: 'Disabled unselected',
              enabled: false,
              onChanged: null,
            ),
          ],
        ),
      ],
    );
  }
}
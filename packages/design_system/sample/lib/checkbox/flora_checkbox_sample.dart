import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraCheckboxSample extends StatefulWidget {
  const FloraCheckboxSample({super.key});

  @override
  State<FloraCheckboxSample> createState() => _FloraCheckboxSampleState();
}

class _FloraCheckboxSampleState extends State<FloraCheckboxSample> {
  bool _checked = true;
  bool _unchecked = false;
  bool? _tristate;

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Checkbox',
      children: [
        SampleSection(
          title: 'Interactive',
          children: [
            FloraCheckbox(
              value: _checked,
              label: 'Checked',
              onChanged: (v) => setState(() => _checked = v ?? false),
            ),
            FloraCheckbox(
              value: _unchecked,
              label: 'Unchecked',
              onChanged: (v) => setState(() => _unchecked = v ?? false),
            ),
            FloraCheckbox(
              value: _tristate,
              label: 'Tristate',
              tristate: true,
              onChanged: (v) => setState(() => _tristate = v),
            ),
          ],
        ),
        SampleSection(
          title: 'States',
          children: [
            FloraCheckbox(value: true, label: 'Error', isError: true, onChanged: null),
            FloraCheckbox(value: true, label: 'Disabled checked', enabled: false, onChanged: null),
            FloraCheckbox(value: false, label: 'Disabled unchecked', enabled: false, onChanged: null),
          ],
        ),
      ],
    );
  }
}
import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraSwitchSample extends StatefulWidget {
  const FloraSwitchSample({super.key});

  @override
  State<FloraSwitchSample> createState() => _FloraSwitchSampleState();
}

class _FloraSwitchSampleState extends State<FloraSwitchSample> {
  bool _on = true;
  bool _off = false;

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Switch',
      children: [
        SampleSection(
          title: 'Interactive',
          children: [
            FloraSwitch(value: _on, label: 'On', onChanged: (v) => setState(() => _on = v)),
            FloraSwitch(value: _off, label: 'Off', onChanged: (v) => setState(() => _off = v)),
          ],
        ),
        SampleSection(
          title: 'With thumb icon',
          children: [
            FloraSwitch(
              value: true,
              label: 'With icon',
              thumbIcon: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return const Icon(Icons.check, size: 16);
                return const Icon(Icons.close, size: 16);
              }),
              onChanged: (_) {},
            ),
          ],
        ),
        SampleSection(
          title: 'Disabled',
          children: [
            FloraSwitch(value: true, label: 'Disabled on', enabled: false, onChanged: null),
            FloraSwitch(value: false, label: 'Disabled off', enabled: false, onChanged: null),
          ],
        ),
      ],
    );
  }
}
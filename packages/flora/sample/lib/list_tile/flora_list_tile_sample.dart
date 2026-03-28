import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraListTileSample extends StatefulWidget {
  const FloraListTileSample({super.key});

  @override
  State<FloraListTileSample> createState() => _FloraListTileSampleState();
}

class _FloraListTileSampleState extends State<FloraListTileSample> {
  bool _checked = true;
  String _radio = 'a';
  bool _switch = true;

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'List Tile',
      children: [
        SampleSection(
          title: 'Standard',
          children: [
            FloraListTile(title: const Text('Simple title'), onTap: () {}),
            FloraListTile(
              title: const Text('With subtitle'),
              subtitle: const Text('Supporting text'),
              onTap: () {},
            ),
            FloraListTile(
              title: const Text('With leading'),
              leading: const Icon(Icons.inbox),
              onTap: () {},
            ),
            FloraListTile(
              title: const Text('With trailing'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            FloraListTile(
              title: const Text('Full'),
              subtitle: const Text('With all slots'),
              leading: const CircleAvatar(child: Icon(Icons.person)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ],
        ),
        SampleSection(
          title: 'With Controls',
          children: [
            FloraCheckboxListTile(
              value: _checked,
              title: const Text('Checkbox tile'),
              onChanged: (v) => setState(() => _checked = v ?? false),
            ),
            FloraRadioListTile<String>(
              value: 'a',
              groupValue: _radio,
              title: const Text('Radio tile A'),
              onChanged: (v) => setState(() => _radio = v ?? _radio),
            ),
            FloraRadioListTile<String>(
              value: 'b',
              groupValue: _radio,
              title: const Text('Radio tile B'),
              onChanged: (v) => setState(() => _radio = v ?? _radio),
            ),
            FloraSwitchListTile(
              value: _switch,
              title: const Text('Switch tile'),
              onChanged: (v) => setState(() => _switch = v),
            ),
          ],
        ),
        SampleSection(
          title: 'States',
          children: [
            FloraListTile(title: const Text('Disabled'), enabled: false),
            FloraListTile(title: const Text('Selected'), selected: true, onTap: () {}),
          ],
        ),
      ],
    );
  }
}
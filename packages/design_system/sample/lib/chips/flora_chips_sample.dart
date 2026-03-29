import 'package:flora/flora.dart';
import 'package:flora_sample/sample_section.dart';
import 'package:flutter/material.dart';

class FloraChipsSample extends StatefulWidget {
  const FloraChipsSample({super.key});

  @override
  State<FloraChipsSample> createState() => _FloraChipsSampleState();
}

class _FloraChipsSampleState extends State<FloraChipsSample> {
  bool _filterA = true;
  bool _filterB = false;
  bool _filterC = false;

  @override
  Widget build(BuildContext context) {
    return SampleScaffold(
      title: 'Chips',
      children: [
        SampleSection(
          title: 'Assist',
          children: [
            Wrap(spacing: FloraSpacing.s2, runSpacing: FloraSpacing.s2, children: [
              FloraAssistChip(label: 'Default', onPressed: () {}),
              FloraAssistChip(label: 'With avatar', avatar: const Icon(Icons.star, size: 18), onPressed: () {}),
              FloraAssistChip(label: 'Elevated', elevated: true, onPressed: () {}),
            ]),
          ],
        ),
        SampleSection(
          title: 'Filter',
          children: [
            Wrap(spacing: FloraSpacing.s2, runSpacing: FloraSpacing.s2, children: [
              FloraFilterChip(label: 'Option A', selected: _filterA, onSelected: (v) => setState(() => _filterA = v)),
              FloraFilterChip(label: 'Option B', selected: _filterB, onSelected: (v) => setState(() => _filterB = v)),
              FloraFilterChip(label: 'Option C', selected: _filterC, onSelected: (v) => setState(() => _filterC = v)),
            ]),
          ],
        ),
        SampleSection(
          title: 'Input',
          children: [
            Wrap(spacing: FloraSpacing.s2, runSpacing: FloraSpacing.s2, children: [
              FloraInputChip(label: 'Flutter', onDeleted: () {}),
              FloraInputChip(label: 'Dart', avatar: const Icon(Icons.code, size: 18), onDeleted: () {}),
            ]),
          ],
        ),
        SampleSection(
          title: 'Suggestion',
          children: [
            Wrap(spacing: FloraSpacing.s2, runSpacing: FloraSpacing.s2, children: [
              FloraSuggestionChip(label: 'Suggestion 1', onPressed: () {}),
              FloraSuggestionChip(label: 'Suggestion 2', onPressed: () {}),
              FloraSuggestionChip(label: 'Elevated', elevated: true, onPressed: () {}),
            ]),
          ],
        ),
        SampleSection(
          title: 'Group (scrollable)',
          children: [
            FloraChipGroup(
              chips: [
                for (int i = 1; i <= 8; i++)
                  FloraAssistChip(label: 'Chip $i', onPressed: () {}),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
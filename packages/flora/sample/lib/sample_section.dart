import 'package:flutter/material.dart';
import 'package:flora/flora.dart';

class SampleSection extends StatelessWidget {
  const SampleSection({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: FloraSpacing.s6, bottom: FloraSpacing.s3),
          child: Text(title, style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          )),
        ),
        const Divider(height: 1),
        const SizedBox(height: FloraSpacing.s4),
        ...children,
      ],
    );
  }
}

class SampleScaffold extends StatelessWidget {
  const SampleScaffold({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(FloraSpacing.s4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}
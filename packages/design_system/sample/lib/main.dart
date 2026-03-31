import 'package:flora/flora.dart';
import 'package:flora_sample/sample_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(const FloraSampleApp());

class FloraSampleApp extends StatelessWidget {
  const FloraSampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: FloraThemeProvider.instance,
      builder: (context, _) => MaterialApp(
        title: 'Flora DS',
        debugShowCheckedModeBanner: false,
        theme: FloraThemeProvider.instance.theme,
        home: const SampleList(),
      ),
    );
  }
}
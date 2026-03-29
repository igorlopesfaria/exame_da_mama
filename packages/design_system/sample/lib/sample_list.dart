import 'package:flora/flora.dart';
import 'package:flora_sample/media/flora_image_sample.dart';
import 'package:flora_sample/media/flora_icon_sample.dart';
import 'package:flora_sample/media/flora_animation_sample.dart';
import 'package:flora_sample/navigation/flora_app_bar_sample.dart';
import 'package:flora_sample/navigation/flora_navigation_bar_sample.dart';
import 'package:flora_sample/button/flora_button_sample.dart';
import 'package:flora_sample/card/flora_card_sample.dart';
import 'package:flora_sample/checkbox/flora_checkbox_sample.dart';
import 'package:flora_sample/chips/flora_chips_sample.dart';
import 'package:flora_sample/fab/flora_fab_sample.dart';
import 'package:flora_sample/feedback/flora_feedback_sample.dart';
import 'package:flora_sample/icon_button/flora_icon_button_sample.dart';
import 'package:flora_sample/list_tile/flora_list_tile_sample.dart';
import 'package:flora_sample/progress/flora_progress_sample.dart';
import 'package:flora_sample/radio_button/flora_radio_button_sample.dart';
import 'package:flora_sample/switch/flora_switch_sample.dart';
import 'package:flora_sample/text/flora_text_sample.dart';
import 'package:flora_sample/text_field/flora_text_field_sample.dart';
import 'package:flora_sample/toast/flora_toast_sample.dart';
import 'package:flutter/material.dart';

class SampleList extends StatelessWidget {
  const SampleList({super.key});

  static const _items = [
    _SampleItem(title: 'App Bar', subtitle: 'Small, medium, large variants', screen: FloraAppBarSample()),
    _SampleItem(title: 'Navigation Bar', subtitle: 'Label behaviors, item count variations', screen: FloraNavigationBarSample()),
    _SampleItem(title: 'Button', subtitle: 'Filled, tonal, outlined, text, elevated', screen: FloraButtonSample()),
    _SampleItem(title: 'Icon Button', subtitle: 'Standard, filled, tonal, outlined', screen: FloraIconButtonSample()),
    _SampleItem(title: 'FAB', subtitle: 'Small, regular, large — with and without label', screen: FloraFABSample()),
    _SampleItem(title: 'Text Field', subtitle: 'Filled, outlined, states', screen: FloraTextFieldSample()),
    _SampleItem(title: 'Checkbox', subtitle: 'States: checked, unchecked, error, disabled', screen: FloraCheckboxSample()),
    _SampleItem(title: 'Radio Button', subtitle: 'Group selection', screen: FloraRadioButtonSample()),
    _SampleItem(title: 'Switch', subtitle: 'On/off states', screen: FloraSwitchSample()),
    _SampleItem(title: 'Card', subtitle: 'Elevated, filled, outlined', screen: FloraCardSample()),
    _SampleItem(title: 'Chips', subtitle: 'Assist, filter, input, suggestion, group', screen: FloraChipsSample()),
    _SampleItem(title: 'List Tile', subtitle: 'Leading, trailing, subtitle variations', screen: FloraListTileSample()),
    _SampleItem(title: 'Progress', subtitle: 'Linear, circular, shimmer and step indicator', screen: FloraProgressSample()),
    _SampleItem(title: 'Feedback', subtitle: 'Empty, error, connection states', screen: FloraFeedbackSample()),
    _SampleItem(title: 'Text', subtitle: 'Display, headline, title, label, body scales', screen: FloraTextSample()),
    _SampleItem(title: 'Toast', subtitle: 'Info, success, warning, error variants', screen: FloraToastSample()),
    _SampleItem(title: 'Image', subtitle: 'Asset, network, fit variants, border radius', screen: FloraImageSample()),
    _SampleItem(title: 'Icon', subtitle: 'Flutter icon, asset, colors, sizes', screen: FloraIconSample()),
    _SampleItem(title: 'Animation', subtitle: 'Lottie asset, repeat, reverse, fit variants', screen: FloraAnimationSample()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flora DS'),
        actions: [
          IconButton(
            icon: Icon(
              FloraThemeProvider.instance.mode == FloraThemeMode.light
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
            onPressed: () => FloraThemeProvider.instance.setTheme(
              FloraThemeProvider.instance.mode == FloraThemeMode.light
                  ? FloraThemeMode.dark
                  : FloraThemeMode.light,
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: _items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, i) {
          final item = _items[i];
          return ListTile(
            title: Text(item.title),
            subtitle: Text(item.subtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => item.screen),
            ),
          );
        },
      ),
    );
  }
}

class _SampleItem {
  const _SampleItem({
    required this.title,
    required this.subtitle,
    required this.screen,
  });

  final String title;
  final String subtitle;
  final Widget screen;
}

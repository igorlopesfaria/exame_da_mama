/// Flora DS — FloraTextInputCode Component
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flora/components/inputs/code/flora_text_input_code_attributes.dart';
import 'package:flora/components/inputs/code/flora_text_input_code_style.dart';
import 'package:flora/components/text/flora_text.dart';
import 'package:flora/components/text/flora_text_attributes.dart';
import 'package:flora/core/tokens/flora_spacing.dart';

class FloraTextInputCode extends StatefulWidget {
  const FloraTextInputCode({
    super.key,
    required this.length,
    this.variant = FloraTextInputCodeVariant.outlined,
    this.obscureText = false,
    this.onCompleted,
    this.onChanged,
    this.errorText,
  });

  final int length;
  final FloraTextInputCodeVariant variant;
  final bool obscureText;
  final void Function(String code)? onCompleted;
  final void Function(String code)? onChanged;
  final String? errorText;

  @override
  State<FloraTextInputCode> createState() => _FloraTextInputCodeState();
}

class _FloraTextInputCodeState extends State<FloraTextInputCode> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  FloraTextInputCodeAttributes get _attributes => FloraTextInputCodeAttributes(
        length: widget.length,
        controllers: _controllers,
        focusNodes: _focusNodes,
        variant: widget.variant,
        obscureText: widget.obscureText,
        onCompleted: widget.onCompleted,
        onChanged: widget.onChanged,
        errorText: widget.errorText,
      );

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    _setupFocusNodes();
  }

  void _setupFocusNodes() {
    for (int i = 0; i < widget.length; i++) {
      final index = i;
      _focusNodes[i].addListener(() {
        if (_focusNodes[index].hasFocus && _controllers[index].text.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _focusNodes[index].hasFocus) {
              _controllers[index].selection = TextSelection(
                baseOffset: 0,
                extentOffset: _controllers[index].text.length,
              );
            }
          });
        }
      });
      _focusNodes[i].onKeyEvent = (node, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace &&
            _controllers[index].text.isEmpty &&
            index > 0) {
          _focusNodes[index - 1].requestFocus();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      };
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  void _onFieldChanged(int index, String value) {
    if (value.isEmpty) return;

    if (index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else {
      _focusNodes[index].unfocus();
    }

    final code = _controllers.map((c) => c.text).join();
    widget.onChanged?.call(code);
    if (code.length == widget.length) {
      widget.onCompleted?.call(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final attrs = _attributes;
    final style = FloraTextInputCodeStyle.resolve(context, attrs.variant);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < attrs.length; i++) ...[
              if (i > 0) const SizedBox(width: FloraTextInputCodeStyle.spacing),
              _CodeBox(
                controller: attrs.controllers[i],
                focusNode: attrs.focusNodes[i],
                style: style,
                obscureText: attrs.obscureText,
                hasError: attrs.errorText != null,
                onChanged: (value) => _onFieldChanged(i, value),
              ),
            ],
          ],
        ),
        if (attrs.errorText != null) ...[
          const SizedBox(height: FloraSpacing.s1),
          Padding(
            padding: const EdgeInsets.only(left: FloraSpacing.s4),
            child: FloraText.bodySmall(attrs.errorText!, color: FloraTextColor.error),
          ),
        ],
      ],
    );
  }
}

class _CodeBox extends StatefulWidget {
  const _CodeBox({
    required this.controller,
    required this.focusNode,
    required this.style,
    required this.obscureText,
    required this.hasError,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final FloraTextInputCodeStyleData style;
  final bool obscureText;
  final bool hasError;
  final ValueChanged<String> onChanged;

  @override
  State<_CodeBox> createState() => _CodeBoxState();
}

class _CodeBoxState extends State<_CodeBox> {
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (mounted) setState(() => _hasFocus = widget.focusNode.hasFocus);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  BoxDecoration get _decoration {
    if (widget.hasError) return widget.style.errorBoxDecoration;
    if (_hasFocus) return widget.style.focusedBoxDecoration;
    return widget.style.boxDecoration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: FloraTextInputCodeStyle.boxSize,
      height: FloraTextInputCodeStyle.boxSize,
      decoration: _decoration,
      alignment: Alignment.center,
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        obscuringCharacter: '•',
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: widget.style.textStyle,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
          contentPadding: EdgeInsets.zero,
          isDense: true,
        ),
      ),
    );
  }
}

/// Flora DS — FloraToast Component
library;

import 'package:flutter/material.dart';
import 'package:flora/components/toast/flora_toast_attributes.dart';
import 'package:flora/components/toast/flora_toast_style.dart';

abstract final class FloraToast {
  static void show(
    BuildContext context, {
    required String message,
    FloraToastVariant variant          = FloraToastVariant.info,
    FloraToastDuration duration        = FloraToastDuration.medium,
    FloraToastPosition position        = FloraToastPosition.bottom,
    String? actionLabel,
    void Function()? onAction,
    void Function()? onDismissed,
    bool showCloseButton               = false,
    Widget? leadingIcon,
  }) {
    FloraToastOverlay.show(
      context,
      message:         message,
      variant:         variant,
      duration:        duration,
      position:        position,
      actionLabel:     actionLabel,
      onAction:        onAction,
      onDismissed:     onDismissed,
      showCloseButton: showCloseButton,
      leadingIcon:     leadingIcon,
    );
  }

  static void hide(BuildContext context) =>
      FloraToastOverlay.of(context)._dismiss();

  static void clearAll(BuildContext context) =>
      FloraToastOverlay.of(context)._dismiss();
}


class FloraToastOverlay extends StatefulWidget {
  const FloraToastOverlay({super.key, required this.child});

  final Widget child;

  static FloraToastOverlayState of(BuildContext context) {
    final state = context.findAncestorStateOfType<FloraToastOverlayState>();
    assert(state != null);
    return state!;
  }

  static void show(
    BuildContext context, {
    required String message,
    FloraToastVariant variant          = FloraToastVariant.info,
    FloraToastDuration duration        = FloraToastDuration.medium,
    FloraToastPosition position        = FloraToastPosition.bottom,
    String? actionLabel,
    void Function()? onAction,
    void Function()? onDismissed,
    bool showCloseButton               = false,
    Widget? leadingIcon,
  }) {
    FloraToastOverlay.of(context)._show(
      context,
      message:         message,
      variant:         variant,
      duration:        duration,
      position:        position,
      actionLabel:     actionLabel,
      onAction:        onAction,
      onDismissed:     onDismissed,
      showCloseButton: showCloseButton,
      leadingIcon:     leadingIcon,
    );
  }

  @override
  State<FloraToastOverlay> createState() => FloraToastOverlayState();
}

class FloraToastOverlayState extends State<FloraToastOverlay>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _entry;
  FloraToastAttributes? _current;
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync:           this,
      duration:        FloraToastStyle.enterDuration,
      reverseDuration: FloraToastStyle.exitDuration,
    );
    _opacity = CurvedAnimation(parent: _controller, curve: FloraToastStyle.enterCurve);
    _slide   = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: FloraToastStyle.enterCurve));
  }

  @override
  void dispose() {
    _controller.dispose();
    _entry?.remove();
    super.dispose();
  }

  void _show(
    BuildContext callerContext, {
    required String message,
    FloraToastVariant variant          = FloraToastVariant.info,
    FloraToastDuration duration        = FloraToastDuration.medium,
    FloraToastPosition position        = FloraToastPosition.bottom,
    String? actionLabel,
    void Function()? onAction,
    void Function()? onDismissed,
    bool showCloseButton               = false,
    Widget? leadingIcon,
  }) {
    final overlay = Overlay.of(callerContext);
    _dismiss().then((_) {
      _current = FloraToastAttributes(
        message:         message,
        variant:         variant,
        duration:        duration,
        position:        position,
        actionLabel:     actionLabel,
        onAction:        onAction,
        onDismissed:     onDismissed,
        showCloseButton: showCloseButton,
        leadingIcon:     leadingIcon,
      );

      _entry = OverlayEntry(
        builder: (_) => _FloraOverlayToast(
          attributes: _current!,
          opacity:    _opacity,
          slide:      _slide,
          onDismiss:  _handleDismiss,
        ),
      );

      overlay.insert(_entry!);
      _controller.forward();

      if (!_current!.isPersistent) {
        Future.delayed(_current!.effectiveDuration, _handleDismiss);
      }
    });
  }

  void _handleDismiss() {
    _dismiss().then((_) => _current?.onDismissed?.call());
  }

  Future<void> _dismiss() async {
    if (_entry == null) return;
    await _controller.reverse();
    _entry?.remove();
    _entry = null;
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _FloraOverlayToast extends StatelessWidget {
  const _FloraOverlayToast({
    required this.attributes,
    required this.opacity,
    required this.slide,
    required this.onDismiss,
  });

  final FloraToastAttributes attributes;
  final Animation<double> opacity;
  final Animation<Offset> slide;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final style    = FloraToastStyle.resolve(context, attributes.variant);
    final isBottom = attributes.position == FloraToastPosition.bottom;

    return Positioned(
      bottom: isBottom ? FloraToastStyle.bottomMargin : null,
      top:    isBottom ? null : FloraToastStyle.topMargin,
      left:   FloraToastStyle.horizontalMargin,
      right:  FloraToastStyle.horizontalMargin,
      child: SlideTransition(
        position: slide,
        child: FadeTransition(
          opacity: opacity,
          child: Material(
            color: Colors.transparent,
            child: Container(
              constraints:
                  const BoxConstraints(maxWidth: FloraToastStyle.maxWidth),
              decoration: BoxDecoration(
                color:        style.backgroundColor,
                borderRadius: FloraToastStyle.shape,
                boxShadow: [
                  BoxShadow(
                    color:      Colors.black.withValues(alpha: 0.12),
                    blurRadius: 8,
                    offset:     const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: FloraToastStyle.contentPadding,
                child: Row(
                  children: [
                    attributes.leadingIcon ??
                        Icon(style.iconData,
                            size: 20, color: style.foregroundColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        attributes.message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: style.foregroundColor,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (attributes.actionLabel != null) ...[
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          attributes.onAction?.call();
                          onDismiss();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: style.actionColor,
                          padding:        const EdgeInsets.symmetric(horizontal: 8),
                          minimumSize:    const Size(0, 36),
                        ),
                        child: Text(attributes.actionLabel!),
                      ),
                    ],
                    if (attributes.showCloseButton) ...[
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: onDismiss,
                        child: Icon(
                          Icons.close_rounded,
                          size:  20,
                          color: style.foregroundColor.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

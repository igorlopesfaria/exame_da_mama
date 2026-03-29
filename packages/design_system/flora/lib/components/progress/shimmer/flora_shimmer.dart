/// Flora DS — Shimmer Components
library;

import 'package:flutter/material.dart';

class FloraShimmer extends StatefulWidget {
  const FloraShimmer({
    super.key,
    required this.child,
    this.isLoading = true,
    this.duration = const Duration(milliseconds: 1200),
  });

  final Widget child;
  final bool isLoading;
  final Duration duration;

  @override
  State<FloraShimmer> createState() => _FloraShimmerState();
}

class _FloraShimmerState extends State<FloraShimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) return widget.child;
    final cs        = Theme.of(context).colorScheme;
    final base      = cs.surfaceContainerHighest;
    final highlight = cs.surfaceContainerLow;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) => LinearGradient(
          colors: [base, highlight, base],
          stops: [
            (_animation.value - 0.3).clamp(0.0, 1.0),
            _animation.value.clamp(0.0, 1.0),
            (_animation.value + 0.3).clamp(0.0, 1.0),
          ],
        ).createShader(bounds),
        child: child,
      ),
      child: widget.child,
    );
  }
}

class FloraShimmerBox extends StatelessWidget {
  const FloraShimmerBox({super.key, required this.width, required this.height, this.borderRadius});
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: borderRadius ?? BorderRadius.circular(4),
    ),
  );
}

class FloraShimmerListItem extends StatelessWidget {
  const FloraShimmerListItem({super.key, this.hasLeading = true});
  final bool hasLeading;

  @override
  Widget build(BuildContext context) => FloraShimmer(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (hasLeading) ...[
            FloraShimmerBox(width: 40, height: 40, borderRadius: BorderRadius.circular(20)),
            const SizedBox(width: 12),
          ],
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FloraShimmerBox(width: double.infinity, height: 14),
                SizedBox(height: 8),
                FloraShimmerBox(width: 160, height: 12),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
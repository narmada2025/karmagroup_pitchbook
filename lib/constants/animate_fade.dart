import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimateFade extends StatefulWidget {
  final Widget child;
  final Duration? delay;

  const AnimateFade({super.key, required this.child, this.delay});

  @override
  State<AnimateFade> createState() => _AnimateFadeState();
}

class _AnimateFadeState extends State<AnimateFade>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.5 && !_isVisible) {
      _isVisible = true;
      if (widget.delay != null) {
        Future.delayed(widget.delay!).then((_) {
          _animationController.forward();
        });
      } else {
        _animationController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('visibility-detector-key'),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedOpacity(
        opacity: _opacityAnimation.value,
        duration: _animationController.duration!,
        child: widget.child,
      ),
    );
  }
}

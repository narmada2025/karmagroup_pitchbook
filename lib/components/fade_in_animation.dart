import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final double initOpacity;
  final bool animateOnce;
  final Duration delay;
  final double visibilityThreshold;

  const FadeInAnimation({
    super.key,
    required this.child,
    this.initOpacity = 0,
    this.animateOnce = true,
    this.delay = const Duration(milliseconds: 0),
    this.visibilityThreshold = 0.5,
  });

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation> {
  double _opacity = 0.0;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _opacity = widget.initOpacity;
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('fade-in-container-${widget.hashCode}'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction >= widget.visibilityThreshold) {
          if (!widget.animateOnce || !_hasAnimated) {
            Future.delayed(widget.delay, () {
              if (mounted) {
                setState(() {
                  _opacity = 1.0;
                  _hasAnimated = true;
                });
              }
            });
          }
        } else if (widget.animateOnce && info.visibleFraction == 0.0) {}
      },
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 500),
        child: widget.child,
      ),
    );
  }
}

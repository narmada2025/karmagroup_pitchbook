import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FadeInScaleAnimation extends StatefulWidget {
  final Widget child;
  final double initOpacity;
  final double initScale;
  final bool animateOnce;
  final Duration scaleDelay;
  final Duration scaleDuration;

  const FadeInScaleAnimation({
    super.key,
    required this.child,
    this.initOpacity = 0.2,
    this.initScale = 0.0,
    this.animateOnce = true,
    this.scaleDelay = const Duration(milliseconds: 0),
    this.scaleDuration = const Duration(milliseconds: 500),
  });

  @override
  State<FadeInScaleAnimation> createState() => _FadeInScaleAnimationState();
}

class _FadeInScaleAnimationState extends State<FadeInScaleAnimation> {
  double _opacity = 0.0;
  double _scale = 0.0;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _opacity = widget.initOpacity;
    _scale = widget.initScale;
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('fade-in-container-${widget.hashCode}'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction >= 0.5) {
          setState(() {
            if (!widget.animateOnce || !_hasAnimated) {
              _opacity = 1.0;

              Future.delayed(widget.scaleDelay, () {
                if (mounted) {
                  setState(() {
                    _scale = 1.0;
                  });
                }
              });
              _hasAnimated = true;
            }
          });
        } else if (widget.animateOnce && info.visibleFraction == 0.0) {}
      },
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 500),
        child: AnimatedScale(
          scale: _scale,
          duration: widget.scaleDuration,
          child: widget.child,
        ),
      ),
    );
  }
}

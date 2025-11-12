import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

enum SlideDirection { left, right, top, bottom }

class SlideInAnimation extends StatefulWidget {
  final Widget child;
  final SlideDirection direction;
  final Duration duration;
  final Duration delay;
  final bool animateOnce;
  final double visibilityThreshold;
  final double distance;

  const SlideInAnimation({
    super.key,
    required this.child,
    this.direction = SlideDirection.bottom,
    this.duration = const Duration(milliseconds: 500),
    this.delay = const Duration(milliseconds: 0),
    this.animateOnce = true,
    this.visibilityThreshold = 0.5,
    this.distance = 1.0,
  });

  @override
  State<SlideInAnimation> createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<SlideInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    Offset begin;
    switch (widget.direction) {
      case SlideDirection.left:
        begin = Offset(-widget.distance, 0.0);
        break;
      case SlideDirection.right:
        begin = Offset(widget.distance, 0.0);
        break;
      case SlideDirection.top:
        begin = Offset(0.0, -widget.distance);
        break;
      case SlideDirection.bottom:
        begin = Offset(0.0, widget.distance);
        break;
    }

    _offsetAnimation = Tween<Offset>(
      begin: begin,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction >= widget.visibilityThreshold &&
        (!widget.animateOnce || !_hasAnimated)) {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
          _hasAnimated = true;
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.child.hashCode.toString()),
      onVisibilityChanged: _handleVisibilityChanged,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _offsetAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}

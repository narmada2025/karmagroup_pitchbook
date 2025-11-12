import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CounterWidget extends StatefulWidget {
  final int number;
  final String sufix;
  final String label;
  final int step;
  final TextStyle? numberStyle;
  final TextStyle? labelStyle;

  const CounterWidget({
    super.key,
    required this.number,
    required this.sufix,
    required this.label,
    required this.step,
    this.numberStyle,
    this.labelStyle,
  });

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final _visibilityKey = UniqueKey();
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.number.toDouble(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction > 0 && !_hasAnimated) {
          _animationController.forward();
          _hasAnimated = true;
        }
      },
      child: ValueListenableBuilder(
        valueListenable: _animation,
        builder: (context, value, child) {
          int intValue = value.floor();
          return Column(
            children: [
              Text(
                '${(intValue ~/ widget.step) * widget.step + (intValue % widget.step > 0 ? widget.step : 0)}${widget.sufix}',
                style: widget.numberStyle ??
                    TextStyle(
                      fontSize: TextSize.h5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              Text(
                widget.label,
                style: widget.labelStyle ??
                    TextStyle(
                      fontSize: TextSize.def,
                      color: Colors.black,
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}

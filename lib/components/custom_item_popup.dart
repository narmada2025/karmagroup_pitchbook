import 'package:flutter/material.dart';

class CustomItemPopup<T> extends StatefulWidget {
  final List<T> items;
  final int initialIndex;
  final Function(T) itemBuilder;

  const CustomItemPopup({
    super.key,
    required this.items,
    required this.initialIndex,
    required this.itemBuilder,
  });

  @override
  State<CustomItemPopup> createState() => _CustomItemPopupState();
}

class _CustomItemPopupState<T> extends State<CustomItemPopup<T>> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 10) {
          if (_currentIndex > 0) {
            setState(() {
              _currentIndex--;
            });
          }
        } else if (details.delta.dx < -10) {
          if (_currentIndex < widget.items.length - 1) {
            setState(() {
              _currentIndex++;
            });
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: const Text('Previous'),
                onPressed: () {
                  if (_currentIndex > 0) {
                    setState(() {
                      _currentIndex--;
                    });
                  }
                },
              ),
              Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.itemBuilder(widget.items[_currentIndex]),
                  ],
                ),
              ),
              TextButton(
                child: const Text('Next'),
                onPressed: () {
                  if (_currentIndex < widget.items.length - 1) {
                    setState(() {
                      _currentIndex++;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

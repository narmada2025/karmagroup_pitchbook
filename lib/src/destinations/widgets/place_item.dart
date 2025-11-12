import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';

class PlaceItem extends StatefulWidget {
  final Map<String, dynamic> place;
  final int index;
  final String lang;
  final Function onTap;
  final bool isSelected;
  final bool animate;
  final int placeCount;
  final int destination;

  const PlaceItem({
    super.key,
    required this.place,
    required this.lang,
    required this.index,
    required this.onTap,
    this.isSelected = false,
    this.animate = false,
    required this.destination,
    required this.placeCount,
  });

  @override
  State<PlaceItem> createState() => _PlaceItemState();
}

class _PlaceItemState extends State<PlaceItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fontSizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fontSizeAnimation = Tween<double>(begin: 22, end: 60).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isSelected) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant PlaceItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int items = widget.placeCount > 4 ? 3 : widget.placeCount - 1;

    return InkWell(
      onTap: () => widget.onTap(widget.index),
      splashColor: Colors.transparent,
      child: AnimatedContainer(
        key: ValueKey(widget.place['name']),
        duration: const Duration(milliseconds: 400),
        width: widget.isSelected
            ? widget.placeCount == 2
                ? MediaQuery.of(context).size.width / 1.5
                : MediaQuery.of(context).size.width / 2
            : (MediaQuery.of(context).size.width /
                    (widget.placeCount == 2
                        ? 3
                        : widget.placeCount == 4
                            ? 2
                            : 1.8)) /
                items,
        height: 380,
        child: FadeInAnimation(
          visibilityThreshold: 0.3,
          delay: Duration(
              milliseconds:
                  widget.animate == true && widget.destination == 0 ? 800 : 0),
          initOpacity:
              widget.animate == true && widget.destination == 0 ? 0 : 1,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('${AppAPI.baseUrlGcp}${widget.place['image']}'),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.black.withValues(alpha: 0.6),
                    AppColors.black.withValues(alpha: 0.0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.2, 1.0],
                ),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                alignment: widget.isSelected
                    ? Alignment.bottomRight
                    : Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AnimatedBuilder(
                      animation: _fontSizeAnimation,
                      builder: (context, child) {
                        return Text(
                          widget.place['name'][widget.lang],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: _fontSizeAnimation.value,
                            color: AppColors.white,
                            fontFamily: 'Playfair',
                          ),
                        );
                      },
                    ),
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

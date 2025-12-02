import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';

class ConciergeItem extends StatelessWidget {
  final String title;
  final String image;
  final int index;
  final Function onTap;
  final bool isSelected;
  final int placeCount;

  const ConciergeItem({
    super.key,
    required this.title,
    required this.image,
    required this.index,
    required this.onTap,
    this.isSelected = false,
    required this.placeCount,
  });

  @override
  Widget build(BuildContext context) {
    final int items = placeCount > 4 ? 3 : placeCount - 1;
    return InkWell(
      onTap: () => onTap(
        index,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: isSelected
            ? placeCount == 2
                ? MediaQuery.of(context).size.width / 1.5
                : MediaQuery.of(context).size.width / 2
            : (MediaQuery.of(context).size.width /
                    (placeCount == 2
                        ? 3
                        : placeCount == 4
                            ? 2
                            : 1.8)) /
                items,
        height: 380,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage('${AppAPI.baseUrlGcp}$image'),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter),
        ),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.black.withValues(alpha: 0.85),
                AppColors.black.withValues(alpha: 0.0)
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.2, 1.0],
            ),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            alignment:
                isSelected ? Alignment.bottomRight : Alignment.bottomCenter,
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: isSelected ? 60 : 22,
                color: AppColors.white,
              ),
              child: Text(
                title,
                textAlign: isSelected ? TextAlign.right : TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Playfair',
                  height: isSelected ? 1 : 1.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';

class CountryItem extends StatelessWidget {
  final Map<String, dynamic> country;
  final int index;
  final String lang;
  final Function onTap;
  final bool isSelected;

  const CountryItem({
    super.key,
    required this.country,
    required this.lang,
    required this.index,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () => onTap(
          index,
        ),
        child: SizedBox(
          height: 120,
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: ValueNotifier(isSelected),
              builder: (context, value, child) {
                return AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: isSelected
                      ? const TextStyle(
                          fontSize: 36,
                          color: AppColors.primary,
                          fontFamily: 'Playfair')
                      : const TextStyle(
                          fontSize: 18,
                          color: AppColors.white,
                          fontFamily: 'Montserrat'),
                  child: Text(
                    country['name'][lang],
                    textAlign: TextAlign.center,
                    style: const TextStyle(height: 1),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

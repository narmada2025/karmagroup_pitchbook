import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_scale_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_btn.dart';
import 'package:pitchbook/constants/custom_text.dart';

class KarmaClubFractionalOwnershipWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final String lang;

  const KarmaClubFractionalOwnershipWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print("fractionalownership========${AppAPI.baseUrlGcp}${data['image']}");
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(80),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('${AppAPI.baseUrlGcp}${data['image']}'),
          fit: BoxFit.cover,
        ),
      ),
      child: FadeInScaleAnimation(
        child: Container(
          width: size.width / 1.3,
          padding: const EdgeInsets.all(60),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColors.primary),
          ),
          child: SizedBox(
            width: 450,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  label: data['title'][lang],
                  type: 'h2',
                  isSerif: true,
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(color: AppColors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                  label: data['description'][lang],
                  type: 'md',
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(color: AppColors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBtn(
                  label: data['Explore'][lang],
                  btnType: BtnType.primary,
                  onPressed: () {
                    Navigator.pushNamed(context, '/fractional-ownership');
                  },
                  textAlign: TextAlign.center,
                  borderRadius: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

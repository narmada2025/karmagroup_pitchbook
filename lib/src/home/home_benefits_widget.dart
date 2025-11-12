import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/components/bullet_list_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class HomeBenifitsWidget extends StatelessWidget {
  const HomeBenifitsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.all(80),
      color: AppColors.black,
      child: Column(
        children: [
          const CustomText(
            label: 'Membership Benefits',
            type: 'h2',
            textStyle: TextStyle(color: AppColors.primary),
            isSerif: true,
          ),
          const SizedBox(height: 60),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(40),
                  color: AppColors.gray,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        label: 'Karma Club Discovery',
                        type: 'h2',
                        isSerif: true,
                        textStyle: TextStyle(color: AppColors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomText(
                        label: 'What you will get',
                        type: 'lg',
                        textStyle: TextStyle(color: AppColors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BulletListWidget(
                        iconWidget: SvgPicture.asset(
                          AppIcons.squareIcon,
                          width: 14,
                          fit: BoxFit.contain,
                          semanticsLabel: 'quote',
                          placeholderBuilder: (context) =>
                              const CircularProgressIndicator(),
                        ),
                        textStyle: const TextStyle(color: AppColors.white),
                        type: 'sm',
                        gap: 12.0,
                        itemGap: 6,
                        items: [
                          BulletItem(
                            text: 'Limited access to exclusive resorts',
                          ),
                          BulletItem(
                            text: 'Standard booking experience',
                          ),
                          BulletItem(
                            text: 'Standard vacation packages',
                          ),
                          BulletItem(
                            text: 'No access to exclusive events',
                          ),
                          BulletItem(
                            text: 'Limited support and assistance',
                          ),
                          BulletItem(
                            text: 'Pay full price for bookings',
                          ),
                          BulletItem(
                            text: 'No access to loyalty rewards',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomText(
                        label: 'Pay full price for bookings',
                        type: 'sm',
                        textStyle: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(40),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.gray,
                        AppColors.gray,
                        AppColors.primary
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.15, 1.0],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        label: 'Karma Club',
                        type: 'xsm',
                        isSerif: true,
                        textStyle: TextStyle(color: AppColors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomText(
                        label: 'What you will get',
                        type: 'lg',
                        textStyle: TextStyle(color: AppColors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BulletListWidget(
                        iconWidget: SvgPicture.asset(
                          AppIcons.diamondIcon,
                          width: 14,
                          fit: BoxFit.contain,
                          semanticsLabel: 'quote',
                          placeholderBuilder: (context) =>
                              const CircularProgressIndicator(),
                        ),
                        textStyle: const TextStyle(color: AppColors.white),
                        type: 'sm',
                        gap: 12.0,
                        itemGap: 6,
                        items: [
                          BulletItem(
                            text: 'Exclusive Access to Luxury Resorts',
                          ),
                          BulletItem(
                            text: 'Streamlined Booking Process',
                          ),
                          BulletItem(
                            text: 'Customized Vacation Packages',
                          ),
                          BulletItem(
                            text: 'Invitations to Exclusive Events',
                          ),
                          BulletItem(
                            text: 'Personalized Vacation Planning',
                          ),
                          BulletItem(
                            text: 'Discounts on Bookings',
                          ),
                          BulletItem(
                            text: 'Earn Loyalty Rewards Points',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomText(
                        label: '25 % Off Exclusive Travel Deals',
                        textStyle: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(40),
                  color: AppColors.gray,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        label: 'Karma Royal Residences',
                        type: 'h2',
                        isSerif: true,
                        textStyle: TextStyle(color: AppColors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomText(
                        label: 'What you will get',
                        type: 'lg',
                        textStyle: TextStyle(color: AppColors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BulletListWidget(
                        iconWidget: SvgPicture.asset(
                          AppIcons.squareIcon,
                          width: 14,
                          fit: BoxFit.contain,
                          semanticsLabel: 'quote',
                          placeholderBuilder: (context) =>
                              const CircularProgressIndicator(),
                        ),
                        textStyle: const TextStyle(color: AppColors.white),
                        type: 'sm',
                        gap: 8,
                        itemGap: 6,
                        items: [
                          BulletItem(
                            text: 'Limited access to exclusive resorts',
                          ),
                          BulletItem(
                            text: 'Standard booking experience',
                          ),
                          BulletItem(
                            text: 'Standard vacation packages',
                          ),
                          BulletItem(
                            text: 'No access to exclusive events',
                          ),
                          BulletItem(
                            text: 'Limited support and assistance',
                          ),
                          BulletItem(
                            text: 'Pay full price for bookings',
                          ),
                          BulletItem(
                            text: 'No access to loyalty rewards',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomText(
                        label: 'Pay full price for bookings',
                        type: 'sm',
                        textStyle: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/karma_timeline/widgets/custom_thumb_shape.dart';
import 'package:pitchbook/src/karma_timeline/widgets/icon_num_text.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_Eleven.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_eight.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_five.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_four.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_nine.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_one.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_seven.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_six.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_ten.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_three.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_titles.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_twelve.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_two.dart';

class KarmaTimelineScreen extends StatefulWidget {
  const KarmaTimelineScreen({super.key});

  @override
  State<KarmaTimelineScreen> createState() => _KarmaTimelineScreenState();
}

class _KarmaTimelineScreenState extends State<KarmaTimelineScreen> {
  Map<String, dynamic> data = {};
  bool _isLoading = true;

  int _currentIndex = 33;
  int _currentYear = 2026;
  List<int> years = List<int>.generate(34, (int index) => 1993 + index);

  final int _oldYear = 2026;

  late PageController _pageController;
  final _scrollController = ScrollController();

  // void _scrollToCurrentYear() {
  //   int currentIndex = _currentIndex * 63;
  //   _scrollController.animateTo(
  //     currentIndex.toDouble(),
  //     duration: Duration(milliseconds: 500),
  //     curve: Curves.ease,
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _loadJsonData();
    _pageController = PageController(initialPage: _currentIndex);
  }

  Future<void> _loadJsonData() async {
    final jsonData = await loadJsonFromAssets(AppAPI.timeline);
    setState(() {
      data = jsonData;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Locale locale = Localizations.localeOf(context);
    String lang = locale.languageCode;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: _isLoading
          ? const LoadingComponent()
          : Stack(
              children: [
                Image.network(
                  '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/map_bg.png'}',
                  fit: BoxFit.fitWidth,
                  width: size.width,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 60, 80, 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TweenAnimationBuilder(
                        tween: IntTween(begin: _oldYear, end: _currentYear),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                        builder: (context, value, child) {
                          return CustomText(
                            label:(value.toInt() == 2026)?"2025 \n& beyond":value.toInt().toString(),
                            type: 'h3',
                            textStyle:
                                const TextStyle(color: AppColors.primary),
                            textAlign: TextAlign.end,
                            isSerif: true,
                          );
                        },
                      )
                    ],
                  ),
                ),
                PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                      _currentYear = 1993 + index;
                    });
                  },
                  children: [
                    TimelineStyleOne(
                      title: data['cardTitle1'][lang],
                      image: 'assets/images/kg-timeline/John Spence_1.png',
                      logo: 'assets/images/kg-timeline/Royal_Resort_logo.png',
                      text: data['cardTitle2'][lang],
                    ),
                    TimelineStyleTwo(
                      status: data['Launched'][lang],
                      title: 'Luisa by the Sea',
                      image: 'assets/images/kg-timeline/images/1994.png',
                      icon: 'assets/images/kg-timeline/Icon_1.png',
                      number: '5',
                      text: data['NEW OFF-SITE OFFICES'][lang],
                    ),
                    TimelineStyleTwo(
                      image: 'assets/images/kg-timeline/images/1995.jpg',
                      icon: 'assets/images/kg-timeline/Icon_1.png',
                      number: '14',
                      text: data['NEW OFF-SITE OFFICES'][lang],
                    ),
                    TimelineStyleTwo(
                      status: data['Launched'][lang],
                      title: 'Royal Goan Beach \nClub at Benaulim',
                      image: 'assets/images/kg-timeline/images/1996.png',
                      icon: 'assets/images/kg-timeline/Icon_1.png',
                      number: '6',
                      text: data['NEW OFFICES OPENED'][lang],
                    ),
                    TimelineStyleTwo(
                      status: data['opened'][lang],
                      title: 'Karma Royal \nCandidasa',
                      tag: 'goa, india',
                      image: 'assets/images/kg-timeline/images/1997.jpg',
                      icon: 'assets/images/kg-timeline/Icon_1.png',
                      number: '4',
                      text: data['NEW OFFICES OPENED'][lang],
                    ),
                    TimelineStyleThree(
                      status: data['opened'][lang],
                      title: 'Karma Royal MonteRio',
                      tag: 'goa, india',
                      image: 'assets/images/kg-timeline/images/1998.jpg',
                      title2: 'Royal Terranora \nBeach Club',
                      tag2: 'NSW, AUSTRALIA',
                      icon: 'assets/images/kg-timeline/Icon_1.png',
                      number: '7',
                      text: data['NEW OFFICES OPENED'][lang],
                      icon2: 'assets/images/kg-timeline/Icon_2.png',
                      award:
                          'assets/images/kg-timeline/John Spence_RCI hall of frame.png',
                    ),
                    TimelineStyleThree(
                      status: data['opened'][lang],
                      title: 'Karma Royal Jimbaran',
                      tag: 'BALI, INDONESIA',
                      image: 'assets/images/kg-timeline/images/1999.jpg',
                      title2: 'Karma Royal Palms',
                      tag2: 'goa, india',
                      icon2: 'assets/images/kg-timeline/Icon_1.png',
                      textRight: data['Auckland'][lang],
                    ),
                    TimelineStyleFour(
                        status: data['opened'][lang],
                        title: 'Karma Royal \nHaathi Mahal',
                        tag: 'GOA, INDIA',
                        image: 'assets/images/kg-timeline/images/2000.png',
                        title2: 'Karma Royal \nBella Vista',
                        tag2: 'Chiang Mai, Thailand',
                        title3: 'Karma Royal \nBoat Lagoon',
                        tag3: 'Phuket, Thailand',
                        icon: 'assets/images/kg-timeline/Icon_1.png',
                        textRight: data['SURABAYA'][lang]),
                    TimelineStyleTwo(
                      status: data['opened'][lang],
                      title: 'Karma Reef',
                      tag: 'Gili Meno, Indonesia',
                      image: 'assets/images/kg-timeline/images/2001.jpg',
                      icon: 'assets/images/kg-timeline/Icon_1.png',
                      text: data['KUWAIT'][lang],
                    ),
                    TimelineStyleFive(
                      title: data['Joint Ventures'][lang],
                      status: data['Launched'][lang],
                      logo: 'assets/images/kg-timeline/Royal_Sterling.png',
                      logo2:
                          'assets/images/kg-timeline/Royal_Country_Vaeations.png',
                      icon1: 'assets/images/kg-timeline/gap.png',
                      icon2: 'assets/images/kg-timeline/Royal_Toshali.png',
                      icon3: 'assets/images/kg-timeline/camp_royal.png',
                      icon4:
                          'assets/images/kg-timeline/Christel_House_India.png',
                    ),
                    TimelineStyleSix(
                      status: data['Launched'][lang],
                      title: 'Real Estate Division',
                      tag: 'bali, indonesia',
                      image: 'assets/images/kg-timeline/images/2003.png',
                      image2: 'assets/images/kg-timeline/John Spence_2.png',
                      logo: 'assets/images/kg-timeline/RDI.png',
                    ),
                    TimelineStyleSeven(
                      status: data['opened'][lang],
                      title: 'Karma Jimbaran',
                      tag: 'bali, indonesia',
                      image: 'assets/images/kg-timeline/images/2004.png',
                      rightWidget: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/JOHN SENCE_IPhilanthropist of the year.png'}',
                            width: 140,
                          ),
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/ARDA.png'}',
                            width: 60,
                          ),
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/the_leading_small_hotels_of_the_world.png'}',
                            width: 140,
                          ),
                        ],
                      ),
                    ),
                    TimelineStyleEight(
                      title: data['Conceptualized'][lang],
                      title2: data['Formed'][lang],
                      image: 'assets/images/kg-timeline/images/2005.png',
                      logo: 'assets/images/kg-timeline/Karma_Resorts_Logo.png',
                      rightWidget: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Wrap(
                          runSpacing: 40,
                          children: [
                            Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Karma_Developments_Logo.png'}',
                              height: 50,
                            ),
                            Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Karma_estates_Logo.png'}',
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                    ),
                    TimelineStyleEight(
                      topPadding: 150,
                      status: data['opened'][lang],
                      title: 'Karma Samui',
                      tag: 'Koh Samui, THAILAND',
                      title2: 'Conceptualized',
                      image: 'assets/images/kg-timeline/images/2006.png',
                      rightWidget: Wrap(
                        runSpacing: 40,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Karma_Royal_Group.png'}',
                              height: 80,
                            ),
                          ),
                          const IconNumText(
                            icon: 'assets/images/kg-timeline/Icon_1.png',
                            text: 'Opened  Office \nin SURABAYA',
                          )
                        ],
                      ),
                    ),
                    TimelineStyleEight(
                      topPadding: 150,
                      status: data['GROUND WORK BEGAN'][lang],
                      title: 'Karma kandara',
                      image: 'assets/images/kg-timeline/images/2007.png',
                      rightWidget: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 40,
                        children: [
                          IconNumText(
                            icon: 'assets/images/kg-timeline/Icon_2.png',
                            number: '02',
                            text: data['GLOBAL AWARDS'][lang],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/best_development_2007.png'}',
                                width: 65,
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Image.network(
                                  '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/best_property_2007.png'}',
                                  width: 65,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //2008
                    TimelineStyleSeven(
                      status: data['opened'][lang],
                      title: 'Karma Kandara',
                      tag: 'bali, indonesia',
                      title2: 'Karma Saboey',
                      tag2: 'Koh Samui, Thailand',
                      image: 'assets/images/kg-timeline/images/2008.jpg',
                      rightWidget: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        direction: Axis.vertical,
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Icon_2.png'}',
                            width: 50,
                          ),
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Beach_Club_in_bali.png'}',
                            width: 80,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 40),
                            padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primary, width: 0.5)),
                            child: CustomText(
                              label: data['Gary Knowles Joined'][lang].toString().toUpperCase(),
                              type: 'sm',
                              textStyle:
                                  const TextStyle(color: AppColors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    //2009
                    TimelineStyleNine(
                      topPadding: 150,
                      image: 'assets/images/kg-timeline/images/2009.png',
                      leftWidget: Stack(
                        children: [
                          Positioned(
                            child: TimelineStyleTitles(
                              status: data['opened'][lang],
                              title: 'K2 at Bansko',
                              tag: 'BULGARIA',
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 50,
                            child: TimelineStyleTitles(
                              status: data['Launched'][lang],
                              title: 'Bali Getaway',
                              showArrow: false,
                            ),
                          )
                        ],
                      ),
                      rightWidget: Wrap(
                        runSpacing: 40,
                        alignment: WrapAlignment.center,
                        children: [
                          IconNumText(
                            icon: 'assets/images/kg-timeline/Icon_2.png',
                            number: '04',
                            text: data['GLOBAL AWARDS'][lang],
                            padLeft: 0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Column(
                                  children: [
                                    Image.network(
                                      '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/asiaSpa.png'}',
                                      width: 80,
                                    ),
                                    Container(
                                      width: 120,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: CustomText(
                                        label: data['BEST CHILDRENS SPA'][lang],
                                        type: 'sm',
                                        textAlign: TextAlign.center,
                                        textStyle: const TextStyle(
                                            color: Colors.white, height: 1.2),
                                      ),
                                    ),
                                    Image.network(
                                      '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Indonesias_best_restaurants.png'}',
                                      width: 65,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Image.network(
                                '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/International_Property_Awards_2009.png'}',
                                width: 65,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //2010
                    TimelineStyleNine(
                      topPadding: 150,
                      image: 'assets/images/kg-timeline/images/2010.png',
                      leftWidget: Stack(
                        children: [
                          Positioned(
                            child: TimelineStyleTitles(
                              status: data['opened'][lang],
                              title: 'Pelikanos',
                              tag: 'Mykonos, Greece',
                            ),
                          ),
                          const Positioned(
                            bottom: 0,
                            left: 0,
                            child: TimelineStyleTitles(
                              title: 'Royal Kovalam Beach',
                              tag: 'Kerala, India',
                              showArrow: false,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 20,
                            child: TimelineStyleTitles(
                              status: data['Launched'][lang],
                              title: 'K Music Collection',
                              showArrow: false,
                            ),
                          )
                        ],
                      ),
                      rightWidget: Wrap(
                        runSpacing: 40,
                        spacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          IconNumText(
                            icon: 'assets/images/kg-timeline/Icon_2.png',
                            number: '03',
                            text: data['GLOBAL AWARDS'][lang],
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 20,
                            spacing: 20,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Image.network(
                                  '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Ernst & Young Entrepreneur of the year.png'}',
                                  height: 40,
                                ),
                              ),
                              Image.network(
                                '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Miele_Guide.png'}',
                                height: 70,
                              ),
                              Image.network(
                                '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Best_Childrens_Spa_Winner.png'}',
                                height: 44,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //2011
                    TimelineStyleTen(
                      contentAlignment: CrossAxisAlignment.center,
                      leftWidget: Wrap(
                        runSpacing: 30,
                        children: [
                          IconNumText(
                            number: '05',
                            text: data['New resorts'][lang],
                            textStyle: const TextStyle(fontSize: 20),
                            textPadding: const EdgeInsets.only(top: 6),
                            contentAlignment: MainAxisAlignment.start,
                          ),
                          TimelineStyleTitles(
                            status: data['opened'][lang],
                            title: 'Karma Bavaria',
                            tag: 'schliersee, Germany',
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2011_1.png'}'),
                        ],
                      ),
                      centerWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          const TimelineStyleTitles(
                            title: 'Karma Haveli',
                            tag: 'jaipur, India',
                            showArrow: false,
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2011_2.png'}'),
                          const TimelineStyleTitles(
                            title: 'Royal Himalayan Club ',
                            tag: 'Sikkim, India',
                            showArrow: false,
                          ),
                          const TimelineStyleTitles(
                            title: 'Karma Royal Sanur',
                            tag: 'Bali, Indonesia',
                            showArrow: false,
                          ),
                          const TimelineStyleTitles(
                            title: 'Karma Rottnest',
                            tag: 'Rottnest Island, WA',
                            showArrow: false,
                          ),
                        ],
                      ),
                      rightWidget: Wrap(
                        runSpacing: 30,
                        alignment: WrapAlignment.center,
                        children: [
                          IconNumText(
                            icon: 'assets/images/kg-timeline/Icon_2.png',
                            number: '10',
                            text: data['GLOBAL AWARDS'][lang],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Miele_Guide.png'}',
                                height: 80,
                              ),
                              const SizedBox(width: 20),
                              Image.network(
                                '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/2011_South East Asia.png'}',
                                height: 80,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Wrap(
                                direction: Axis.vertical,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 10,
                                children: [
                                  Image.network(
                                    '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/John Spence.png'}',
                                    width: 120,
                                  ),
                                  Image.network(
                                    '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Perspectiv_Magazine_Awards_2012.png'}',
                                    width: 90,
                                  ),
                                ],
                              ),
                              Image.network(
                                '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/John Spence_2.png'}',
                                width: 140,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //2012
                    TimelineStyleNine(
                      topPadding: 150,
                      image: 'assets/images/kg-timeline/images/2012.png',
                      leftWidget: Stack(
                        children: [
                          Positioned(
                            child: TimelineStyleTitles(
                              status: data['opened'][lang],
                              title: 'Le Preverger',
                              tag: 'St Tropez, France',
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 50,
                            child: SizedBox(
                              width: 222,
                              child: IconNumText(
                                icon: 'assets/images/kg-timeline/Icon_1.png',
                                text: data['Opened Office in Jakarta'][lang],
                              ),
                            ),
                          )
                        ],
                      ),
                      rightWidget: Wrap(
                        runSpacing: 40,
                        children: [
                          IconNumText(
                            icon: 'assets/images/kg-timeline/Icon_2.png',
                            number: '14',
                            text: data['GLOBAL AWARDS'][lang],
                            padLeft: 0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Trip Advisor.png'}',
                                width: 80,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Wrap(
                                direction: Axis.vertical,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 20,
                                children: [
                                  Image.network(
                                    '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/John Spence.png'}',
                                    width: 130,
                                  ),
                                  Image.network(
                                    '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Perspectiv_Magazine_Awards_2012.png'}',
                                    width: 100,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //2013
                    TimelineStyleTen(
                      contentAlignment: CrossAxisAlignment.center,
                      leftWidget: Wrap(
                        runSpacing: 30,
                        children: [
                          TimelineStyleTitles(
                            status: data['opened'][lang],
                            title: 'Karma Chakra',
                            tag: 'Kerala India',
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2013.png'}'),
                          TimelineStyleTitles(
                            title: data['Royal Bali Beach Club at Seminyak']
                                [lang],
                            tag: 'BALI, INDONESIA',
                            showArrow: false,
                          ),
                        ],
                      ),
                      centerWidget: Wrap(
                        runSpacing: 50,
                        children: [
                          IconNumText(
                            icon: 'assets/images/kg-timeline/Icon_2.png',
                            number: '23',
                            text: data['GLOBAL AWARDS'][lang],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/FL Awards_2013.png'}',
                              width: 130,
                            ),
                          ),
                          IconNumText(
                            number: '2',
                            text: data['New Beach Clubs'][lang],
                            textStyle: const TextStyle(
                                fontSize: 24, fontFamily: 'Playfair'),
                            textPadding: const EdgeInsets.only(top: 6),
                            isUppercase: false,
                          ),
                          Transform.translate(
                            offset: const Offset(70, -55),
                            child: const Wrap(
                              children: [
                                CustomText(
                                  label: '- Karma Beach Fiji',
                                  isUppercase: true,
                                  type: 'sm',
                                  textStyle: TextStyle(color: AppColors.white),
                                ),
                                CustomText(
                                  label: '- Karma Beach Gili Meno',
                                  isUppercase: true,
                                  type: 'sm',
                                  textStyle: TextStyle(color: AppColors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      rightWidget: Wrap(
                        runSpacing: 30,
                        children: [
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/SNOOP_ADELIC.png'}',
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.secondary, width: 0.5)),
                            child: Row(
                              children: [
                                const CustomText(
                                  label: 'Yale',
                                  type: 'h4',
                                  isSerif: true,
                                  textStyle:
                                      TextStyle(color: AppColors.primary),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: CustomText(
                                    label: data['Yale'][lang],
                                    type: 'xs',
                                    textStyle:
                                        const TextStyle(color: AppColors.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    //2014
                    TimelineStyleTen(
                      contentAlignment: CrossAxisAlignment.center,
                      leftWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          TimelineStyleTitles(
                            status: data['opened'][lang],
                            title: 'Karma St. Martin’s',
                            tag: 'Isles of Scilly, UK',
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2014.jpg'}'),
                          const TimelineStyleTitles(
                            title: 'Royal Villea Village',
                            tag: 'Crete, greece',
                            showArrow: false,
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.secondary, width: 0.5)),
                            child: CustomText(
                              label: data['Planning Karma Bahamas'][lang],
                              type: 'sm',
                              isUppercase: true,
                              textAlign: TextAlign.center,
                              textStyle:
                                  const TextStyle(color: AppColors.white),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.secondary, width: 0.5)),
                            child: CustomText(
                              label: data['Planning Karma Beach Bahamas'][lang],
                              type: 'sm',
                              isUppercase: true,
                              textAlign: TextAlign.center,
                              textStyle:
                                  const TextStyle(color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                      centerWidget: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 30,
                        children: [
                          IconNumText(
                            icon: 'assets/images/kg-timeline/Icon_2.png',
                            number: '27',
                            text: data['GLOBAL AWARDS'][lang],
                            padLeft: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 30,
                              runSpacing: 30,
                              alignment: WrapAlignment.center,
                              children: [
                                Image.network(
                                  '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Conde Nast Traveler_Award.png'}',
                                  height: 80,
                                ),
                                Image.network(
                                  '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Hall of Fame.png'}',
                                  height: 90,
                                ),
                                Image.network(
                                  '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/World Travel Awards_2015.png'}',
                                  height: 80,
                                ),
                                Image.network(
                                  '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/RCI_Gold Crown.png'}',
                                  height: 80,
                                ),
                                Image.network(
                                  '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/The Sydney Morning herald.png'}',
                                  height: 40,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      rightWidget: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 30,
                          runSpacing: 30,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/RCI-20142015.png'}',
                              height: 60,
                            ),
                            Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Goa Food & Hospitality.png'}',
                              height: 90,
                            ),
                            Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/India Says YES.png'}',
                              height: 70,
                            ),
                            Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/CNN Travel.png'}',
                              height: 34,
                            ),
                          ],
                        ),
                      ),
                    ),
                    //2015
                    TimelineStyleTen(
                      topPadding: 100,
                      contentAlignment: CrossAxisAlignment.center,
                      leftWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          TimelineStyleTitles(
                            title: data['Re-branded'][lang],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Karma_Group.png'}',
                              height: 80,
                            ),
                          ),
                        ],
                      ),
                      centerWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          TimelineStyleTitles(
                            status: data['opened'][lang],
                            title: 'Karma Mayura',
                            tag: 'Bali, Indonesia',
                            showArrow: false,
                          ),
                          const TimelineStyleTitles(
                            title: 'Karma Reef Glamping',
                            tag: 'Gili Meno, Indonesia',
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2015.png'}'),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.secondary, width: 0.5)),
                            child: CustomText(
                              label: data['Sponsored'][lang],
                              type: 'sm',
                              isUppercase: true,
                              textAlign: TextAlign.center,
                              textStyle:
                                  const TextStyle(color: AppColors.white),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: CustomText(
                              label: data['Official Name Sponsor'][lang],
                              type: 'xs',
                              isUppercase: true,
                              textAlign: TextAlign.center,
                              textStyle:
                                  const TextStyle(color: AppColors.white),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Karma Resorts_rotnest chanel swim.png'}',
                              height: 70,
                            ),
                          ),
                        ],
                      ),
                      rightWidget: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 30,
                        children: [
                          Wrap(
                            spacing: 10,
                            children: [
                              SizedBox(
                                width: 220,
                                child: IconNumText(
                                  icon: 'assets/images/kg-timeline/Icon_2.png',
                                  number: '26',
                                  text: data['GLOBAL AWARDS'][lang],
                                  padLeft: 0,
                                ),
                              ),
                              Image.network(
                                '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Conde Nast Traveler_Award.png'}',
                                height: 40,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Image.network(
                                    '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/John Spence_UCLA.png'}',
                                    height: 100,
                                  ),
                                ),
                                Image.network(
                                  '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/John Spence_3.png'}',
                                  height: 150,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //2016
                    TimelineStyleTen(
                      contentAlignment: CrossAxisAlignment.center,
                      leftWidget: Wrap(
                        runSpacing: 40,
                        children: [
                          const TimelineStyleTitles(
                            title: 'Joint Venture',
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Karma Sanctum.png'}',
                                height: 50,
                              ),
                              const SizedBox(width: 20),
                              Image.network(
                                '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/IRON_MAIDEN.png'}',
                                height: 50,
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.secondary, width: 0.5)),
                            child: CustomText(
                              label: data['Sponsored'][lang],
                              type: 'sm',
                              isUppercase: true,
                              textAlign: TextAlign.center,
                              textStyle:
                                  const TextStyle(color: AppColors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      CustomText(
                                        label: data['Official Name Sponsor']
                                            [lang],
                                        type: 'xs',
                                        textAlign: TextAlign.center,
                                        textStyle: const TextStyle(
                                            color: AppColors.white),
                                      ),
                                      const SizedBox(height: 20),
                                      Image.network(
                                        '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Karma Resorts_rotnest chanel swim.png'}',
                                        height: 60,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      CustomText(
                                        label: data['Official Resort Partner']
                                            [lang],
                                        type: 'xs',
                                        textAlign: TextAlign.center,
                                        textStyle: const TextStyle(
                                            color: AppColors.white),
                                      ),
                                      const SizedBox(height: 20),
                                      Image.network(
                                        '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Official Resort Partner.png'}',
                                        height: 60,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      centerWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          TimelineStyleTitles(
                            status: data['opened'][lang],
                            title: 'Karma Cây Tre',
                            tag: 'Vietnam',
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2016.png'}'),
                        ],
                      ),
                      rightWidget: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 30,
                        runSpacing: 30,
                        children: [
                          IconNumText(
                            icon: 'assets/images/kg-timeline/Icon_2.png',
                            number: '15',
                            text: data['GLOBAL AWARDS'][lang],
                            padLeft: 0,
                          ),
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Bali_Tourism Awatds.png'}',
                            height: 100,
                          ),
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Indonesia_travel & Tourism Awards.png'}',
                            height: 100,
                          ),
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Tourism Excellence Awards.png'}',
                            height: 100,
                          ),
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Cornwell Tourism Awards-201617.png'}',
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                    //2017
                    TimelineStyleTen(
                      contentAlignment: CrossAxisAlignment.center,
                      leftWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          TimelineStyleTitles(
                            status: data['opened'][lang],
                            title: 'Karma Sanctum Soho',
                            tag: 'London, UK',
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2017_1.png'}'),
                          Wrap(
                            spacing: 5,
                            children: [
                              SizedBox(
                                width: 220,
                                child: IconNumText(
                                  icon: 'assets/images/kg-timeline/Icon_2.png',
                                  number: '18',
                                  text: data['GLOBAL AWARDS'][lang],
                                  padLeft: 0,
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(10, 10),
                                child: Image.network(
                                  '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/World_luxury_Hotel_Awards.png'}',
                                  height: 50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      centerWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          const TimelineStyleTitles(
                            title: '',
                            tag: 'Official resort \npartner',
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2017_2.png'}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 30),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.secondary,
                                          width: 0.5)),
                                  child: CustomText(
                                    label: data['Launched Karma Wines'][lang],
                                    type: 'sm',
                                    isUppercase: true,
                                    textStyle:
                                        const TextStyle(color: AppColors.white),
                                  ),
                                ),
                              ),
                              Image.network(
                                '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2017_4.png'}',
                                width: 130,
                              ),
                            ],
                          ),
                        ],
                      ),
                      rightWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          TimelineStyleTitles(
                            title: '',
                            tag: data['F1 Podium lounge Singapore'][lang],
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2017_3.png'}'),
                        ],
                      ),
                    ),
                    //2018
                    TimelineStyleTen(
                      topPadding: 80,
                      contentAlignment: CrossAxisAlignment.center,
                      leftWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          TimelineStyleTitles(
                            status: data['opened'][lang],
                            title: 'Karma Résidence \nNormande',
                            tag: 'Crete, Greece',
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2018_1.png'}'),
                          const TimelineStyleTitles(
                            title: 'Karma Manoir des \ndeux Amants',
                            tag: 'Normandy, France',
                            showArrow: false,
                          ),
                        ],
                      ),
                      centerWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          const TimelineStyleTitles(
                            title: 'Karma Eotica',
                            tag: 'Dharamshala, India',
                            showArrow: false,
                          ),
                          const TimelineStyleTitles(
                            title: 'Karma Chang',
                            tag: 'Chiang Mai, ThaiLand',
                            showArrow: false,
                          ),
                          const TimelineStyleTitles(
                            title: 'Karma Borgo \ndi Colleoli',
                            tag: 'Tuscany, Italy',
                            showArrow: false,
                          ),
                          const TimelineStyleTitles(
                            title: 'Karma Minoan',
                            tag: 'Crete, Greece',
                            showArrow: false,
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2018_2.png'}'),
                        ],
                      ),
                      rightWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          const TimelineStyleTitles(
                            title: 'Karma Palacio Elefante',
                            tag: 'Goa, India',
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2018_3.png'}'),
                          const TimelineStyleTitles(
                            title: 'Karma Sanctum \non the Green',
                            tag: 'Cookham Dean, UK',
                            showArrow: false,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: IconNumText(
                              icon: 'assets/images/kg-timeline/Icon_2.png',
                              number: '31',
                              text: data['GLOBAL AWARDS'][lang],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Image.network(
                                      '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Perspective_Magazine_Awards_2018.png'}'),
                                ),
                                const SizedBox(width: 30),
                                Expanded(
                                  child: Image.network(
                                      '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Perspective_Magazine_Awards_2018_john.png'}'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    //2019
                    TimelineStyleNine(
                      image: 'assets/images/kg-timeline/images/2019.png',
                      leftWidget: Stack(
                        children: [
                          Positioned(
                            bottom: 220,
                            child: TimelineStyleTitles(
                              status: data['opened'][lang],
                              title: 'Karma Sitabani',
                              tag: 'Corbett National Park, India',
                            ),
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 100,
                            child: TimelineStyleTitles(
                              title: 'Karma Apsara',
                              tag: 'Koh Samui, Thailand',
                              showArrow: false,
                            ),
                          )
                        ],
                      ),
                      rightWidget: Wrap(
                        runSpacing: 40,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          IconNumText(
                            icon: 'assets/images/kg-timeline/Icon_2.png',
                            number: '31',
                            text: data['GLOBAL AWARDS'][lang],
                            padLeft: 0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/John Spence_4.png'}',
                                width: 120,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Wrap(
                                direction: Axis.vertical,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 20,
                                children: [
                                  Image.network(
                                    '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/John Spence.png'}',
                                    width: 130,
                                  ),
                                  Image.network(
                                    '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Perspective_Magazine_Awards_2019.png'}',
                                    width: 100,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //2020
                    TimelineStyleEleven(
                      contentAlignment: CrossAxisAlignment.center,
                      leftWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          TimelineStyleTitles(
                            status: data['opened'][lang],
                            title: 'Karma Salford Hall',
                            tag: 'THE Vale of Evesham, UK',
                          ),
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2020.png'}',
                          ),
                          const Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TimelineStyleTitles(
                                  title: 'Karma Sunshine Village',
                                  tag: 'Bangalore, India',
                                  showArrow: false,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TimelineStyleTitles(
                                  title: 'Karma Salak ',
                                  tag: 'West Java, Indonesia',
                                  showArrow: false,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      rightWidget: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 40,
                        runSpacing: 20,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 10,
                            children: [
                              SizedBox(
                                width: 220,
                                child: IconNumText(
                                  icon: 'assets/images/kg-timeline/Icon_2.png',
                                  number: '04',
                                  text: data['GLOBAL AWARDS'][lang],
                                  padLeft: 0,
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(0, -6),
                                child: Image.network(
                                  '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/2020_Winner.png'}',
                                  height: 46,
                                ),
                              ),
                            ],
                          ),
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/ARDA_color.png'}',
                            height: 80,
                          ),
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Top_50_Beachfront.png'}',
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                    //2021
                    TimelineStyleEleven(
                      contentAlignment: CrossAxisAlignment.center,
                      leftWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          Wrap(
                            children: [
                              TimelineStyleTitles(
                                status: data['opened'][lang],
                                title: 'Karma Golden Camp',
                                tag: 'Jaisalmer, India',
                              ),
                              Transform.translate(
                                offset: const Offset(0, -10),
                                child: Image.network(
                                  '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2021.png'}',
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Wrap(
                                  runSpacing: 20,
                                  children: [
                                    TimelineStyleTitles(
                                      title: 'Karma Seven Lakes',
                                      tag: 'Udaipur, India',
                                      showArrow: false,
                                    ),
                                    TimelineStyleTitles(
                                      title: 'Karma Song Hoai',
                                      tag:
                                          'Hoi An, Vietnam \nyogyakarta, Indonesia',
                                      showArrow: false,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Wrap(
                                  runSpacing: 20,
                                  children: [
                                    TimelineStyleTitles(
                                      title: 'Karma Merapi',
                                      tag: 'yogyakarta, Indonesia',
                                      showArrow: false,
                                    ),
                                    TimelineStyleTitles(
                                      title: 'Karma Song Hoai',
                                      tag: 'Hoi An, Vietnam',
                                      showArrow: false,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      rightWidget: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          IconNumText(
                            icon: 'assets/images/kg-timeline/Icon_2.png',
                            number: '25',
                            text: data['GLOBAL AWARDS'][lang],
                            padLeft: 0,
                          ),
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Perspectiv_Magazine_Awards_2012.png'}',
                            height: 60,
                          ),
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/John Spence.png'}',
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    //2022
                    TimelineStyleEleven(
                      contentAlignment: CrossAxisAlignment.center,
                      leftWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          TimelineStyleTitles(
                            status: data['opened'][lang],
                            title: 'Karma Karnak',
                            tag: 'Luxor, Egypt',
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 220,
                            child: Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2022_1.png'}',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Wrap(
                                  runSpacing: 20,
                                  children: [
                                    TimelineStyleTitles(
                                      title: 'Karma La Herriza ',
                                      tag: 'Gaucin, Spain',
                                      showArrow: false,
                                    ),
                                    TimelineStyleTitles(
                                      title: 'Karma Chateau \nde Samary',
                                      tag: 'Carcassonne, france',
                                      showArrow: false,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Wrap(
                                  runSpacing: 20,
                                  children: [
                                    TimelineStyleTitles(
                                      title: 'Karma Lake \nof Menteith',
                                      tag: 'Scotland, UK',
                                      showArrow: false,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      rightWidget: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 40,
                        children: [
                          IconNumText(
                            icon: 'assets/images/kg-timeline/Icon_2.png',
                            number: '13',
                            text: data['GLOBAL AWARDS'][lang],
                            padLeft: 0,
                          ),
                          const TimelineStyleTitles(
                            title: 'Karma Munnar',
                            tag: 'Kerala, India',
                          ),
                          Image.network(
                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2022_2.png'}',
                          ),
                        ],
                      ),
                    ),
                    //2023
                    TimelineStyleTen(
                      contentAlignment: CrossAxisAlignment.center,
                      leftWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          TimelineStyleTitles(
                            status: data['opened'][lang],
                            title: 'Karma Martam Retreat ',
                            tag: 'Gangtok, India',
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2023_1.png'}'),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: IconNumText(
                              icon: 'assets/images/kg-timeline/Icon_2.png',
                              number: '30',
                              text: data['GLOBAL AWARDS'][lang],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Wrap(
                              children: [
                                Image.network(
                                  '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/Awards_1.png'}',
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      centerWidget: Wrap(
                        runSpacing: 20,
                        alignment: WrapAlignment.end,
                        children: [
                           TimelineStyleTitles(
                            status: data['opened'][lang],
                            title: 'Karma Sobek',
                            tag: 'Sharm El-Sheikh, Egypt',
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2023_2.png'}'),
                           Padding(
                             padding: const EdgeInsets.only(top: 10.0),
                             child: TimelineStyleTitles(
                              status: data['opened'][lang],
                              title: 'Mentari Residences',
                              tag: 'Bali, Indonesia',
                              showArrow: true,
                                                       ),
                           ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2023_3.png'}'),
                        ],
                      ),
                      rightWidget: Wrap(
                        runSpacing: 20,
                        children: [
                          TimelineStyleTitles(
                            status: data['opened'][lang],
                            title: 'Karma Utopia',
                            tag: 'Manali, India',
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2023_4.png'}'),
                        ],
                      ),
                    ),
                    //2024
                    TimelineStyleTwelve(
                     contentAlignment: CrossAxisAlignment.center,
                      leftWidget: Wrap(
                        runSpacing: 30,
                        children: [
                          TimelineStyleTitles(
                            status: data['opened'][lang],
                            title: 'Karma Bayon',
                            tag: 'Siem Reap, Cambodia',
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2024_1.png'}'),
                        ],
                      ),
                      rightWidget: SingleChildScrollView(
                        child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Wrap(
                                    children: [
                                      TimelineStyleTitles(
                                        status: data['opened'][lang],
                                        title: 'Karma Fushi',
                                        tag: 'Maldives',
                                      ),
                                      Image.network(
                                          '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2024_2.png'}'),

                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child:  Column(
                                    children: [
                                      Container(
                                        padding:
                                        const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.primary,
                                                width: 0.5)),
                                        child: CustomText(
                                          label: data[
                                          'Global Charity Auction Sponsorships']
                                          [lang],
                                          type: 'sm',
                                          textStyle:
                                          const TextStyle(color: AppColors.white),
                                        ),
                                      ),
                                      Image.network(
                                        '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/VU Limited .png'}',
                                        width: 120,
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(top: 20.0,bottom: 20),
                                        child: TimelineStyleTitles(
                                          status: data['opened'][lang],
                                          title: 'Karma Lakewood',
                                          tag: 'Mahabaleshwar, India',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 20,
                                      children: [
                                        SizedBox(
                                          width: 260,
                                          child: IconNumText(
                                            icon: 'assets/images/kg-timeline/Icon_2.png',
                                            number: '38',
                                            text: data['GLOBAL AWARDS'][lang],
                                            padLeft: 0,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 0.0),
                                          child: Transform.translate(
                                            offset: const Offset(10, 10),
                                            child: Image.network(
                                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/Awards2024_2.png'}',
                                              height: 60,
                                            ),
                                          ),
                                        ),
                                        Transform.translate(
                                          offset: const Offset(10, 10),
                                          child: Image.network(
                                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/Awards2024_3.png'}',
                                            height: 60,
                                          ),
                                        ),
                                        Transform.translate(
                                          offset: const Offset(10, 10),
                                          child: Image.network(
                                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/Awards2024_4.png'}',
                                            height: 60,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Wrap(
                                      runSpacing: 30,
                                      children: [
                                        Image.network(
                                            '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2024_3.png'}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    //2025
                    TimelineStyleTwelve(
                      topPadding: 100,
                      leftWidget: Wrap(
                        runSpacing: 30,
                        children: [
                          TimelineStyleTitles(
                            status: data['opened'][lang],
                            year: '- JAN 2025',
                            title: 'Karma Panalee',
                            tag: 'Koh Samui , Thailand',
                            showArrow: true,
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2025_1.png'}'),
                          const TimelineStyleTitles(
                            title: 'Karma two palms Beach',
                            tag: 'Koh Samui , Thailand',
                            showArrow: true,
                          ),
                          Image.network(
                              '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2025_2.png'}'),
                        ],
                      ),
                      rightWidget:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                // flex: 1,
                                child: Wrap(
                                  runSpacing: 30,
                                  children: [
                                    TimelineStyleTitles(
                                      status: data['opened'][lang],
                                      title: 'Karma Tashi',
                                      tag: 'dharamshala, india',
                                    ),
                                    Image.network(
                                        '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2025_3.png'}'),
                                  ],
                                ),
                              ),
                              Expanded(
                                // flex: 1,
                                child: Wrap(
                                  runSpacing: 30,
                                  children: [
                                    TimelineStyleTitles(
                                      status: data['Launched'][lang],
                                      title: 'Karma Subito App',
                                      showArrow: false,
                                    ),
                                    Image.network(
                                        '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/2025_4.png'}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 80),
                                child: Container()
                              ),
                              Positioned(
                                top: 30,
                                right: 30,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 5,
                                  children: [
                                    SizedBox(
                                      width: 220,
                                      child: IconNumText(
                                        icon: 'assets/images/kg-timeline/Icon_2.png',
                                        number: '14',
                                        text: data['GLOBAL AWARDS'][lang],
                                        padLeft: 0,
                                      ),
                                    ),
                                    Image.network(
                                      '${AppAPI.baseUrlGcp}${'assets/images/kg-timeline/images/World_Hotel_Awards2025.png'}',
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //2026
                    TimelineStyleTwelve(
                      topPadding: 180,
                      contentAlignment: CrossAxisAlignment.start,
                      leftWidget: const Wrap(
                        runSpacing: 10,
                        children: [
                          TimelineStyleTitles(
                            status: 'FUTURE DESTINATIONS',
                            showArrow: false,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: TimelineStyleTitles(
                              title: 'Australia',
                              showArrow: false,
                            ),
                          ),
                          TimelineStyleTitles(
                            title: 'Brazil',
                            showArrow: false,
                          ),
                          TimelineStyleTitles(
                            title: 'Japan',
                            showArrow: false,
                          ),
                          TimelineStyleTitles(
                            title: 'Philippines',
                            showArrow: false,
                          ),
                          TimelineStyleTitles(
                            title: 'Sri Lanka',
                            showArrow: false,
                          ),
                        ],
                      ),
                      rightWidget:
                     Container()
                    )
                  ],
                ),
                Positioned(
                  bottom: 80,
                  left: 0,
                  right: 0,
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 100,vertical: 20),
                      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              left: _currentIndex * 63,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                              child: SvgPicture.asset(
                                'assets/images/kg-timeline/timeline_thumb.svg',
                                width: 44,
                                fit: BoxFit.contain,
                                semanticsLabel: 'calendar',
                                placeholderBuilder: (context) =>
                                    const LoadingComponent(),
                              ),
                            ),
                            Row(
                              children: [
                                for (int i in years)
                                  Wrap(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _pageController.animateToPage(
                                              i - 1993,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.ease);
                                          setState(() {
                                            _currentYear = i;
                                            _currentIndex = i - 1993;
                                          });
                                        },
                                        child: CustomThumbShape(
                                          label: i.toString(),
                                          isActive: i == _currentIndex + 1993,
                                        ),
                                      ),
                                      if (i != years.last)
                                        Container(
                                          width: 1,
                                          height: 30,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.fromLTRB(
                                              9, 15, 9, 14),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColors.primary
                                                    .withValues(alpha: 0),
                                                AppColors.primary
                                                    .withValues(alpha: 0.4),
                                                AppColors.primary
                                                    .withValues(alpha: 0),
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              stops: const [0.1, 0.5, 1],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                              ],
                            )
                          ],
                        ),
                      )),
                ),

              ],
            ),
    );
  }
}

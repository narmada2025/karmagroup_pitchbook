import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF8D7249);
  static const Color secondary = Color(0xFFB19975);
  static const Color variation1 = Color(0xFFC9A46D);
  static const Color light = Color.fromARGB(255, 226, 205, 172);
  static const Color dark = Color(0xFF483b2a);
  static const Color darker = Color(0xff231C10);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color gray = Color(0xFF2a2a2a);
  static const Color gray2 = Color(0xFF232323);
  static const Color lightGray = Color(0xFFcdcdcd);
  static const Color ultraLightGray = Color(0xFFf7f7f7);
  static const Color disabled = Color.fromARGB(255, 173, 173, 173);
  static const Color tableGoldenLight = Color(0xFFb7a388);
  static const Color tableGoldenLight2 = Color(0xFFa18f75);
  static const Color tableGreen = Color(0xFFa1c298);
  static const Color tableGreen2 = Color.fromARGB(255, 133, 160, 125);
  static const Color tablePurple = Color(0xFFa898c0);
  static const Color tablePurple2 = Color(0xFF8979a2);
  static const Color tableGray = Color(0xFFbabbbe);
  static const Color tableGray2 = Color(0xFFaaabb1);
}

class TextSize {
  static double get xlg => 96;
  static double get xmd => 80;
  static double get xsm => 70;
  static double get h1 => 60;
  static double get h2 => 50;
  static double get h3 => 40;
  static double get h3n => 36;
  static double get h4 => 30;
  static double get h5 => 26;
  static double get h6 => 24;
  static double get lg => 20;
  static double get md => 18;
  static double get sm => 14;
  static double get xs => 12;
  static double get def => 16;
}

class TextHeight {
  static double get xlg => 1.2;
  static double get xmd => 1;
  static double get xsm => 1;
  static double get h1 => 1.1;
  static double get h2 => 1;
  static double get h3 => 1.1;
  static double get h3n => 1.1;
  static double get h4 => 1.2;
  static double get h5 => 1.1;
  static double get h6 => 1.3;
  static double get lg => 1.3;
  static double get md => 1.3;
  static double get sm => 1.2;
  static double get xs => 1.2;
  static double get def => 1.5;
}

class AppIcons {
  static String get menuIcon => 'assets/interface/menu.svg';
  static String get thumbJpg => 'assets/images/thumb.jpg';
  static String get thumbSvg => 'assets/images/thumb.svg';
  static String get menuLongPathIcon => 'assets/interface/menuPathLong.svg';
  static String get menuShortPathIcon => 'assets/interface/menuPathShort.svg';
  static String get logo => 'assets/images/logo.svg';
  static String get calendarIcon => 'assets/icons/calendar.svg';
  static String get diamondIcon => 'assets/icons/Diamond.svg';
  static String get backArrowWhite => 'assets/icons/back-arrow-round-white.svg';
  static String get backArrowBlack => 'assets/icons/back-arrow-round-back.svg';
  static String get arrowTopRightIcon =>
      'assets/icons/Icon-arrow-top-right.svg';
  static String get goldDownwordArrowIcon =>
      'assets/icons/gold_downword_arrow.svg';
  static String get imageIcon => 'assets/icons/image.svg';
  static String get invertedQuamaUpIcon => 'assets/icons/inverted_quama_up.svg';
  static String get invertedQuamaDownIcon =>
      'assets/icons/inverted_quama_down.svg';
  static String get quoteIcon => 'assets/icons/quote.svg';
  static String get kdLocationIcon => 'assets/icons/Location.svg';
  static String get squareIcon => 'assets/icons/square.svg';
  static String get squareOutlinedIcon => 'assets/icons/square_outlined.svg';
  static String get vrIcon => 'assets/icons/vr.svg';
  static String get playIcon => 'assets/icons/play.svg';
  static String get downArrowRoundedBorder =>
      'assets/icons/Down_Arrow_Rounded_Border.svg';
  static String get person => 'assets/icons/person.svg';
  static String get chevLeft => 'assets/icons/chev_left.svg';
  static String get chevDown => 'assets/icons/chev_down.svg';
  static String get notch => 'assets/icons/top_notch.svg';
  static String get sold => 'assets/icons/sold_out.png';
}

class AppAPI {
  static String get baseUrlGcp => 'https://storage.googleapis.com/karmapitchbook/karmapitchbookimages/';
  static String get global => 'assets/json/global.json';
  static String get home => 'assets/json/home.json';
  static String get destinations => 'assets/json/destinations.json';
  static String get philanthropy => 'assets/json/philanthropy.json';
  static String get awards => 'assets/json/awards.json';
  static String get karmaClub => 'assets/json/karma_club.json';
  static String get partnerships => 'assets/json/partnership.json';
  static String get reciprocalPartnerships =>
      'assets/json/reciprocal-partnership.json';
  static String get community => 'assets/json/community.json';
  static String get moments => 'assets/json/moments.json';
  static String get goodKarma => 'assets/json/good-karma.json';
  static String get faq => 'assets/json/faq.json';
  static String get pointsTable => 'assets/json/points-table.json';
  static String get timeline => 'assets/json/timeline.json';
  static String get fractionalOwnership =>
      'assets/json/fractional-ownership.json';
  static String get chairmanSessionFeaturedStories =>
      // 'https://karmacommunity.karmagroup.com/wp-json/community/v1/articles';
      'https://karmacommunity.karmagroup.com/wp-json/community/v1/articles?v=2';
  static String get events =>
      'https://karmagroup.com/wp-json/curated-events/v1/events/';
  static String get eventGallery =>
      'https://karmagroup.com/wp-json/curated-events/v1/gallery/';
  static String get press =>
      'https://karmagroup.com/wp-json/karmagroup/v1/press/';
}

class AppShape {
  static String get topNotchCenteredRounded =>
      'assets/images/top_notch_center_rounded.svg';
}

import 'package:flutter/material.dart';
import 'package:pitchbook/src/karma_timeline/karma_timeline_screen.dart';
import 'package:pitchbook/src/login_screen.dart';
import 'package:pitchbook/src/qualification/our_goals.dart';
import 'package:pitchbook/src/qualification/re_visit_screen.dart';

import '../src/accolades/accolades_screen.dart';
import '../src/community/community_screen.dart';
import '../src/destinations/destinations_accommodation_widget.dart';
import '../src/destinations/destinations_facilities_widget.dart';
import '../src/destinations/destinations_gallery_widget.dart';
import '../src/destinations/destinations_guest_exp_widget.dart';
import '../src/destinations/destinations_property_screen.dart';
import '../src/destinations/destinations_screen.dart';
import '../src/destinations/destinations_videos_widget.dart';
import '../src/destinations/destinations_virtual_experience_widget.dart';
import '../src/faqs/faqs_screen.dart';
import '../src/good_karma/good_karma_screen.dart';
import '../src/home/home_screen.dart';
import '../src/karma_club/karma_club_fractional_ownership_screen.dart';
import '../src/karma_club/karma_club_screen.dart';
import '../src/partnerships/partnerships_screen.dart';
import '../src/partnerships_reciprocal/partnerships_reciprocal_screen.dart';
import '../src/philanthropy/philanthropy_screen.dart';
import '../src/points_table/points_table_screen.dart';

class AppRoutes {
  static List<Widget> getPages() {
    return [
      Navigator(
        key: GlobalKey<NavigatorState>(),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
            case '/home':
              return MaterialPageRoute(
                  builder: (context) => const HomeScreen());
            default:
              return null;
          }
        },
      ),
      Navigator(
        key: GlobalKey<NavigatorState>(),
        initialRoute: '/destinations',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/destinations':
              return MaterialPageRoute(
                  builder: (context) => const DestinationsScreen());
            case '/destination-gallery':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                  builder: (context) => DestinationsGalleryWidget(args));
            case '/destination-videos':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                  builder: (_) => DestinationsVideoWidget(args));
            case '/destination-virtual-exp':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                  builder: (_) => DestinationsVirtualExpWidget(args));

            case '/destination-property':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                  builder: (_) => DestinationsPropertyScreen(args));

            case '/destination-accommodation':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                  builder: (_) => DestinationsAccommodationWidget(args));

            case '/destination-facilities':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                  builder: (_) => DestinationsFacilitiesWidget(args));

            case '/destination-guest-exp':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                  builder: (_) => DestinationsGuestExpWidget(args));

            default:
              return null;
          }
        },
      ),
      Navigator(
        key: GlobalKey<NavigatorState>(),
        initialRoute: '/accolades',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/accolades':
              return MaterialPageRoute(
                  builder: (context) => const AccoladesScreen());
            default:
              return null;
          }
        },
      ),
      Navigator(
        key: GlobalKey<NavigatorState>(),
        initialRoute: '/karma-club',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/karma-club':
              return MaterialPageRoute(builder: (_) => const KarmaClubScreen());
            case '/fractional-ownership':
              return MaterialPageRoute(
                  builder: (_) => const KarmaClubFractionalOwnershipScreen());
            case '/reciprocal-partnerships':
              return MaterialPageRoute(
                  builder: (_) => const PartnershipsReciprocalScreen());
            case '/points-table-tab':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                  builder: (context) => PointsTableScreen(args));
            case '/faqs':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(builder: (context) => FaqsScreen(args));
            default:
              return null;
          }
        },
      ),
      Navigator(
        key: GlobalKey<NavigatorState>(),
        initialRoute: '/philanthropy',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/philanthropy':
              return MaterialPageRoute(
                  builder: (_) => const PhilanthropyScreen());
            default:
              return null;
          }
        },
      ),
      Navigator(
        key: GlobalKey<NavigatorState>(),
        initialRoute: '/partnerships',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/partnerships':
              return MaterialPageRoute(
                  builder: (_) => const PartnershipsScreen());

            case '/reciprocal-partnerships':
              return MaterialPageRoute(
                  builder: (_) => const PartnershipsReciprocalScreen());
            default:
              return null;
          }
        },
      ),
      Navigator(
        key: GlobalKey<NavigatorState>(),
        initialRoute: '/community',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/community':
              return MaterialPageRoute(builder: (_) => const CommunityScreen());
            default:
              return null;
          }
        },
      ),
      Navigator(
        key: GlobalKey<NavigatorState>(),
        initialRoute: '/karma-timeline',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/karma-timeline':
              return MaterialPageRoute(
                  builder: (_) => const KarmaTimelineScreen());
            default:
              return null;
          }
        },
      ),
      // Navigator(
      //   key: GlobalKey<NavigatorState>(),
      //   initialRoute: '/faqs',
      //   onGenerateRoute: (settings) {
      //     switch (settings.name) {
      //       case '/faqs':
      //         final args = {'showBack': false};
      //         return MaterialPageRoute(builder: (context) => FaqsScreen(args));
      //       default:
      //         return null;
      //     }
      //   },
      // ),
      Navigator(
        key: GlobalKey<NavigatorState>(),
        initialRoute: '/qualification',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/qualification':
              return MaterialPageRoute(builder: (_) => const ReVisitVietnamTab());
            case '/our-goals':
              // final args = {'showBack': true};
              return MaterialPageRoute(builder: (_) => const OurGoalsPage());
            default:
              return null;
          }
        },
      ),
      Navigator(
        key: GlobalKey<NavigatorState>(),
        initialRoute: '/points-table',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/points-table':
              final args = {'setTab': '0', 'showBack': false};
              return MaterialPageRoute(
                  builder: (context) => PointsTableScreen(args));
            default:
              return null;
          }
        },
      ),
      Navigator(
        key: GlobalKey<NavigatorState>(),
        initialRoute: '/good-karma',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/good-karma':
              return MaterialPageRoute(builder: (_) => const GoodKarmaScreen());
            default:
              return null;
          }
        },
      ),
      Navigator(
        key: GlobalKey<NavigatorState>(),
        initialRoute: '/login',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(
                  builder: (context) => const LoginScreen());
            default:
              return null;
          }
        },
      ),

    ];
  }
}

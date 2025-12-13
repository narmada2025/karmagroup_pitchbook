import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pitchbook/components/error_alert.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_bottom_sheet.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/main.dart';
import 'package:pitchbook/shapes/shape_waterdrop_top.dart';
import 'package:pitchbook/src/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> with WidgetsBindingObserver {
  int _currentIndex = 0;
  late List<GlobalKey<NavigatorState>> _navigatorKeys;
  late List<Widget> _pages;

  bool isExapanded = false;
  String _selectedLang = 'en';
  late Future<void> _stateLoaded;

  @override
  void initState() {
    super.initState();
    _pages = AppRoutes.getPages();
    _navigatorKeys = _pages
        .whereType<Navigator>()
        .map((page) => page.key as GlobalKey<NavigatorState>)
        .toList();

    WidgetsBinding.instance.addObserver(this);
    _stateLoaded = _loadState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     _loadState();
  //   }
  // }

  Future<void> _loadState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedIndex = prefs.getInt('currentIndex') ?? 0;
    String savedLang = prefs.getString('selectedLang') ?? 'en';
    setState(() {
      _currentIndex = savedIndex;
      _selectedLang = savedLang;
      _changeLang(context, _selectedLang, saveState: false);
    });
  }

  Future<void> _saveState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentIndex', _currentIndex);
    await prefs.setString('selectedLang', _selectedLang);
  }

  void _navigateBottomBar(int index, String routeName) {
    if (index >= 0 && index < _pages.length) {
      setState(() {
        _currentIndex = index;
        isExapanded = false;
      });
      _saveState();
      _navigatorKeys[_currentIndex].currentState?.pushNamed(routeName);
    } else {
      ErrorAlert errorAlert = const ErrorAlert(error: 'Index out of bounds');
      errorAlert.showErrorDialog(context);
    }
  }

  void _changeLang(BuildContext context, String lang, {bool saveState = true}) {
    _selectedLang = lang;
    Locale newLocale;
    switch (lang) {
      case 'id':
        newLocale = Locale(lang, 'ID');
        break;
      case 'de':
        newLocale = Locale(lang, 'DE');
        break;
      case 'fr':
        newLocale = Locale(lang, 'FR');
        break;
      default:
        newLocale = const Locale('en', 'US');
    }
    MyApp.setLocale(context, newLocale);
    if (saveState) _saveState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<void>(
      future: _stateLoaded,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: LoadingComponent(),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  _pages[_currentIndex],
                  AnimatedPositioned(
                    curve: Curves.decelerate,
                    duration: const Duration(milliseconds: 400),
                    bottom: isExapanded ? 0 : -290,
                    left: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExapanded = !isExapanded;
                            });
                          },
                          onPanUpdate: (details) {
                            setState(() {
                              isExapanded = details.delta.dy < 0;
                            });
                          },
                          child: Container(
                            width: size.width,
                            height: isExapanded ? size.height : 40,
                            color: isExapanded
                                ? AppColors.black.withValues(alpha: .5)
                                : Colors.transparent,
                            alignment: Alignment.bottomRight,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 160,
                                  height: 36,
                                  child: CustomPaint(
                                    painter: ShapeWaterdropTop(),
                                  ),
                                ),
                                AnimatedRotation(
                                  turns: isExapanded ? -0.25 : 0.25,
                                  duration: const Duration(milliseconds: 300),
                                  child: const Icon(
                                    Icons.chevron_left_rounded,
                                    size: 36,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                         Padding(
                           padding: EdgeInsets.only(
                             // bottom: Platform.isAndroid ? 60 : MediaQuery.of(context).viewInsets.bottom,
                             bottom: Platform.isAndroid ? 60 : 20
                           ),
                           child: Material(
                              elevation: 8,
                              color: Colors.transparent,
                              child: CustomBottomSheet(
                                onSelectIndex: _navigateBottomBar,
                                onLangChange: (lang) => _changeLang(context, lang),
                              ),
                            ),
                         ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Error loading state'),
            ),
          );
        }
      },
    );
  }
}

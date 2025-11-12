import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/menu_item.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/app_locatizations.dart';

class CustomBottomSheet extends StatefulWidget {
  final Function(int, String) onSelectIndex;
  final ValueChanged<String>? onLangChange;

  const CustomBottomSheet({
    required this.onSelectIndex,
    this.onLangChange,
    super.key,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  String _selectedLanguage = 'en';
  Map<String, dynamic> menus = {};

  void _goToPage(int index, String label) {
    widget.onSelectIndex(index, label);
  }

  void _langChange(String lang) {
    widget.onLangChange!(lang);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Locale locale = Localizations.localeOf(context);
    String lang = locale.languageCode;

    if (_selectedLanguage != lang) {
      _selectedLanguage = lang;
    }

    final List<DropdownMenuItem<String>> languageItems = [
      const DropdownMenuItem(value: 'en', child: Text('EN')),
      const DropdownMenuItem(value: 'de', child: Text('DE')),
      const DropdownMenuItem(value: 'fr', child: Text('FR')),
      const DropdownMenuItem(value: 'id', child: Text('ID')),
    ];

    return Container(
      width: size.width,
      height: 320,
      color: AppColors.dark,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 75,
            child: Container(
              width: size.width,
              height: 1,
              decoration: const BoxDecoration(color: AppColors.secondary),
            ),
          ),
          Positioned(
            top: 0,
            child: SizedBox(
              width: size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MenuItem(
                          label: tr(context, 'menus.Home', lang),
                          svgPath: 'assets/interface/Home.svg',
                          btnSize: 70,
                          showPath: false,
                          onTap: () {
                            _goToPage(0, '/home');
                          }),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 35),
                        child: Wrap(
                          spacing: 10,
                          children: [
                            MenuItem(
                                label: tr(context, 'menus.Destinations', lang),
                                svgPath: 'assets/interface/Destinations.svg',
                                onTap: () {
                                  _goToPage(1, '/destinations');
                                }),
                            MenuItem(
                                label: tr(context, 'menus.Accolades', lang),
                                svgPath: 'assets/interface/Accolades.svg',
                                isShortPath: true,
                                onTap: () {
                                  _goToPage(2, '/accolades');
                                }),
                            MenuItem(
                                label: tr(context, 'menus.Karma Club', lang),
                                svgPath: 'assets/interface/Karma_Club.svg',
                                onTap: () {
                                  _goToPage(3, '/karma-club');
                                }),
                            MenuItem(
                                label: tr(context, 'menus.Philanthropy', lang),
                                svgPath: 'assets/interface/Philanthropy.svg',
                                isShortPath: true,
                                onTap: () {
                                  _goToPage(4, '/philanthropy');
                                }),
                            MenuItem(
                                label: tr(context, 'menus.Partnerships', lang),
                                svgPath: 'assets/interface/Partnerships.svg',
                                onTap: () {
                                  _goToPage(5, '/partnerships');
                                }),
                            MenuItem(
                                label: tr(context, 'Karma Curated', lang),
                                svgPath: 'assets/interface/Community.svg',
                                isShortPath: true,
                                onTap: () {
                                  _goToPage(6, '/community');
                                }),
                            SizedBox(
                              width: 80,
                              child: MenuItem(
                                  label: tr(context, 'menus.Timeline', lang),
                                  svgPath:
                                      'assets/interface/Karma_Concierge.svg',
                                  onTap: () {
                                    _goToPage(7, '/karma-timeline');
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Wrap(
                        spacing: 20,
                        children: [
                          // MenuItem(
                          //     label: tr(context, 'menus.FAQs', lang),
                          //     svgPath: 'assets/interface/FAQs.svg',
                          //     showPath: false,
                          //     onTap: () {
                          //       _goToPage(8, '/faqs');
                          //     }),
                          // MenuItem(
                          //     label: tr(context, 'menus.Qualification', lang),
                          //     svgPath: 'assets/interface/FAQs.svg',
                          //     showPath: false,
                          //     onTap: () {
                          //       _goToPage(8, '/qualification');
                          //     }),
                          MenuItem(
                              label: tr(context, 'menus.Points Table', lang),
                              svgPath: 'assets/interface/Points_Table.svg',
                              showPath: false,
                              onTap: () {
                                _goToPage(9, '/points-table');
                              }),
                          MenuItem(
                              label: tr(context, 'menus.Good Karma', lang),
                              svgPath: 'assets/interface/Good_Karma.svg',
                              showPath: false,
                              onTap: () {
                                _goToPage(10, '/good-karma');
                              }),
                          Container(
                            margin: const EdgeInsets.only(top: 35),
                            child: Wrap(
                              direction: Axis.vertical,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runAlignment: WrapAlignment.center,
                              children: [
                                MenuItem(
                                    label: tr(context, 'menus.Language', lang),
                                    svgPath: 'assets/interface/Language.svg',
                                    isShortPath: true,
                                    onTap: () {
                                      // _langChange('eu');
                                    }),
                                Container(
                                  width: 56,
                                  margin: const EdgeInsets.only(top: 20),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton<String>(
                                    alignment: Alignment.center,
                                    value: _selectedLanguage,
                                    items: languageItems,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedLanguage = newValue!;
                                        _langChange(newValue);
                                      });
                                    },
                                    dropdownColor: Colors.black,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                    isDense: true,
                                    menuWidth: 56,
                                    borderRadius: BorderRadius.circular(10),
                                    underline: Container(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 40, 0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                        ),
                        child: IconButton(
                          onPressed: () => logout(context),
                          icon: const Icon(
                            Icons.logout,
                            size: 24,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

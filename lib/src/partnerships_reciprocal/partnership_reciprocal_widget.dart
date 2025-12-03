import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_para.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/loading_component.dart';

class PartnershipReciprocalWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String lang;

  const PartnershipReciprocalWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  State<PartnershipReciprocalWidget> createState() =>
      _PartnershipReciprocalWidgetState();
}

class _PartnershipReciprocalWidgetState
    extends State<PartnershipReciprocalWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  late final ScrollController _scrollController;

  String _selectedPlace = '';
  int _selectedLogo = 0;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();

    if (widget.data['slides'] != null && widget.data['slides'] is Map) {
      var firstKey = widget.data['slides'].keys.first;
      _selectedPlace = firstKey;
    }
    _scrollController = ScrollController();
  }

  void _changePlace(String key) {
    setState(() {
      _selectedPlace = key;
      _selectedLogo = 0;
      // _logos = widget.data['slides'][_selectedPlace];
      _pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _changeLogo(int index) {
    setState(() {
      _scrollOffset = _scrollController.offset;
      _selectedLogo = index;
    });

    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollOffset);
    });
  }

  Map<String, dynamic> getSelectedData() {
    if (widget.data['slides'] != null &&
        widget.data['slides'][_selectedPlace] != null &&
        widget.data['slides'][_selectedPlace][_selectedLogo] != null) {
      return Map<String, dynamic>.from(
          widget.data['slides'][_selectedPlace][_selectedLogo]);
    }
    return {};
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 500,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 500,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, dynamic> selectedData = getSelectedData();

    return Container(
      constraints: BoxConstraints(minWidth: size.width, minHeight: size.height),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FadeInAnimation(
            delay: const Duration(milliseconds: 700),
            child: Container(
              width: size.width / 1.8,
              padding: const EdgeInsets.fromLTRB(60, 80, 60, 0),
              child: CustomText(
                label: widget.data['title'][widget.lang],
                type: 'h2',
                textStyle: const TextStyle(color: AppColors.primary),
                textAlign: TextAlign.center,
                isSerif: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeInAnimation(
            delay: const Duration(milliseconds: 800),
            child: Container(
              width: size.width / 1.2,
              padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
              child: CustomPara(
                labels: [
                  widget.data['para1'][widget.lang],
                  widget.data['para2'][widget.lang],
                  widget.data['para2'][widget.lang],
                ],
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 30),
          (widget.data['slides'] != null && widget.data['slides'] is Map)
              ? FadeInAnimation(
                  delay: const Duration(milliseconds: 300),
                  initOpacity: 0.2,
                  child: Column(
                    children: [
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 20,
                        children: widget.data['countries'].entries
                            .map<Widget>((entry) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () => _changePlace(entry.key),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: _selectedPlace == entry.key
                                  ? const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: AppColors.primary,
                                              width: 2)))
                                  : null,
                              child: CustomText(
                                type: 'lg',
                                label: entry.value[widget.lang],
                                textAlign: TextAlign.center,
                                textStyle: _selectedPlace == entry.key
                                    ? const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                      )
                                    : const TextStyle(
                                        color: AppColors.white,
                                      ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 500,
                            alignment: Alignment.topCenter,
                            child: FadeInAnimation(
                              delay: const Duration(milliseconds: 300),
                              initOpacity: 0.2,
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: selectedData['images'].length,
                                itemBuilder: (context, index) {
                                  String imageUrl =
                                      selectedData['images'][index];

                                  return Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage('${AppAPI.baseUrlGcp}$imageUrl'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: size.width,
                              padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.black.withValues(alpha: 0.0),
                                    AppColors.black.withValues(alpha: 0.3),
                                    AppColors.black.withValues(alpha: 0.8)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [0.1, 0.3, 1],
                                ),
                              ),
                              child: Wrap(
                                runAlignment: WrapAlignment.center,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                direction: Axis.vertical,
                                alignment: WrapAlignment.center,
                                spacing: 10,
                                children: [
                                  CustomText(
                                    label: selectedData['title']![widget.lang],
                                    type: 'h3',
                                    isSerif: true,
                                    textStyle: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  CustomText(
                                    label: selectedData['destination']![
                                        widget.lang],
                                    type: 'md',
                                    textStyle:
                                        const TextStyle(color: AppColors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    width: size.width / 1.5,
                                    child: CustomText(
                                      label: selectedData['description']![
                                          widget.lang],
                                      maxLines: 3,
                                      textStyle: const TextStyle(
                                          color: AppColors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Wrap(
                        spacing: 20,
                        children: [
                          if (_selectedPlace == 'India')
                            SizedBox(
                              width: 60,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                color: AppColors.white,
                                iconSize: 30,
                                onPressed: () {
                                  _scrollLeft();
                                },
                              ),
                            ),
                          SizedBox(
                            width: size.width - 200,
                            child: Center(
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  spacing: 80,
                                  children: widget.data['slides']
                                          [_selectedPlace]
                                      .asMap()
                                      .entries
                                      .map<Widget>((entry) {
                                    int index = entry.key;
                                    var item = entry.value;

                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () => _changeLogo(index),
                                      child: Opacity(
                                        opacity:
                                            _selectedLogo == index ? 1 : 0.5,
                                        child: Image.network(
                                          '${AppAPI.baseUrlGcp}${item['logo']}',
                                          height: 80,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          if (_selectedPlace == 'India')
                            SizedBox(
                              width: 60,
                              child: IconButton(
                                icon: const Icon(Icons.arrow_forward),
                                color: AppColors.white,
                                iconSize: 30,
                                onPressed: () {
                                  _scrollRight();
                                },
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                )
              : const Center(child: LoadingComponent()),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

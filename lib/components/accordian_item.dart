import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class CustomAccordionItem extends StatefulWidget {
  final Map<String, dynamic> faq;
  final String lang;

  const CustomAccordionItem({
    super.key,
    required this.faq,
    required this.lang,
  });

  @override
  State<CustomAccordionItem> createState() => _CustomAccordionItemState();
}

class _CustomAccordionItemState extends State<CustomAccordionItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0.0, end: 0.50).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: ThemeData(dividerColor: Colors.transparent),
          child: ExpansionTile(
            trailing: RotationTransition(
              turns: _animation,
              child: const Icon(
                Icons.arrow_drop_down_circle_rounded,
                size: 40,
              ),
            ),
            backgroundColor: AppColors.primary.withValues(alpha: 0.2),
            iconColor: AppColors.primary,
            collapsedIconColor: AppColors.lightGray,
            tilePadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            dense: true,
            title: CustomText(
              label: widget.faq['question'][widget.lang],
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            initiallyExpanded: _isExpanded,
            onExpansionChanged: (value) {
              setState(() {
                _isExpanded = value;
                if (_isExpanded) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
              });
            },
            children: [
              // NoData(title: widget.faq['points'].toString())
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                title: HtmlWidget(widget.faq['answer'][widget.lang]),
                subtitle: widget.faq['points'] != null &&
                        widget.faq['points'] is List &&
                        widget.faq['points'].isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 20),
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: 10,
                          children: (widget.faq['points'] as List<dynamic>)
                              .map<Widget>((point) {
                            return HtmlWidget(
                                "• ${point[widget.lang].toString()}");
                          }).toList(),
                        ),
                      )
                    : null,
              )
            ],
          ),
        ),
        if (_isExpanded)
          const Divider(
            thickness: 1,
            height: 0,
          ),
        if (!_isExpanded)
          const DottedLine(
            dashLength: 2,
          ),
      ],
    );
  }
}

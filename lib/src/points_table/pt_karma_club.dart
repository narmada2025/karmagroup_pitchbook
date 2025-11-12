import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/src/points_table/widgets/points_table_blank_cell.dart';
import 'package:pitchbook/src/points_table/widgets/points_table_col_header.dart';
import 'package:pitchbook/src/points_table/widgets/points_table_left_col.dart';
import 'package:pitchbook/src/points_table/widgets/points_table_reservation.dart';
import 'package:pitchbook/src/points_table/widgets/points_table_row_content.dart';

class PtKarmaClub extends StatefulWidget {
  final Map<String, dynamic> pointsData;
  final String lang;

  const PtKarmaClub({
    super.key,
    required this.pointsData,
    required this.lang,
  });

  @override
  State<PtKarmaClub> createState() => _PtKarmaClubState();
}

class _PtKarmaClubState extends State<PtKarmaClub> {
  final ScrollController _scrollController = ScrollController();

  Map<String, Color> dailyColors = {
    'Emerald': AppColors.tableGoldenLight2,
    'Titanium': AppColors.tableGreen2,
    'Platinum': AppColors.tablePurple2,
    'Silver': AppColors.tableGray2,
  };

  Map<String, Color> weeklyColors = {
    'Emerald': AppColors.tableGoldenLight,
    'Titanium': AppColors.tableGreen,
    'Platinum': AppColors.tablePurple,
    'Silver': AppColors.tableGray,
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    const double firstRowHeight = 110;
    const double rowHeight = 70;
    const String tabName = 'club';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 50),
                height: size.height / 1.5,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Wrap(direction: Axis.vertical, children: [
                    ...widget.pointsData.isNotEmpty
                        ? widget.pointsData[tabName]['properties'].entries
                            .map<Widget>((entry) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Wrap(
                                spacing: 3,
                                direction: Axis.vertical,
                                children: [
                                  if (entry.key != 'default')
                                    CustomText(
                                      label: widget.pointsData['type']
                                          [entry.key][widget.lang],
                                      type: 'h6',
                                      isSerif: true,
                                      maxLines: 2,
                                      textStyle: TextStyle(
                                        color: weeklyColors[
                                                entry.key.toString()] ??
                                            AppColors.tableGoldenLight2,
                                      ),
                                    ),
                                  ...entry.value.map<Widget>((item) {
                                    return CustomText(
                                      label: item[widget.lang],
                                      maxLines: 2,
                                      type: 'sm',
                                      textStyle: const TextStyle(
                                          color: AppColors.white),
                                    );
                                  })
                                ],
                              ),
                            );
                          }).toList()
                        : [],
                  ]),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.black.withValues(alpha: 1),
                        AppColors.black.withValues(alpha: .5),
                        AppColors.black.withValues(alpha: 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const [0.1, 0.8, 1],
                    ),
                  ),
                  child: const Text(''),
                ),
              ),
              Positioned(
                bottom: 0,
                child: InkWell(
                  onTap: () {
                    double offset = _scrollController.offset;
                    _scrollController.animateTo(
                      offset + 300,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primary),
                        borderRadius: BorderRadius.circular(50)),
                    child: SvgPicture.network(
                      "${AppAPI.baseUrlGcp}${'assets/images/community/curated-events/icons/Filter Location.svg'}",
                      width: 20,
                      fit: BoxFit.contain,
                      semanticsLabel: 'down Arrow',
                      placeholderBuilder: (context) =>
                          const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 60,
        ),
        Expanded(
          flex: 3,
          child: Wrap(
            runSpacing: 50,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    child: Column(
                      children: [
                        if (widget.pointsData.isNotEmpty)
                          const PointsTableBlankCell(
                            height: firstRowHeight,
                            color: AppColors.dark,
                            gapColor: AppColors.black,
                            gap: 2,
                          ),
                        ...widget.pointsData.isNotEmpty
                            ? widget.pointsData[tabName]['points'].entries
                                .map<Widget>((entry) {
                                return PointsTableLeftCol(
                                  height: rowHeight,
                                  firstCellFlex: 2,
                                  cellFlex: 2,
                                  gap: 2,
                                  title: widget.pointsData['type'][entry.key]
                                      [widget.lang],
                                  dailyColor: dailyColors[
                                          widget.pointsData['type'][entry.key]
                                              [widget.lang]] ??
                                      AppColors.tableGoldenLight2,
                                  weeklyColor: weeklyColors[
                                          widget.pointsData['type'][entry.key]
                                              [widget.lang]] ??
                                      AppColors.tableGoldenLight,
                                  weeklyTitle: widget.pointsData['weekly']
                                      [widget.lang],
                                  dailyTitle: widget.pointsData['daily']
                                      [widget.lang],
                                );
                              }).toList()
                            : [],
                        if (widget.pointsData.isNotEmpty &&
                            widget.pointsData[tabName]['multiunit'] != null)
                          PointsTableBlankCell(
                            height: 150,
                            color: AppColors.dark,
                            gapColor: AppColors.black,
                            gap: 2,
                            title: widget.pointsData['Multi Unit'][widget.lang],
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: 700,
                        child: Column(
                          children: [
                            Row(children: [
                              ...widget.pointsData.isNotEmpty &&
                                      widget.pointsData[tabName]['labels'] !=
                                          null
                                  ? widget.pointsData[tabName]['labels']
                                      .map<Widget>((entry) {
                                      return Expanded(
                                        flex: 1,
                                        child: PointsTableColHeader(
                                          title: entry[widget.lang],
                                          col1Title: widget.pointsData['Red']
                                              [widget.lang],
                                          col2Title: widget.pointsData['White']
                                              [widget.lang],
                                          col3Title: widget.pointsData['Blue']
                                              [widget.lang],
                                          height: firstRowHeight,
                                        ),
                                      );
                                    })
                                  : [],
                            ]),
                            ...widget.pointsData.isNotEmpty
                                ? widget.pointsData[tabName]['points'].entries
                                    .map<Widget>((entry) {
                                    return PointsTableRowContent(
                                      height: rowHeight,
                                      dailyData: entry.value['daily'],
                                      weeklyData: entry.value['weekly'],
                                      dailyColor: dailyColors[
                                              widget.pointsData['type']
                                                  [entry.key][widget.lang]] ??
                                          AppColors.tableGoldenLight2,
                                      weeklyColor: weeklyColors[
                                              widget.pointsData['type']
                                                  [entry.key][widget.lang]] ??
                                          AppColors.tableGoldenLight,
                                    );
                                  }).toList()
                                : [],
                            Row(children: [
                              ...widget.pointsData.isNotEmpty &&
                                      widget.pointsData[tabName]['multiunit'] !=
                                          null
                                  ? widget.pointsData[tabName]['multiunit']
                                      .map<Widget>((entry) {
                                      return Expanded(
                                          flex: 1,
                                          child: PointsTableColHeader(
                                            list: entry[widget.lang],
                                            height: 150,
                                            showCategory: false,
                                            textAlignment: TextAlign.left,
                                            alignment: 'left',
                                            textStyle: const TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w500),
                                            iconWidth: 5,
                                          ));
                                    })
                                  : [],
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.pointsData.isNotEmpty &&
                  widget.pointsData[tabName]['reservation'] != null)
                PointsTableReservation(
                  data: widget.pointsData[tabName]['reservation'],
                  lang: widget.lang,
                  title: widget.pointsData['Reservation Programs'][widget.lang],
                ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/bloc/simulator_category/simulator_category_bloc.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../config/config.dart';
import '../../data/model/cost_simulator.model.dart';
import '../../utils/constants.dart';
import '../../utils/string_const.dart';

class SimulatorTableHeaderWidget extends StatelessWidget {
  final SimulatorCategoryState? state;
  final SizingInformation? size;
  const SimulatorTableHeaderWidget({
    super.key,
    this.state,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    TableHeadings? headings = state
        ?.costSimulatorListModel?.costSimulatorListSegmentItems?.tableHeadings;
    return Row(
      children: [
        //* ---(simulator id)
        _buildTableCell(
          StringConst.tableHeaderId,
          size,
          .18,
          .10,
          tbWidth.idWidth(Constants.width),
          // .07,
          context,
        ),
        5.width,
        //* ---(item name)
        _buildTableCell(
          headings?.itemName ?? "",
          size,
          .3,
          .19,
          .17,
          context,
        ),
        5.width,
        //* ---(JVL sub)
        _buildTableCell(
          headings?.jvlSub ?? "",
          size,
          .24,
          .17,
          tbWidth.busUnitWidth(Constants.width),
          // .15,
          context,
        ),
        5.width,
        //* ---(vol)
        _buildTableCell(
          headings?.volume ?? "",
          size,
          .22,
          .16,
          .12,
          context,
        ),
        5.width,
        //* ---(Sell curr)
        _buildTableCell(
          headings?.sellCorrency ?? "",
          size,
          .18,
          .15,
          tbWidth.currWidth(Constants.width),
          // .095,
          context,
        ),
        5.width,
        //* ---(Status)
        _buildTableCell(
          headings?.status ?? "",
          size,
          .18,
          .15,
          tbWidth.statusWidth(Constants.width),
          // .095,
          context,
        ),
        5.width,
        //* ---(created By)
        _buildTableCell(
          headings?.createdby ?? "",
          size,
          .26,
          .16,
          .12,
          context,
        ),
        5.width,
        //* ----(created on)
        _buildTableCell(
          headings?.createdon ?? "",
          size,
          .2,
          .15,
          tbWidth.createdOnWidth(Constants.width),
          // .095,
          context,
        ),
        5.width,
        //* ---(Approved By)
        _buildTableCell(
          headings?.approvedby ?? "",
          size,
          .26,
          .16,
          .12,
          context,
        ),
        5.width,
        //* ----(Approved on)
        _buildTableCell(
          headings?.approvedon ?? "",
          size,
          .2,
          .15,
          tbWidth.createdOnWidth(Constants.width),
          // .095,
          context,
        ),
        10.width,
      ],
    );
  }

  Widget _buildTableCell(
    String value,
    SizingInformation? size,
    double mobileWidth,
    double tabletWidth,
    double desktopWidth,
    BuildContext context,
  ) {
    return uiCon.tableHeaderCell(
      value,
      getValueForScreenType(
        context: context,
        mobile: (size?.screenSize.width ?? 0) * mobileWidth,
        tablet: (size?.screenSize.width ?? 0) * tabletWidth,
        desktop: (size?.screenSize.width ?? 0) * desktopWidth,
      ),
      context,
    );
  }
}

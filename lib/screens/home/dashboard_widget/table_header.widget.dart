import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/utils/constants.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/home_bloc/home_bloc.dart';
import '../../../config/config.dart';
import '../../../utils/string_const.dart'; // Assuming you're using this for SizingInformation

class TableHeaderWidget extends StatelessWidget {
  final HomeState? state;
  final SizingInformation? size;

  const TableHeaderWidget({
    super.key,
    this.state,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    var headingData =
        state?.costSimulatorListModel?.costSimulatorListSegmentItems;

    return Row(
      children: [
        //* ---(sim id)
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
        //* ---(project name)
        _buildTableCell(
          headingData?.tableHeadings?.itemName ?? "",
          size,
          .3,
          .2,
          .17,
          context,
        ),
        5.width,
        //* ---(Business unit)
        _buildTableCell(
          headingData?.tableHeadings?.jvlSub ?? "",
          size,
          .24,
          .17,
          tbWidth.busUnitWidth(Constants.width),
          context,
        ),
        5.width,
        //* ---(vol)
        _buildTableCell(
          headingData?.tableHeadings?.volume ?? "",
          size,
          .22,
          .15,
          .1,
          context,
        ),
        5.width,
        //* ---(Sell curr)
        _buildTableCell(
          headingData?.tableHeadings?.sellCorrency ?? "",
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
          headingData?.tableHeadings?.status ?? "",
          size,
          .18,
          .15,
          // .095,
          tbWidth.statusWidth(Constants.width),
          // .095,
          context,
        ),
        5.width,
        //* ---(created By)
        _buildTableCell(
          headingData?.tableHeadings?.createdby ?? "",
          size,
          .26,
          .16,
          .12,
          context,
        ),
        5.width,
        //* ----(created on)
        _buildTableCell(
          headingData?.tableHeadings?.createdon ?? "",
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
          headingData?.tableHeadings?.approvedby ?? "",
          size,
          .26,
          .16,
          .12,
          context,
        ),
        5.width,
        //* ----(Approved on)
        _buildTableCell(
          headingData?.tableHeadings?.approvedon ?? "",
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:johnsonville_cost_simulator/themes/app_colors.dart';
import 'package:johnsonville_cost_simulator/utils/enums.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/home_bloc/home_bloc.dart';
import '../../../config/config.dart';
import '../../../routes/routes_constants.dart';
import '../../../utils/constants.dart';
import '../../../utils/string_const.dart';

class TableValuesWidget extends StatelessWidget {
  final HomeState state;
  final SizingInformation size;

  const TableValuesWidget({
    super.key,
    required this.state,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.itemLoadingStatus == LoadingStatus.loading) {
          // Show loading popup if it's not already shown
          if (!Navigator.of(context).canPop()) {
            uiCon.popupLoading(context);
          }
        } else if (Navigator.of(context).canPop()) {
          // Dismiss the loading popup if it is currently displayed
          Navigator.of(context).pop();
        }
      },
      child: Column(
        children: _buildTableValue(state, context, size),
      ),
    );
  }

  List<Widget> _buildTableValue(
    HomeState state,
    BuildContext context,
    SizingInformation size,
  ) {
    return List.generate(
      state.costSimulatorListModel?.costSimulatorListSegmentItems
              ?.costSimulatorListItems?.length ??
          0,
      (int index) {
        var data = state.costSimulatorListModel?.costSimulatorListSegmentItems
            ?.costSimulatorListItems?[index];
        return InkWell(
          borderRadius:
              BorderRadius.circular(5.0), // Assuming kDim.kRadius02 is this
          onHover: (bool isHovered) {
            if (isHovered) {
              context.read<HomeBloc>().add(
                    OnItemSelect(index: index),
                  );
            } else {
              context.read<HomeBloc>().add(
                    const OnItemSelect(index: -1),
                  );
            }
          },
          onTap: () async {
            if (data?.status == StringConst.completed.toUpperCase() ||
                data?.status == StringConst.completed ||
                data?.status == StringConst.approval.toUpperCase()) {
              final homeBloc = context.read<HomeBloc>();
              homeBloc.add(ItemTap(simId: data?.simulatorId ?? ""));
              // context
              //     .read<HomeBloc>()
              //     .add(ItemTap(simId: data?.simulatorId ?? ""));
              // Wait for packUOM and sellPriceUOM values
              final packUOM = await homeBloc.stream
                  .firstWhere((state) =>
                      state.packUom != null && state.sellPriceUOM != null)
                  .then((state) => state.packUom);
              final sellPriceUOM = await homeBloc.stream
                  .firstWhere((state) =>
                      state.packUom != null && state.sellPriceUOM != null)
                  .then((state) => state.sellPriceUOM);

              // Navigate after fetching values
              if (context.mounted) {
                context.goNamed(RouteConstants.name.pricing, queryParameters: {
                  "id": data?.simulatorId,
                  "packUOM": packUOM,
                  "sellPriceUOM": sellPriceUOM,
                });
              }
              // context.goNamed(RouteConstants.name.pricing, queryParameters: {
              //   "id": data?.simulatorId,
              //   "packUOM": state.packUom,
              //   "sellPriceUOM": state.sellPriceUOM,
              // });
            } else {
              context.goNamed(RouteConstants.name.stepOne, queryParameters: {
                "id": data?.simulatorId,
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: state.selectedItemIndex == index &&
                      data?.status == StringConst.completed.toUpperCase()
                  ? AppColors.completehover
                  : state.selectedItemIndex == index &&
                          data?.status == StringConst.pending.toUpperCase()
                      ? AppColors.orange.withOpacity(0.2)
                      : state.selectedItemIndex == index &&
                              data?.status == StringConst.approval.toUpperCase()
                          ? AppColors.approvalhover
                          : AppColors.transparent,
            ),
            child: Row(
              children: [
                //* ---(simulator id)
                _buildTableCell(
                  (data?.simulatorId?.isEmpty ?? false)
                      ? "-"
                      : data?.simulatorId ?? "",
                  size,
                  mobileWidth: 0.18,
                  tabletWidth: 0.10,
                  desktopWidth: tbWidth.idWidth(Constants.width),
                  // desktopWidth: 0.07,
                  context,
                ),
                5.width,
                //* ---(item name)
                _buildTableCell(
                    (data?.itemName?.isEmpty ?? false)
                        ? "-"
                        : data?.itemName ?? "",
                    size,
                    mobileWidth: 0.3,
                    tabletWidth: 0.2,
                    desktopWidth: 0.17,
                    context),
                5.width,
                //* ---(Business Unit)
                _buildTableCell(
                    (data?.businessUnitName?.isEmpty ?? false)
                        ? "-"
                        : data?.businessUnitName ?? "",
                    size,
                    mobileWidth: 0.24,
                    tabletWidth: 0.17,
                    desktopWidth: tbWidth.busUnitWidth(Constants.width),
                    context),
                5.width,
                //* ---(vol )
                _buildTableCell(
                    (data?.volume?.isEmpty ?? false) ? "-" : data?.volume ?? "",
                    size,
                    mobileWidth: 0.22,
                    tabletWidth: 0.15,
                    desktopWidth: 0.1,
                    context),
                5.width,
                //* ---(sell currency)
                _buildTableCell(
                    (data?.sellCurrency?.isEmpty ?? false)
                        ? "-"
                        : data?.sellCurrency ?? "",
                    size,
                    mobileWidth: 0.18,
                    tabletWidth: 0.15,
                    desktopWidth: tbWidth.currWidth(Constants.width),
                    // desktopWidth: 0.095,
                    context),
                5.width,
                //* ---(status)
                _buildTableCell(
                    (data?.status?.isEmpty ?? false)
                        ? "-"
                        : data?.status?.toUpperCase() ?? "",
                    size,
                    mobileWidth: 0.18,
                    tabletWidth: 0.15,
                    desktopWidth: tbWidth.statusWidth(Constants.width),
                    // desktopWidth: 0.095,
                    textColor:
                        data?.status == StringConst.completed.toUpperCase() ||
                                data?.status == StringConst.completed
                            ? AppColors.textgreen
                            : data?.status == StringConst.approval.toUpperCase()
                                ? AppColors.approvaltext
                                : AppColors.pendingtext,
                    context),
                5.width,
                //* ---(created by)
                _buildTableCell(
                    (data?.createdby?.isEmpty ?? false)
                        ? "-"
                        : data?.createdby ?? "",
                    size,
                    mobileWidth: 0.26,
                    tabletWidth: 0.16,
                    desktopWidth: 0.12,
                    context),
                5.width,
                //* ---(created on)
                _buildTableCell(
                    (data?.createdon?.isEmpty ?? false)
                        ? "-"
                        : data?.createdon ?? "",
                    size,
                    mobileWidth: 0.2,
                    tabletWidth: 0.15,
                    desktopWidth: tbWidth.createdOnWidth(Constants.width),
                    // desktopWidth: 0.095,
                    context),
                5.width,
                //* ---(approved by)
                _buildTableCell(
                    (data?.approvedby?.isEmpty ?? false)
                        ? "-"
                        : data?.approvedby ?? "",
                    size,
                    mobileWidth: 0.26,
                    tabletWidth: 0.16,
                    desktopWidth: 0.12,
                    context),
                5.width,
                //* ---(approved on)
                _buildTableCell(
                    (data?.approvedon?.isEmpty ?? false)
                        ? "-"
                        : data?.approvedon ?? "-",
                    size,
                    mobileWidth: 0.2,
                    tabletWidth: 0.15,
                    desktopWidth: tbWidth.createdOnWidth(Constants.width),
                    // desktopWidth: 0.095,
                    context),
                10.width,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTableCell(
    String value,
    SizingInformation size,
    BuildContext context, {
    Color? textColor,
    required double mobileWidth,
    required double tabletWidth,
    required double desktopWidth,
  }) {
    return uiCon.tableValueCell(
      textColor: textColor,
      textAlign: value == "-" ? TextAlign.center : TextAlign.start,
      value,
      getValueForScreenType(
        context: context,
        mobile: size.screenSize.width * mobileWidth,
        tablet: size.screenSize.width * tabletWidth,
        desktop: size.screenSize.width * desktopWidth,
      ),
      context,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../config/config.dart';
import '../../../routes/routes_constants.dart';
import '../../../utils/string_const.dart';
import '../../bloc/simulator_category/simulator_category_bloc.dart';
import '../../themes/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';

class SimulatorTableValuesWidget extends StatelessWidget {
  final SimulatorCategoryState state;
  final SizingInformation size;
  const SimulatorTableValuesWidget({
    super.key,
    required this.state,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<SimulatorCategoryBloc, SimulatorCategoryState>(
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

//!-------(table value)
  List<Widget> _buildTableValue(
    SimulatorCategoryState state,
    BuildContext context,
    SizingInformation size,
  ) {
    return List.generate(
      state.paginatedData?.length ?? 0,
      (int index) => InkWell(
        onHover: (bool isHovered) {
          if (isHovered) {
            context.read<SimulatorCategoryBloc>().add(
                  OnItemSelect(index: index),
                );
          } else {
            context.read<SimulatorCategoryBloc>().add(
                  const OnItemSelect(index: -1),
                );
          }
        },
        onTap: () async {
          if (state.paginatedData?[index].status?.toUpperCase() ==
                  StringConst.completed.toUpperCase() ||
              state.paginatedData?[index].status?.toUpperCase() ==
                  StringConst.completed ||
              state.paginatedData?[index].status?.toUpperCase() ==
                  StringConst.approval.toUpperCase()) {
            final simCatBloc = context.read<SimulatorCategoryBloc>();
            simCatBloc.add(
                ItemTap(simId: state.paginatedData?[index].simulatorId ?? ""));
            // context
            //     .read<HomeBloc>()
            //     .add(ItemTap(simId: data?.simulatorId ?? ""));
            // Wait for packUOM and sellPriceUOM values
            final packUOM = await simCatBloc.stream
                .firstWhere((state) =>
                    state.packUom != null && state.sellPriceUOM != null)
                .then((state) => state.packUom);
            final sellPriceUOM = await simCatBloc.stream
                .firstWhere((state) =>
                    state.packUom != null && state.sellPriceUOM != null)
                .then((state) => state.sellPriceUOM);

            // Navigate after fetching values
            if (context.mounted) {
              context.goNamed(RouteConstants.name.pricing, queryParameters: {
                "id": state.paginatedData?[index].simulatorId,
                "packUOM": packUOM,
                "sellPriceUOM": sellPriceUOM,
              });
            }
            // context.goNamed(RouteConstants.name.pricing, queryParameters: {
            //   "id": state.paginatedData?[index].simulatorId,
            // });
          } else {
            context.goNamed(RouteConstants.name.stepOne, queryParameters: {
              "id": state.paginatedData?[index].simulatorId,
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: state.selectedItemIndex == index &&
                    state.paginatedData?[index].status?.toUpperCase() ==
                        StringConst.completed.toUpperCase()
                ? AppColors.completehover
                : state.selectedItemIndex == index &&
                        state.paginatedData?[index].status?.toUpperCase() ==
                            StringConst.pending.toUpperCase()
                    ? AppColors.orange.withOpacity(0.2)
                    : state.selectedItemIndex == index &&
                            state.paginatedData?[index].status?.toUpperCase() ==
                                StringConst.approval.toUpperCase()
                        ? AppColors.approvalhover
                        : AppColors.transparent,
          ),
          child: Row(
            children: [
              //* ---(simulator id)
              _buildTableCell(
                  (state.paginatedData?[index].simulatorId?.isEmpty ?? false)
                      ? "-"
                      : state.paginatedData?[index].simulatorId ?? "",
                  size,
                  0.18,
                  0.10,
                  // 0.07,
                  tbWidth.idWidth(Constants.width),
                  context),
              5.width,
              //* ---(item name)
              _buildTableCell(
                  (state.paginatedData?[index].itemName?.isEmpty ?? false)
                      ? "-"
                      : state.paginatedData?[index].itemName ?? "",
                  size,
                  0.3,
                  0.19,
                  0.17,
                  context),
              5.width,
              //* ---(JVL sub)
              _buildTableCell(
                  (state.paginatedData?[index].businessUnitName?.isEmpty ??
                          false)
                      ? "-"
                      : state.paginatedData?[index].businessUnitName ?? "",
                  size,
                  0.24,
                  0.17,
                  tbWidth.busUnitWidth(Constants.width),
                  // 0.15,
                  context),
              5.width,
              //* ---(vol )
              _buildTableCell(
                  (state.paginatedData?[index].volume?.isEmpty ?? false)
                      ? "-"
                      : state.paginatedData?[index].volume ?? "",
                  size,
                  0.22,
                  0.16,
                  0.12,
                  context),
              5.width,
              //* ---(sell currency)
              _buildTableCell(
                  (state.paginatedData?[index].sellCurrency?.isEmpty ?? false)
                      ? "-"
                      : state.paginatedData?[index].sellCurrency ?? "",
                  size,
                  0.18,
                  0.15,
                  tbWidth.currWidth(Constants.width),
                  // 0.095,
                  context),
              5.width,
              //* ---(status)
              _buildTableCell(
                (state.paginatedData?[index].status?.isEmpty ?? false)
                    ? "-"
                    : state.paginatedData?[index].status?.toUpperCase() ?? "",
                //'',
                size,
                0.18,
                0.15,
                // 0.095,
                tbWidth.statusWidth(Constants.width),
                // child: KStyles().semiBold(
                //   text: (state.paginatedData?[index].status?.isEmpty ?? false)
                //       ? "-"
                //       : state.paginatedData?[index].status ?? "",
                //   size: 14,
                //   color: state.paginatedData?[index].status ==
                //               StringConst.completed.toUpperCase() ||
                //           state.paginatedData?[index].status ==
                //               StringConst.completed
                //       ? AppColors.kTextBlue
                //       : AppColors.red,
                // ),
                context,
                textColor: state.paginatedData?[index].status ==
                            StringConst.completed.toUpperCase() ||
                        state.paginatedData?[index].status ==
                            StringConst.completed
                    ? AppColors.textgreen
                    : state.paginatedData?[index].status ==
                            StringConst.approval.toUpperCase()
                        ? AppColors.approvaltext
                        : AppColors.pendingtext,
              ),
              5.width,
              //* ---(created by)
              _buildTableCell(
                  (state.paginatedData?[index].createdby?.isEmpty ?? false)
                      ? "-"
                      : state.paginatedData?[index].createdby ?? "",
                  size,
                  0.26,
                  0.16,
                  0.12,
                  context),
              5.width,
              //* ---(created on)
              _buildTableCell(
                  (state.paginatedData?[index].createdon?.isEmpty ?? false)
                      ? "-"
                      : state.paginatedData?[index].createdon ?? "",
                  size,
                  0.2,
                  0.15,
                  tbWidth.createdOnWidth(Constants.width),
                  // 0.095,
                  context),
              5.width,
              //* ---(approved by)
              _buildTableCell(
                  (state.paginatedData?[index].approvedby?.isEmpty ?? false)
                      ? "-"
                      : state.paginatedData?[index].approvedby ?? "",
                  size,
                  0.26,
                  0.16,
                  0.12,
                  context),
              5.width,
              //* ---(approved on)
              _buildTableCell(
                  (state.paginatedData?[index].approvedon?.isEmpty ?? false)
                      ? "-"
                      : state.paginatedData?[index].approvedon ?? "-",
                  size,
                  0.2,
                  0.15,
                  tbWidth.createdOnWidth(Constants.width),
                  // 0.095,
                  context),
              10.width,
              //* ---(status)
              //  uiCon.statusCell(
              //   (state.paginatedData?[index].status?.isEmpty ?? false)
              //       ? "-"
              //       : state.paginatedData?[index].status ?? "",
              //   context,
              //   width: getValueForScreenType(
              //     context: context,
              //     mobile: size.screenSize.width * .15,
              //     tablet: size.screenSize.width * .142,
              //     desktop: size.screenSize.width * .08,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTableCell(
  String value,
  SizingInformation size,
  double mobileWidth,
  double tabletWidth,
  double desktopWidth,
  BuildContext context, {
  Color? textColor,
  // Widget? child,
}) {
  return uiCon.tableValueCell(
    textColor: textColor,
    textAlign: value == '-' ? TextAlign.center : TextAlign.start,
    value,
    getValueForScreenType(
      context: context,
      mobile: size.screenSize.width * mobileWidth,
      tablet: size.screenSize.width * tabletWidth,
      desktop: size.screenSize.width * desktopWidth,
    ),
    //child: child,
    context,
  );
}

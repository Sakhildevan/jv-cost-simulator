import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/widgets/shimmer.widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../bloc/home_bloc/home_bloc.dart';
import '../../../utils/enums.dart';
import '../../../widgets/custom_table.dart';
import 'table_header.widget.dart';
import 'table_values.widget.dart';

class HomeSimulatorList extends StatelessWidget {
  const HomeSimulatorList({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.loadingStatus == LoadingStatus.loading) {
          return const ShimmerLoader(listCount: 5, type: ShimmerType.list);
        } else {
          return ResponsiveBuilder(builder: (context, size) {
            return CustomTable(
              scrollController: scrollController,
              //!---(table header)
              tableHeader: TableHeaderWidget(state: state, size: size),
              //!---(table content)
              tableContent: (state
                          .costSimulatorListModel
                          ?.costSimulatorListSegmentItems
                          ?.costSimulatorListItems
                          ?.isNotEmpty ??
                      false)
                  //!---(table values)
                  ? TableValuesWidget(state: state, size: size)
                  : uiCon.emptyData(context),
            );
          });
        }
      },
    );
  }
}

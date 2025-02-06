import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/simulator_category/simulator_category_bloc.dart';
import '../../utils/enums.dart';
import '../../widgets/custom_table.dart';
import '../../widgets/shimmer.widget.dart';
import 'simulator_table_header.widget.dart';
import 'simulator_table_values.widget.dart';

class PendingListTable extends StatelessWidget {
  const PendingListTable({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    int prevIndex = 0;
    return BlocConsumer<SimulatorCategoryBloc, SimulatorCategoryState>(
      listener: (context, state) {
        //note this code is for scrolling the list to top when page changes
        if (state.currentPageIndex != prevIndex) {
          scrollController.animateTo(0,
              duration: Durations.long1, curve: Curves.bounceIn);
          prevIndex = state.currentPageIndex ?? 0;
        }
      },
      builder: (context, state) {
        if (state.loadingStatus == LoadingStatus.loading) {
          return const ShimmerLoader(listCount: 8, type: ShimmerType.list);
        } else {
          return ResponsiveBuilder(
            builder: (context, size) {
              return CustomTable(
                scrollController: scrollController,
                //!---(table header)
                tableHeader: SimulatorTableHeaderWidget(
                  state: state,
                  size: size,
                ),
                //!---(table content)

                tableContent: (state.paginatedData?.isNotEmpty ?? false)
                    //!---(table values)
                    ? SimulatorTableValuesWidget(
                        state: state,
                        size: size,
                      )
                    : uiCon.emptyData(context),
              );
            },
          );
        }
      },
    );
  }
}

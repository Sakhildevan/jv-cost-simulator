import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';

import '../../../themes/app_colors.dart';
import '../custom_pricing_widgets/custom_table_row.dart';

class StandardCost extends StatelessWidget {
  const StandardCost({
    super.key,
    this.color,
    this.textColor,
    this.total,
    this.isReviewList,
  });
  final Color? color;
  final Color? textColor;
  final bool? total;
  final bool? isReviewList;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        var standardCost =
            state.pricingData?.pricingWorksheetSegmentItems?.standardCost;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTableRowData(
              isReviewList: isReviewList,
              textColor: textColor,
              editTextColor: textColor,
              firstRowColor: color ?? AppColors.cream,
              secondRowColor: color ?? AppColors.lighterMaroon,
              thirdRowColor: color ?? AppColors.green,
              title: standardCost?.title?.toUpperCase() ?? "",
              componentName: standardCost?.data?.firstOrNull?.componentName
                      ?.toUpperCase() ??
                  "",
              valueInUsd: standardCost?.data?.firstOrNull?.valInUsd ?? "",
              volUsd: standardCost?.data?.firstOrNull?.volLvlUsd ?? "",
              total: total ?? true,
              packUsd: standardCost?.data?.firstOrNull?.packlvlUsd ?? "",
              caseUsd: standardCost?.data?.firstOrNull?.caselvlUsd ?? "",
              linkUsd: standardCost?.data?.firstOrNull?.linklvlUsd ?? "",
              volCad: standardCost?.data?.firstOrNull?.vollvlCad ?? "",
              packCad: standardCost?.data?.firstOrNull?.packlvlCad ?? "",
              caseCad: standardCost?.data?.firstOrNull?.caselvlCad ?? "",
              linkCad: standardCost?.data?.firstOrNull?.linklvlCad ?? "",
            ),
          ],
        );
      },
    );
  }
}

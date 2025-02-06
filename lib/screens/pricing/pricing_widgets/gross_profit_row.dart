import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';
import '../custom_pricing_widgets/custom_table_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';

class GrossProfitRow extends StatelessWidget {
  const GrossProfitRow({
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
        var grossProfit =
            state.pricingData?.pricingWorksheetSegmentItems?.grossProfit;
        return CustomTableRowData(
          isReviewList: isReviewList,
          textColor: textColor,
          editTextColor: textColor,
          firstRowColor: color ?? AppColors.cream,
          secondRowColor: color ?? AppColors.lighterMaroon,
          thirdRowColor: color ?? AppColors.green,
          title: grossProfit?.title ?? "",
          componentName: grossProfit?.data?.firstOrNull?.componentName ?? "",
          valueInUsd: grossProfit?.data?.firstOrNull?.valInUsd ?? "",
          volUsd: grossProfit?.data?.firstOrNull?.volLvlUsd ?? "",
          total: total ?? true,
          packUsd: grossProfit?.data?.firstOrNull?.packlvlUsd ?? "",
          caseUsd: grossProfit?.data?.firstOrNull?.caselvlUsd ?? "",
          linkUsd: grossProfit?.data?.firstOrNull?.linklvlUsd ?? "",
          volCad: grossProfit?.data?.firstOrNull?.vollvlCad ?? "",
          packCad: grossProfit?.data?.firstOrNull?.packlvlCad ?? "",
          caseCad: grossProfit?.data?.firstOrNull?.caselvlCad ?? "",
          linkCad: grossProfit?.data?.firstOrNull?.linklvlCad ?? "",
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';

import '../../../themes/app_colors.dart';
import '../custom_pricing_widgets/custom_table_row.dart';

class GrossProfitPercentRow extends StatelessWidget {
  const GrossProfitPercentRow({
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
        var grossProfitPercent =
            state.pricingData?.pricingWorksheetSegmentItems?.grossProfitpercent;
        return CustomTableRowData(
          isReviewList: isReviewList,
          textColor: textColor,
          editTextColor: textColor,
          firstRowColor: color ?? AppColors.cream,
          secondRowColor: color ?? AppColors.lighterMaroon,
          thirdRowColor: color ?? AppColors.green,
          title: grossProfitPercent?.title ?? "",
          componentName:
              grossProfitPercent?.data?.firstOrNull?.componentName ?? "",
          valueInUsd: ("${grossProfitPercent?.data?.firstOrNull?.valInUsd}%"),
          volUsd: "${grossProfitPercent?.data?.firstOrNull?.volLvlUsd}%",
          total: total ?? true,
          packUsd: "${grossProfitPercent?.data?.firstOrNull?.packlvlUsd}%",
          caseUsd: "${grossProfitPercent?.data?.firstOrNull?.caselvlUsd}%",
          linkUsd: "${grossProfitPercent?.data?.firstOrNull?.linklvlUsd}%",
          volCad: "${grossProfitPercent?.data?.firstOrNull?.vollvlCad}%",
          packCad: "${grossProfitPercent?.data?.firstOrNull?.packlvlCad}%",
          caseCad: "${grossProfitPercent?.data?.firstOrNull?.caselvlCad}%",
          linkCad: "${grossProfitPercent?.data?.firstOrNull?.linklvlCad}%",
        );
      },
    );
  }
}

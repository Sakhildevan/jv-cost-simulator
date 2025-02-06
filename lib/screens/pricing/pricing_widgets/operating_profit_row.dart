import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';
import '../custom_pricing_widgets/custom_table_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';

class OperationProfitRow extends StatelessWidget {
  const OperationProfitRow({
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
        var operatingProfit =
            state.pricingData?.pricingWorksheetSegmentItems?.operatingProfit;
        return CustomTableRowData(
          isReviewList: isReviewList,
          textColor: textColor,
          editTextColor: textColor,
          firstRowColor: color ?? AppColors.cream,
          secondRowColor: color ?? AppColors.lighterMaroon,
          thirdRowColor: color ?? AppColors.green,
          title: operatingProfit?.title ?? "",
          componentName:
              operatingProfit?.data?.firstOrNull?.componentName ?? "",
          valueInUsd: operatingProfit?.data?.firstOrNull?.valInUsd ?? "",
          volUsd: operatingProfit?.data?.firstOrNull?.volLvlUsd ?? "",
          total: true,
          packUsd: operatingProfit?.data?.firstOrNull?.packlvlUsd ?? "",
          caseUsd: operatingProfit?.data?.firstOrNull?.caselvlUsd ?? "",
          linkUsd: operatingProfit?.data?.firstOrNull?.linklvlUsd ?? "",
          volCad: operatingProfit?.data?.firstOrNull?.vollvlCad ?? "",
          packCad: operatingProfit?.data?.firstOrNull?.packlvlCad ?? "",
          caseCad: operatingProfit?.data?.firstOrNull?.caselvlCad ?? "",
          linkCad: operatingProfit?.data?.firstOrNull?.linklvlCad ?? "",
        );
      },
    );
  }
}

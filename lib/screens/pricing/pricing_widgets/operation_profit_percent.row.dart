import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';

import '../../../themes/app_colors.dart';
import '../custom_pricing_widgets/custom_table_row.dart';

class OperationProfitPercentRow extends StatelessWidget {
  const OperationProfitPercentRow({
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
        var operatingProfitPercent = state
            .pricingData?.pricingWorksheetSegmentItems?.operatingProfitpercent;
        return CustomTableRowData(
          isReviewList: isReviewList,
          textColor: textColor,
          editTextColor: textColor,
          firstRowColor: color ?? AppColors.cream,
          secondRowColor: color ?? AppColors.lighterMaroon,
          thirdRowColor: color ?? AppColors.green,
          title: operatingProfitPercent?.title ?? "",
          componentName:
              operatingProfitPercent?.data?.firstOrNull?.componentName ?? "",
          valueInUsd: "${operatingProfitPercent?.data?.firstOrNull?.valInUsd}%",
          volUsd: "${operatingProfitPercent?.data?.firstOrNull?.volLvlUsd}%",
          total: true,
          packUsd: "${operatingProfitPercent?.data?.firstOrNull?.packlvlUsd}%",
          caseUsd: "${operatingProfitPercent?.data?.firstOrNull?.caselvlUsd}%",
          linkUsd: "${operatingProfitPercent?.data?.firstOrNull?.linklvlUsd}%",
          volCad: "${operatingProfitPercent?.data?.firstOrNull?.vollvlCad}%",
          packCad: "${operatingProfitPercent?.data?.firstOrNull?.packlvlCad}%",
          caseCad: "${operatingProfitPercent?.data?.firstOrNull?.caselvlCad}%",
          linkCad: "${operatingProfitPercent?.data?.firstOrNull?.linklvlCad}%",
        );
      },
    );
  }
}

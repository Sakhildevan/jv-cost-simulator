import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';

import '../../../themes/app_colors.dart';
import '../custom_pricing_widgets/custom_table_row.dart';

class GrossSalesRow extends StatelessWidget {
  const GrossSalesRow({
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
        var grossSales =
            state.pricingData?.pricingWorksheetSegmentItems?.grosssales;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (isReviewList ?? false)
                ? const SizedBox.shrink()
                : const Divider(
                    color: AppColors.grey,
                    height: 0.00,
                  ),
            CustomTableRowData(
              isReviewList: isReviewList,
              textColor: textColor,
              editTextColor: textColor,
              firstRowColor: color,
              secondRowColor: color,
              thirdRowColor: color,
              title: grossSales?.title ?? "",
              componentName: grossSales?.data?.firstOrNull?.componentName ?? "",
              valueInUsd: grossSales?.data?.firstOrNull?.valInUsd ?? "",
              volUsd: grossSales?.data?.firstOrNull?.volLvlUsd ?? "",
              total: total ?? true,
              packUsd: grossSales?.data?.firstOrNull?.packlvlUsd ?? "",
              caseUsd: grossSales?.data?.firstOrNull?.caselvlUsd ?? "",
              linkUsd: grossSales?.data?.firstOrNull?.linklvlUsd ?? "",
              volCad: grossSales?.data?.firstOrNull?.vollvlCad ?? "",
              packCad: grossSales?.data?.firstOrNull?.packlvlCad ?? "",
              caseCad: grossSales?.data?.firstOrNull?.caselvlCad ?? "",
              linkCad: grossSales?.data?.firstOrNull?.linklvlCad ?? "",
            ),
          ],
        );
      },
    );
  }
}

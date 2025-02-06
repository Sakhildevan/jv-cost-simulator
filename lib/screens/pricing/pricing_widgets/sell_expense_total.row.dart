import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';

import '../../../themes/app_colors.dart';
import '../custom_pricing_widgets/custom_table_row.dart';

class SellExpenseTotalRow extends StatelessWidget {
  const SellExpenseTotalRow({
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
        var sellingExpenseTotal = state
            .pricingData?.pricingWorksheetSegmentItems?.sellingExpenseTotal;
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
              title: sellingExpenseTotal?.title ?? "",
              componentName:
                  sellingExpenseTotal?.data?.firstOrNull?.componentName ?? "",
              valueInUsd:
                  sellingExpenseTotal?.data?.firstOrNull?.valInUsd ?? "",
              volUsd: sellingExpenseTotal?.data?.firstOrNull?.volLvlUsd ?? "",
              total: total ?? true,
              packUsd: sellingExpenseTotal?.data?.firstOrNull?.packlvlUsd ?? "",
              caseUsd: sellingExpenseTotal?.data?.firstOrNull?.caselvlUsd ?? "",
              linkUsd: sellingExpenseTotal?.data?.firstOrNull?.linklvlUsd ?? "",
              volCad: sellingExpenseTotal?.data?.firstOrNull?.vollvlCad ?? "",
              packCad: sellingExpenseTotal?.data?.firstOrNull?.packlvlCad ?? "",
              caseCad: sellingExpenseTotal?.data?.firstOrNull?.caselvlCad ?? "",
              linkCad: sellingExpenseTotal?.data?.firstOrNull?.linklvlCad ?? "",
            ),
          ],
        );
      },
    );
  }
}

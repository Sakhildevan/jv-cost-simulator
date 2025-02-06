import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';

import '../../../themes/app_colors.dart';
import '../custom_pricing_widgets/custom_table_row.dart';

class CostGoodSoldTotalRow extends StatelessWidget {
  const CostGoodSoldTotalRow({
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
        var costGoodSoldTotal =
            state.pricingData?.pricingWorksheetSegmentItems?.costotal;
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
              componentName:
                  costGoodSoldTotal?.data?.firstOrNull?.componentName ?? "",
              title: costGoodSoldTotal?.title ?? "",
              valueInUsd: costGoodSoldTotal?.data?.firstOrNull?.valInUsd ?? "",
              volUsd: costGoodSoldTotal?.data?.firstOrNull?.volLvlUsd ?? "",
              total: total ?? true,
              packUsd: costGoodSoldTotal?.data?.firstOrNull?.packlvlUsd ?? "",
              caseUsd: costGoodSoldTotal?.data?.firstOrNull?.caselvlUsd ?? "",
              linkUsd: costGoodSoldTotal?.data?.firstOrNull?.linklvlUsd ?? "",
              volCad: costGoodSoldTotal?.data?.firstOrNull?.vollvlCad ?? "",
              packCad: costGoodSoldTotal?.data?.firstOrNull?.packlvlCad ?? "",
              caseCad: costGoodSoldTotal?.data?.firstOrNull?.caselvlCad ?? "",
              linkCad: costGoodSoldTotal?.data?.firstOrNull?.linklvlCad ?? "",
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';

import '../../../themes/app_colors.dart';
import '../custom_pricing_widgets/custom_table_row.dart';

class NetSalesRow extends StatelessWidget {
  const NetSalesRow({
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
        var netSales =
            state.pricingData?.pricingWorksheetSegmentItems?.netsales;
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
              firstRowColor: color ?? AppColors.cream,
              secondRowColor: color ?? AppColors.lighterMaroon,
              thirdRowColor: color ?? AppColors.green,
              title: netSales?.title ?? "",
              componentName: netSales?.data?.firstOrNull?.componentName ?? "",
              valueInUsd: netSales?.data?.firstOrNull?.valInUsd ?? "",
              volUsd: netSales?.data?.firstOrNull?.volLvlUsd ?? "",
              total: total ?? true,
              packUsd: netSales?.data?.firstOrNull?.packlvlUsd ?? "",
              caseUsd: netSales?.data?.firstOrNull?.caselvlUsd ?? "",
              linkUsd: netSales?.data?.firstOrNull?.linklvlUsd ?? "",
              volCad: netSales?.data?.firstOrNull?.vollvlCad ?? "",
              packCad: netSales?.data?.firstOrNull?.packlvlCad ?? "",
              caseCad: netSales?.data?.firstOrNull?.caselvlCad ?? "",
              linkCad: netSales?.data?.firstOrNull?.linklvlCad ?? "",
            ),
          ],
        );
      },
    );
  }
}

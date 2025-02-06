import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';

import '../../../themes/app_colors.dart';
import '../custom_pricing_widgets/custom_table_row.dart';

class DeliveryAndSupplyTotalRow extends StatelessWidget {
  const DeliveryAndSupplyTotalRow({
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
        var delSupplyChainTotal = state
            .pricingData?.pricingWorksheetSegmentItems?.delsupplychainTotal;
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
              title: delSupplyChainTotal?.title ?? "",
              componentName:
                  delSupplyChainTotal?.data?.firstOrNull?.componentName ?? "",
              valueInUsd:
                  delSupplyChainTotal?.data?.firstOrNull?.valInUsd ?? "",
              volUsd: delSupplyChainTotal?.data?.firstOrNull?.volLvlUsd ?? "",
              total: total ?? true,
              packUsd: delSupplyChainTotal?.data?.firstOrNull?.packlvlUsd ?? "",
              caseUsd: delSupplyChainTotal?.data?.firstOrNull?.caselvlUsd ?? "",
              linkUsd: delSupplyChainTotal?.data?.firstOrNull?.linklvlUsd ?? "",
              volCad: delSupplyChainTotal?.data?.firstOrNull?.vollvlCad ?? "",
              packCad: delSupplyChainTotal?.data?.firstOrNull?.packlvlCad ?? "",
              caseCad: delSupplyChainTotal?.data?.firstOrNull?.caselvlCad ?? "",
              linkCad: delSupplyChainTotal?.data?.firstOrNull?.linklvlCad ?? "",
            ),
          ],
        );
      },
    );
  }
}

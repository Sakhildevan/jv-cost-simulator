import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';
import '../custom_pricing_widgets/custom_table_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';

class NetProfitPercentRow extends StatelessWidget {
  const NetProfitPercentRow({
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
        return CustomTableRowData(
          // totalPercent: true,
          isReviewList: isReviewList,
          textColor: AppColors.white,
          editTextColor: textColor,
          firstRowColor: AppColors.maroon,
          secondRowColor: AppColors.maroon,
          thirdRowColor: AppColors.maroon,
          title: "NET PROFIT %",
          isPercent: true,
          componentName: "",
          valueInUsd: "26.5",
          volUsd: "",
          total: true,
          packUsd: "",
          caseUsd: "",
          linkUsd: "",
          volCad: "",
          packCad: "",
          caseCad: "",
          linkCad: "",
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';

import '../../../themes/app_colors.dart';
import '../custom_pricing_widgets/custom_table_row.dart';

class ShelfPriceRow extends StatelessWidget {
  const ShelfPriceRow({
    super.key,
    this.isReviewList,
  });
  final bool? isReviewList;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        var calculatedshelfprice = state
            .pricingData?.pricingWorksheetSegmentItems?.calculatedshelfprice;
        return CustomTableRowData(
          isReviewList: isReviewList,
          total: true,
          title: calculatedshelfprice?.title?.toUpperCase() ?? "",
          componentName:
              calculatedshelfprice?.data?.firstOrNull?.componentName ?? "",
          textColor: AppColors.white,
          editTextColor: AppColors.white,
          firstRowColor: AppColors.reviewGrey,
          secondRowColor: AppColors.reviewGrey,
          thirdRowColor: AppColors.reviewGrey,
          valueInUsd: calculatedshelfprice?.data?.firstOrNull?.valInUsd ?? "",
          blueEditNumberValueInUsd:
              calculatedshelfprice?.data?.firstOrNull?.isEditable1 ?? false,
          volUsd: calculatedshelfprice?.data?.firstOrNull?.vollvlCad ?? "",
          blueEditNumberVolUsd:
              calculatedshelfprice?.data?.firstOrNull?.isEditable2 ?? false,
          packUsd: calculatedshelfprice?.data?.firstOrNull?.packlvlUsd ?? "",
          blueEditNumberPackUsd:
              calculatedshelfprice?.data?.firstOrNull?.isEditable3 ?? false,
          caseUsd: calculatedshelfprice?.data?.firstOrNull?.caselvlUsd ?? "",
          blueEditNumberCaseUsd:
              calculatedshelfprice?.data?.firstOrNull?.isEditable4 ?? false,
          linkUsd: calculatedshelfprice?.data?.firstOrNull?.linklvlUsd ?? "",
          blueEditNumberLinkUsd:
              calculatedshelfprice?.data?.firstOrNull?.isEditable5 ?? false,
          volCad: calculatedshelfprice?.data?.firstOrNull?.vollvlCad ?? "",
          blueEditNumberVolCad:
              calculatedshelfprice?.data?.firstOrNull?.isEditable6 ?? false,
          packCad: calculatedshelfprice?.data?.firstOrNull?.packlvlCad ?? "",
          blueEditNumberPackCad:
              calculatedshelfprice?.data?.firstOrNull?.isEditable7 ?? false,
          linkCad: calculatedshelfprice?.data?.firstOrNull?.linklvlCad ?? "",
          blueEditNumberLinkCad:
              calculatedshelfprice?.data?.firstOrNull?.isEditable8 ?? false,
          caseCad: calculatedshelfprice?.data?.firstOrNull?.caselvlCad ?? "",
          blueEditNumberCaseCad:
              calculatedshelfprice?.data?.firstOrNull?.isEditable9 ?? false,
        );
      },
    );
  }
}

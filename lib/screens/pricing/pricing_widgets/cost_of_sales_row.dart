import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';

import '../../../themes/app_colors.dart';
import '../custom_pricing_widgets/custom_table_row.dart';

class CostOfSalesRow extends StatelessWidget {
  const CostOfSalesRow({
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
        var costOfSales =
            state.pricingData?.pricingWorksheetSegmentItems?.costofSales;
        // return CustomTableRowData(
        //   isReviewList: isReviewList,
        //   textColor: textColor,
        //   editTextColor: textColor,
        //   firstRowColor: color ?? AppColors.cream,
        //   secondRowColor: color ?? AppColors.lighterMaroon,
        //   thirdRowColor: color ?? AppColors.green,
        //   total: total ?? true,
        //   title: costOfSales?.title?.toUpperCase() ?? '',
        //   componentName: '',
        //   valueInUsd: costOfSales?.data?.firstOrNull?.valInUsd ?? '',
        //   blueEditNumberValueInUsd:
        //       costOfSales?.data?.firstOrNull?.isEditable1 ?? false,
        //   volUsd: costOfSales?.data?.firstOrNull?.volLvlUsd ?? '',
        //   blueEditNumberVolUsd:
        //       costOfSales?.data?.firstOrNull?.isEditable2 ?? false,
        //   packUsd: costOfSales?.data?.firstOrNull?.packlvlUsd ?? '',
        //   blueEditNumberPackUsd:
        //       costOfSales?.data?.firstOrNull?.isEditable3 ?? false,
        //   caseUsd: costOfSales?.data?.firstOrNull?.caselvlUsd ?? '',
        //   blueEditNumberCaseUsd:
        //       costOfSales?.data?.firstOrNull?.isEditable4 ?? false,
        //   linkUsd: costOfSales?.data?.firstOrNull?.linklvlUsd ?? '',
        //   blueEditNumberLinkUsd:
        //       costOfSales?.data?.firstOrNull?.isEditable5 ?? false,
        //   volCad: costOfSales?.data?.firstOrNull?.vollvlCad ?? '',
        //   blueEditNumberVolCad:
        //       costOfSales?.data?.firstOrNull?.isEditable6 ?? false,
        //   packCad: costOfSales?.data?.firstOrNull?.packlvlCad ?? '',
        //   blueEditNumberPackCad:
        //       costOfSales?.data?.firstOrNull?.isEditable7 ?? false,
        //   caseCad: costOfSales?.data?.firstOrNull?.caselvlCad ?? '',
        //   blueEditNumberCaseCad:
        //       costOfSales?.data?.firstOrNull?.isEditable8 ?? false,
        //   linkCad: costOfSales?.data?.firstOrNull?.linklvlCad ?? '',
        //   blueEditNumberLinkCad:
        //       costOfSales?.data?.firstOrNull?.isEditable9 ?? false,
        // );

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!---------Cost of sales Row

            ListView.builder(
              itemCount: costOfSales?.data?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) => CustomTableRowData(
                isReviewList: isReviewList,
                textColor: textColor,
                editTextColor: textColor,
                firstRowColor: color ?? AppColors.cream,
                secondRowColor: color ?? AppColors.lighterMaroon,
                thirdRowColor: color ?? AppColors.green,
                total: total ?? true,
                heading: costOfSales?.title ?? '',
                onSliderOneChange: (double value) {
                  context.read<PricingBloc>().add(
                        OnRetailSliderChange(
                          newValue: value,
                          isSlider1: true,
                        ),
                      );
                },
                onSliderTwoChange: (double value) {
                  context.read<PricingBloc>().add(
                        OnRetailSliderChange(
                          newValue: value,
                          isSlider1: false,
                        ),
                      );
                },
                title:
                    costOfSales?.data?.firstOrNull?.component?.toUpperCase() ??
                        '',
                componentName: costOfSales?.data?.firstOrNull?.componentName
                        ?.toUpperCase() ??
                    '',
                valueInUsd: costOfSales?.data?.firstOrNull?.valInUsd ?? '',
                blueEditNumberValueInUsd:
                    costOfSales?.data?.firstOrNull?.isEditable1 ?? false,
                volUsd: costOfSales?.data?.firstOrNull?.volLvlUsd ?? '',
                blueEditNumberVolUsd:
                    costOfSales?.data?.firstOrNull?.isEditable2 ?? false,
                packUsd: costOfSales?.data?.firstOrNull?.packlvlUsd ?? '',
                blueEditNumberPackUsd:
                    costOfSales?.data?.firstOrNull?.isEditable3 ?? false,
                caseUsd: costOfSales?.data?.firstOrNull?.caselvlUsd ?? '',
                blueEditNumberCaseUsd:
                    costOfSales?.data?.firstOrNull?.isEditable4 ?? false,
                linkUsd: costOfSales?.data?.firstOrNull?.linklvlUsd ?? '',
                blueEditNumberLinkUsd:
                    costOfSales?.data?.firstOrNull?.isEditable5 ?? false,
                volCad: costOfSales?.data?.firstOrNull?.vollvlCad ?? '',
                blueEditNumberVolCad:
                    costOfSales?.data?.firstOrNull?.isEditable6 ?? false,
                packCad: costOfSales?.data?.firstOrNull?.packlvlCad ?? '',
                blueEditNumberPackCad:
                    costOfSales?.data?.firstOrNull?.isEditable7 ?? false,
                caseCad: costOfSales?.data?.firstOrNull?.caselvlCad ?? '',
                blueEditNumberCaseCad:
                    costOfSales?.data?.firstOrNull?.isEditable8 ?? false,
                linkCad: costOfSales?.data?.firstOrNull?.linklvlCad ?? '',
                blueEditNumberLinkCad:
                    costOfSales?.data?.firstOrNull?.isEditable9 ?? false,
              ),
            ),
          ],
        );
      },
    );
  }
}

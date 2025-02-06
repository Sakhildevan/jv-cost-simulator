import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/pricing_bloc/pricing_bloc.dart';
import '../../../utils/string_const.dart';
import '../custom_pricing_widgets/custom_table_row.dart';
import '../custom_pricing_widgets/custom_table_row_heading.dart';

class SellingExpensesRow extends StatelessWidget {
  const SellingExpensesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        var sellingExpense =
            state.pricingData?.pricingWorksheetSegmentItems?.sellingExpense;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!---------Sell expense Row
            CustomTableRowHeading(
              heading: sellingExpense?.title ?? '',
            ),
            ListView.builder(
              itemCount: sellingExpense?.data?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) => CustomTableRowData(
                sliderSubtitle1: StringConst.taxIncludeInShelf,
                sliderSubtitle2: StringConst.retailMarginOnSales,
                heading: sellingExpense?.title ?? '',
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
                // sliderValue1: state.sliderValue1,
                // sliderValue2: state.sliderValue2,
                title: sellingExpense?.data?[index].component ?? '',
                componentName: sellingExpense?.data?[index].componentName ?? '',
                valueInUsd: sellingExpense?.data?[index].valInUsd ?? '',
                blueEditNumberValueInUsd:
                    sellingExpense?.data?[index].isEditable1 ?? false,
                volUsd: sellingExpense?.data?[index].volLvlUsd ?? '',
                blueEditNumberVolUsd:
                    sellingExpense?.data?[index].isEditable2 ?? false,
                packUsd: sellingExpense?.data?[index].packlvlUsd ?? '',
                blueEditNumberPackUsd:
                    sellingExpense?.data?[index].isEditable3 ?? false,
                caseUsd: sellingExpense?.data?[index].caselvlUsd ?? '',
                blueEditNumberCaseUsd:
                    sellingExpense?.data?[index].isEditable4 ?? false,
                linkUsd: sellingExpense?.data?[index].linklvlUsd ?? '',
                blueEditNumberLinkUsd:
                    sellingExpense?.data?[index].isEditable5 ?? false,
                volCad: sellingExpense?.data?[index].vollvlCad ?? '',
                blueEditNumberVolCad:
                    sellingExpense?.data?[index].isEditable6 ?? false,
                packCad: sellingExpense?.data?[index].packlvlCad ?? '',
                blueEditNumberPackCad:
                    sellingExpense?.data?[index].isEditable7 ?? false,
                caseCad: sellingExpense?.data?[index].caselvlCad ?? '',
                blueEditNumberCaseCad:
                    sellingExpense?.data?[index].isEditable8 ?? false,
                linkCad: sellingExpense?.data?[index].linklvlCad ?? '',
                blueEditNumberLinkCad:
                    sellingExpense?.data?[index].isEditable9 ?? false,
              ),
            ),
          ],
        );
      },
    );
  }
}

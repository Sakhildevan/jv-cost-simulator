import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';
import 'package:johnsonville_cost_simulator/screens/pricing/custom_pricing_widgets/custom_table_row.dart';
import 'package:johnsonville_cost_simulator/utils/string_const.dart';

import '../custom_pricing_widgets/custom_table_row_heading.dart';

class RetailTaxMargins extends StatelessWidget {
  const RetailTaxMargins({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        var retailTaxMargin =
            state.pricingData?.pricingWorksheetSegmentItems?.retailTaxMargin;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!---------Retail tax Margin Row
            CustomTableRowHeading(
              heading: retailTaxMargin?.title ?? '',
            ),
            ListView.builder(
              itemCount: retailTaxMargin?.data?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) => CustomTableRowData(
                sliderSubtitle1: StringConst.taxIncludeInShelf,
                sliderSubtitle2: StringConst.retailMarginOnSales,
                heading: retailTaxMargin?.title ?? '',
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
                title: retailTaxMargin?.data?[index].component ?? '',
                componentName:
                    retailTaxMargin?.data?[index].componentName ?? '',
                //TODO : need to change static condition
                valueInUsd: retailTaxMargin?.data?[index].component ==
                            'Tax excluded in Shelf Price' ||
                        retailTaxMargin?.data?[index].component ==
                            'Tax included in Shelf Price' ||
                        retailTaxMargin?.data?[index].component ==
                            'Price to Retailer'
                    ? '-'
                    : retailTaxMargin?.data?[index].valInUsd ?? '',
                blueEditNumberValueInUsd:
                    retailTaxMargin?.data?[index].isEditable1 ?? false,
                volUsd: retailTaxMargin?.data?[index].volLvlUsd ?? '',
                blueEditNumberVolUsd:
                    retailTaxMargin?.data?[index].isEditable2 ?? false,
                packUsd: retailTaxMargin?.data?[index].packlvlUsd ?? '',
                blueEditNumberPackUsd:
                    retailTaxMargin?.data?[index].isEditable3 ?? false,
                caseUsd: retailTaxMargin?.data?[index].caselvlUsd ?? '',
                blueEditNumberCaseUsd:
                    retailTaxMargin?.data?[index].isEditable4 ?? false,
                linkUsd: retailTaxMargin?.data?[index].linklvlUsd ?? '',
                blueEditNumberLinkUsd:
                    retailTaxMargin?.data?[index].isEditable5 ?? false,
                volCad: retailTaxMargin?.data?[index].vollvlCad ?? '',
                blueEditNumberVolCad:
                    retailTaxMargin?.data?[index].isEditable6 ?? false,
                packCad: retailTaxMargin?.data?[index].packlvlCad ?? '',
                blueEditNumberPackCad:
                    retailTaxMargin?.data?[index].isEditable7 ?? false,
                caseCad: retailTaxMargin?.data?[index].caselvlCad ?? '',
                blueEditNumberCaseCad:
                    retailTaxMargin?.data?[index].isEditable8 ?? false,
                linkCad: retailTaxMargin?.data?[index].linklvlCad ?? '',
                blueEditNumberLinkCad:
                    retailTaxMargin?.data?[index].isEditable9 ?? false,
              ),
            ),
          ],
        );
      },
    );
  }
}

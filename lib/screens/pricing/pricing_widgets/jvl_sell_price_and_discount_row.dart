import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';
import 'package:johnsonville_cost_simulator/screens/pricing/custom_pricing_widgets/custom_table_row.dart';
import 'package:johnsonville_cost_simulator/utils/string_const.dart';
import '../custom_pricing_widgets/custom_table_row_heading.dart';

class JvlSellPriceAndDiscountRow extends StatelessWidget {
  const JvlSellPriceAndDiscountRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        var jvlSellPriceDiscount = state
            .pricingData?.pricingWorksheetSegmentItems?.jvlsellpricediscount;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!---------JVL sell price and discount Row
            CustomTableRowHeading(
              heading: jvlSellPriceDiscount?.title ?? '',
            ),
            ListView.builder(
              itemCount: jvlSellPriceDiscount?.data?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) => CustomTableRowData(
                sliderSubtitle1: StringConst.taxIncludeInShelf,
                sliderSubtitle2: StringConst.retailMarginOnSales,
                heading: jvlSellPriceDiscount?.title ?? '',
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
                title: jvlSellPriceDiscount?.data?[index].component ?? '',
                componentName:
                    jvlSellPriceDiscount?.data?[index].componentName ?? '',
                valueInUsd: jvlSellPriceDiscount?.data?[index].valInUsd ?? '',
                blueEditNumberValueInUsd:
                    jvlSellPriceDiscount?.data?[index].isEditable1 ?? false,
                volUsd: jvlSellPriceDiscount?.data?[index].volLvlUsd ?? '',
                blueEditNumberVolUsd:
                    jvlSellPriceDiscount?.data?[index].isEditable2 ?? false,
                packUsd: jvlSellPriceDiscount?.data?[index].packlvlUsd ?? '',
                blueEditNumberPackUsd:
                    jvlSellPriceDiscount?.data?[index].isEditable3 ?? false,
                caseUsd: jvlSellPriceDiscount?.data?[index].caselvlUsd ?? '',
                blueEditNumberCaseUsd:
                    jvlSellPriceDiscount?.data?[index].isEditable4 ?? false,
                linkUsd: jvlSellPriceDiscount?.data?[index].linklvlUsd ?? '',
                blueEditNumberLinkUsd:
                    jvlSellPriceDiscount?.data?[index].isEditable5 ?? false,
                volCad: jvlSellPriceDiscount?.data?[index].vollvlCad ?? '',
                blueEditNumberVolCad:
                    jvlSellPriceDiscount?.data?[index].isEditable6 ?? false,
                packCad: jvlSellPriceDiscount?.data?[index].packlvlCad ?? '',
                blueEditNumberPackCad:
                    jvlSellPriceDiscount?.data?[index].isEditable7 ?? false,
                caseCad: jvlSellPriceDiscount?.data?[index].caselvlCad ?? '',
                blueEditNumberCaseCad:
                    jvlSellPriceDiscount?.data?[index].isEditable8 ?? false,
                linkCad: jvlSellPriceDiscount?.data?[index].linklvlCad ?? '',
                blueEditNumberLinkCad:
                    jvlSellPriceDiscount?.data?[index].isEditable9 ?? false,
              ),
            ),
          ],
        );
      },
    );
  }
}

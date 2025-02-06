import 'package:flutter/material.dart';

import '../../../utils/string_const.dart';
import '../custom_pricing_widgets/custom_table_row.dart';
import '../custom_pricing_widgets/custom_table_row_heading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';

class DeliveryAndSupplyChain extends StatelessWidget {
  const DeliveryAndSupplyChain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        var deliveryAndSupplyChain = state
            .pricingData?.pricingWorksheetSegmentItems?.deliveryAndSupplychain;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!---------Retail tax Margin Row
            CustomTableRowHeading(
              heading: deliveryAndSupplyChain?.title ?? '',
            ),
            ListView.builder(
              itemCount: deliveryAndSupplyChain?.data?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) => CustomTableRowData(
                sliderSubtitle1: StringConst.taxIncludeInShelf,
                sliderSubtitle2: StringConst.retailMarginOnSales,
                heading: deliveryAndSupplyChain?.title ?? '',
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
                title: deliveryAndSupplyChain?.data?[index].component ?? '',
                componentName:
                    deliveryAndSupplyChain?.data?[index].componentName ?? '',
                valueInUsd: deliveryAndSupplyChain?.data?[index].valInUsd ?? '',
                blueEditNumberValueInUsd:
                    deliveryAndSupplyChain?.data?[index].isEditable1 ?? false,
                volUsd: deliveryAndSupplyChain?.data?[index].volLvlUsd ?? '',
                blueEditNumberVolUsd:
                    deliveryAndSupplyChain?.data?[index].isEditable2 ?? false,
                packUsd: deliveryAndSupplyChain?.data?[index].packlvlUsd ?? '',
                blueEditNumberPackUsd:
                    deliveryAndSupplyChain?.data?[index].isEditable3 ?? false,
                caseUsd: deliveryAndSupplyChain?.data?[index].caselvlUsd ?? '',
                blueEditNumberCaseUsd:
                    deliveryAndSupplyChain?.data?[index].isEditable4 ?? false,
                linkUsd: deliveryAndSupplyChain?.data?[index].linklvlUsd ?? '',
                blueEditNumberLinkUsd:
                    deliveryAndSupplyChain?.data?[index].isEditable5 ?? false,
                volCad: deliveryAndSupplyChain?.data?[index].vollvlCad ?? '',
                blueEditNumberVolCad:
                    deliveryAndSupplyChain?.data?[index].isEditable6 ?? false,
                packCad: deliveryAndSupplyChain?.data?[index].packlvlCad ?? '',
                blueEditNumberPackCad:
                    deliveryAndSupplyChain?.data?[index].isEditable7 ?? false,
                caseCad: deliveryAndSupplyChain?.data?[index].caselvlCad ?? '',
                blueEditNumberCaseCad:
                    deliveryAndSupplyChain?.data?[index].isEditable8 ?? false,
                linkCad: deliveryAndSupplyChain?.data?[index].linklvlCad ?? '',
                blueEditNumberLinkCad:
                    deliveryAndSupplyChain?.data?[index].isEditable9 ?? false,
              ),
            ),
          ],
        );
      },
    );
  }
}

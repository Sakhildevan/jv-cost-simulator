import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';
import 'package:johnsonville_cost_simulator/screens/pricing/custom_pricing_widgets/custom_table_row.dart';
import 'package:johnsonville_cost_simulator/utils/string_const.dart';

class DistributorMarginRow extends StatelessWidget {
  const DistributorMarginRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        var distributorMargin =
            state.pricingData?.pricingWorksheetSegmentItems?.distributorMargin;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!---------Distributor Margin Row
            //TODO: commented for future use
            // CustomTableRowHeading(
            //   heading: distributorMargin?.title ?? '',
            // ),
            ListView.builder(
              itemCount: distributorMargin?.data?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) => CustomTableRowData(
                sliderSubtitle1: StringConst.taxIncludeInShelf,
                sliderSubtitle2: StringConst.retailMarginOnSales,
                heading: distributorMargin?.title ?? '',
                // heading: distributorMargin?.title ?? '',
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
                title: distributorMargin?.data?[index].component ?? '',
                componentName:
                    distributorMargin?.data?[index].componentName ?? '',
                //TODO : need to check the static condition
                valueInUsd: distributorMargin?.data?[index].component ==
                        'Distributor Price from JVL'
                    ? "-"
                    : (distributorMargin?.data?[index].valInUsd ?? ''),
                blueEditNumberValueInUsd:
                    distributorMargin?.data?[index].isEditable1 ?? false,
                volUsd: distributorMargin?.data?[index].volLvlUsd ?? '',
                blueEditNumberVolUsd:
                    distributorMargin?.data?[index].isEditable2 ?? false,
                packUsd: distributorMargin?.data?[index].packlvlUsd ?? '',
                blueEditNumberPackUsd:
                    distributorMargin?.data?[index].isEditable3 ?? false,
                caseUsd: distributorMargin?.data?[index].caselvlUsd ?? '',
                blueEditNumberCaseUsd:
                    distributorMargin?.data?[index].isEditable4 ?? false,
                linkUsd: distributorMargin?.data?[index].linklvlUsd ?? '',
                blueEditNumberLinkUsd:
                    distributorMargin?.data?[index].isEditable5 ?? false,
                volCad: distributorMargin?.data?[index].vollvlCad ?? '',
                blueEditNumberVolCad:
                    distributorMargin?.data?[index].isEditable6 ?? false,
                packCad: distributorMargin?.data?[index].packlvlCad ?? '',
                blueEditNumberPackCad:
                    distributorMargin?.data?[index].isEditable7 ?? false,
                caseCad: distributorMargin?.data?[index].caselvlCad ?? '',
                blueEditNumberCaseCad:
                    distributorMargin?.data?[index].isEditable8 ?? false,
                linkCad: distributorMargin?.data?[index].linklvlCad ?? '',
                blueEditNumberLinkCad:
                    distributorMargin?.data?[index].isEditable9 ?? false,
              ),
            ),
          ],
        );
      },
    );
  }
}

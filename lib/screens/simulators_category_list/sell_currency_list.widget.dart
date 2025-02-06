import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:johnsonville_cost_simulator/data/model/currency_list.model.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/simulator_category/simulator_category_bloc.dart';
import '../../config/config.dart';
import '../../styles/text_styles.dart';
import '../../themes/app_colors.dart';
import '../../utils/string_const.dart';

class SellCurrencyList extends StatelessWidget {
  const SellCurrencyList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ScrollController customScroll = ScrollController();

    return SizedBox(
      height: getValueForScreenType(
          context: context, mobile: 150, tablet: 200, desktop: 200),
      child: Column(
        children: [
          // Sell currency label
          KStyles().med(
            overflow: TextOverflow.visible,
            text: StringConst.sellCurrency,
            size: getValueForScreenType(
              context: context,
              mobile: 12,
              tablet: 14,
              desktop: 16,
            ),
            color: AppColors.kTextBlue,
          ),
          const Gap(5),
          Expanded(
            child: BlocBuilder<SimulatorCategoryBloc, SimulatorCategoryState>(
              builder: (context, state) {
                return Scrollbar(
                  thumbVisibility: true,
                  controller: customScroll,
                  child: ListView.builder(
                    controller: customScroll,
                    shrinkWrap: true,
                    itemCount: state.currencyList?.length ?? 0,
                    // separatorBuilder: (context, index) => Gap(
                    //   getValueForScreenType(
                    //     context: context,
                    //     mobile: 1,
                    //     tablet: 2.5,
                    //     desktop: 1,
                    //   ),
                    // ),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          // Radio button for currency selection
                          uiCon.radioButton(
                            scale: getValueForScreenType(
                              context: context,
                              mobile: 0.5,
                              tablet: 0.7,
                              desktop: .8,
                            ),
                            groupValue: state.selectedCurrVal,
                            value: state.currencyList?[index].currencyCode,
                            onChanged: (value) {
                              // Handle the selection logic for currency
                              context
                                  .read<SimulatorCategoryBloc>()
                                  .add(FilterSellCurrTapEvent(
                                    status: state.currencyList?[index] ??
                                        Currency(
                                          currencyCode:
                                              StringConst.all.toUpperCase(),
                                          currencyName:
                                              StringConst.all.toUpperCase(),
                                        ),
                                  ));
                            },
                          ),
                          // Currency code text display
                          KStyles().med(
                            text: state.currencyList?[index].currencyCode ?? '',
                            size: getValueForScreenType(
                              context: context,
                              mobile: 10,
                              tablet: 12,
                              desktop: 14,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

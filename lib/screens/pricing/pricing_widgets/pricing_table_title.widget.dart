import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../styles/text_styles.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/row_width.dart';

class PricingTableTitle extends StatelessWidget {
  const PricingTableTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        var pricingTableHeading = state.pricingData
            ?.pricingWorksheetSegmentItems?.pricingWorksheetTableHeadings;
        return IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: RowWidth(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: KStyles().bold(
                    text: pricingTableHeading?.itemDetailsVolume ?? "",
                    color: AppColors.maroon,
                    size: getValueForScreenType(
                      context: context,
                      mobile: 12,
                      tablet: 14,
                      desktop: 16,
                    ),
                  ),
                ),
              ),
              5.width,
              Expanded(
                child: RowWidth(
                  padding: const EdgeInsets.all(10),
                  color: AppColors.lightMaroon,
                  child: KStyles().bold(
                    text: pricingTableHeading?.usdBasis ?? "",
                    color: AppColors.maroon,
                    size: getValueForScreenType(
                      context: context,
                      mobile: 12,
                      tablet: 14,
                      desktop: 16,
                    ),
                  ),
                ),
              ),
              5.width,
              Expanded(
                child: RowWidth(
                  padding: const EdgeInsets.all(10),
                  color: AppColors.lightGreen,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: RichText(
                          text: TextSpan(children: [
                            //?note: Foreign was added here
                            TextSpan(
                              text: '',
                              // text: StringConst.foreign,
                              style: KStyles()
                                  .bold(
                                    text: '',
                                    textAlign: TextAlign.center,
                                    color: AppColors.headingTextBlue,
                                    size: getValueForScreenType(
                                      context: context,
                                      mobile: 12,
                                      tablet: 14,
                                      desktop: 16,
                                    ),
                                  )
                                  .style,
                            ),
                            TextSpan(
                              text:
                                  pricingTableHeading?.foreignCurrencyCadBasis,
                              style: KStyles()
                                  .bold(
                                    text: '',
                                    textAlign: TextAlign.center,
                                    color: AppColors.maroon,
                                    size: getValueForScreenType(
                                      context: context,
                                      mobile: 12,
                                      tablet: 14,
                                      desktop: 16,
                                    ),
                                  )
                                  .style,
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

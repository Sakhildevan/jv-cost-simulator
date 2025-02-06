import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../styles/text_styles.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/row_width.dart';

class PricingSubTitle extends StatelessWidget {
  const PricingSubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        var pricingSubTableHeading = state.pricingData
            ?.pricingWorksheetSegmentItems?.pricingWorksheetSubTableHeadings;

        return IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: RowWidth(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  color: AppColors.cream,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: KStyles().bold(
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.start,
                          text:
                              pricingSubTableHeading?.itemNameDescription ?? "",
                          size: getValueForScreenType(
                            context: context,
                            mobile: 9,
                            tablet: 12,
                            desktop: 13,
                          ),
                          color: AppColors.maroon,
                        ),
                      ),
                      Flexible(
                        child: KStyles().bold(
                          text: '',
                          // text: "Value : USD\nMetric : LBS",
                          size: getValueForScreenType(
                            context: context,
                            mobile: 8,
                            tablet: 11,
                            desktop: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              5.width,
              Expanded(
                child: RowWidth(
                  padding: const EdgeInsets.all(5),
                  color: AppColors.lighterMaroon,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _subtitleDoubleText(
                          context: context,
                          text: pricingSubTableHeading?.volumeLevelUsd ?? "",
                        ),
                      ),
                      Expanded(
                        child: _subtitleDoubleText(
                          context: context,
                          text: pricingSubTableHeading?.packageLevelUsd ?? "",
                        ),
                      ),
                      Expanded(
                        child: _subtitleDoubleText(
                          context: context,
                          text: pricingSubTableHeading?.caseLevelUsd ?? "",
                        ),
                      ),
                      Expanded(
                        child: _subtitleDoubleText(
                          context: context,
                          text: pricingSubTableHeading?.linkLevelUsd ?? "",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              5.width,
              Expanded(
                child: RowWidth(
                  padding: const EdgeInsets.all(5),
                  color: AppColors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _subtitleDoubleText(
                          context: context,
                          text: pricingSubTableHeading?.volumeLevelCad ?? "",
                        ),
                      ),
                      Expanded(
                        child: _subtitleDoubleText(
                          context: context,
                          text: pricingSubTableHeading?.packageLevelCad ?? "",
                        ),
                      ),
                      Expanded(
                        child: _subtitleDoubleText(
                          context: context,
                          text: pricingSubTableHeading?.caseLevelCad ?? "",
                        ),
                      ),
                      Expanded(
                        child: _subtitleDoubleText(
                          context: context,
                          text: pricingSubTableHeading?.linkLevelCad ?? "",
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

Widget _subtitleDoubleText({String? text, required BuildContext context}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      KStyles().bold(
        text: text ?? '',
        textAlign: TextAlign.center,
        size: getValueForScreenType(
          context: context,
          mobile: 8,
          tablet: 11,
          desktop: 12,
        ),
        overflow: TextOverflow.visible,
      ),
    ],
  );
}

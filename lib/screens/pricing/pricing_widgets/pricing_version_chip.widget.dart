import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../themes/app_colors.dart';

class CustomPricingChip extends StatelessWidget {
  const CustomPricingChip({
    required this.label,
    required this.textColor,
    required this.color,
    required this.borderColor,
    super.key,
    this.onDeleteTap,
    this.onTap,
    this.overflow,
    this.isLoading,
    this.showDelete,
  });
  final String label;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final TextOverflow? overflow;
  final void Function()? onDeleteTap;
  final void Function()? onTap;
  final bool? isLoading;
  final bool? showDelete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: kDim.kRadius05,
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: onTap,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: KStyles().semiBold(
                        overflow: overflow,
                        size: getValueForScreenType(
                          context: context,
                          mobile: 8,
                          tablet: 9,
                          desktop: 14,
                        ),
                        color: textColor,
                        text: label,
                      ),
                    ),
                    // kDim.kGap08,
                    // getValueForScreenType(
                    //   context: context,
                    //   mobile: kDim.kGap05,
                    //   tablet: kDim.kGap08,
                    //   desktop: kDim.kGap10,
                    // ),
                  ],
                ),
              ),
              (isLoading ?? false)
                  ? uiCon.circleLoader(color: AppColors.maroon)
                  : (showDelete ?? false)
                      ? InkWell(
                          onTap: onDeleteTap,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: kDim.kRadius10,
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                size: getValueForScreenType(
                                  context: context,
                                  mobile: 8,
                                  tablet: 9,
                                  desktop: 12,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

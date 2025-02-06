import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../themes/app_colors.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    required this.label,
    required this.textColor,
    required this.color,
    required this.borderColor,
    super.key,
    this.onDeleteTap,
    this.overflow,
  });
  final String label;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final TextOverflow? overflow;
  final void Function()? onDeleteTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: kDim.kRadius50,
          color: color,
          // color: AppColors.chipColor,
          // border: Border.all(
          //   width: 0.5,
          //   color: borderColor,
          //   // color: AppColors.chipBorderColor,
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: KStyles().reg(
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
              getValueForScreenType(
                context: context,
                mobile: kDim.kGap05,
                tablet: kDim.kGap08,
                desktop: kDim.kGap20,
              ),
              InkWell(
                onTap: onDeleteTap,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: kDim.kRadius100,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

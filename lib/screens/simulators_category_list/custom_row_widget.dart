import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../styles/text_styles.dart';
import '../../themes/app_colors.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.text,
    required this.asset,
  });
  final String text;
  final String asset;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        KStyles().semiBold(
          text: text.toUpperCase(),

          size: getValueForScreenType(
            context: context,
            mobile: 12,
            tablet: 14,
            desktop: 16,
          ),
          // fontSize: 22,
        ),
        const Gap(5),
        uiCon.svgIcon(
          ht: getValueForScreenType(
            context: context,
            mobile: 14,
            tablet: 16,
            desktop: 20,
          ),
          wd: getValueForScreenType(
            context: context,
            mobile: 14,
            tablet: 16,
            desktop: 20,
          ),
          assetImage: asset,
          color: AppColors.kTextBlue,
        ),
      ],
    );
  }
}

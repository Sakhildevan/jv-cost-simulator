import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../config/config.dart';
import '../gen/assets.gen.dart';
import '../styles/text_styles.dart';
import '../themes/app_colors.dart';
import '../utils/string_const.dart';

class SliderIndicatorTitle extends StatelessWidget {
  const SliderIndicatorTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KStyles().bold(
          text: StringConst.sensitiveAnalysis,
          color: AppColors.headingTextBlue,
          size: getValueForScreenType(
            context: context,
            mobile: 8,
            tablet: 10,
            desktop: 15,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            uiCon.svgIcon(
              ht: 8,
              wd: 8,
              assetImage: Assets.icons.up,
              color: AppColors.headingTextBlue,
            ),
            getValueForScreenType(
              context: context,
              mobile: const Gap(1),
              tablet: const Gap(2),
              desktop: const Gap(5),
            ),
            // 5.width,
            KStyles().bold(
              text: StringConst.or,
              color: AppColors.black,
              size: getValueForScreenType(
                context: context,
                mobile: 6,
                tablet: 9,
                desktop: 11,
              ),
            ),
            getValueForScreenType(
              context: context,
              mobile: const Gap(1),
              tablet: const Gap(2),
              desktop: const Gap(5),
            ),
            // 5.width,
            uiCon.svgIcon(
              ht: 8,
              wd: 8,
              assetImage: Assets.icons.down,
              color: AppColors.maroon,
            ),
            getValueForScreenType(
              context: context,
              mobile: const Gap(1),
              tablet: const Gap(2),
              desktop: const Gap(5),
            ),
            // 5.width,
            KStyles().bold(
              text: StringConst.toSeeImpact,
              color: AppColors.black,
              size: getValueForScreenType(
                context: context,
                mobile: 6,
                tablet: 9,
                desktop: 11,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

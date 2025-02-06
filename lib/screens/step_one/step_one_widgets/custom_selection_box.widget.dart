import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../styles/text_styles.dart';
import '../../../themes/app_colors.dart';

class CustomSelectionRow extends StatelessWidget {
  const CustomSelectionRow({
    super.key,
    required this.firstOption,
    required this.secondOption,
    required this.selectedOption,
    required this.onTap,
    required this.isMetricEmpty,
    this.isStepOne,
  });
  final String firstOption;
  final String secondOption;
  final String selectedOption;
  final bool isMetricEmpty;
  final bool? isStepOne;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
              onTap: () => onTap(firstOption),
              child: _buildOptionBox(
                context: context,
                text: firstOption,
                isSelected: selectedOption == firstOption,
                isMetricEmpty: isMetricEmpty,
              )),
        ),
        const Gap(5),
        Expanded(
          child: InkWell(
            onTap: () => onTap(secondOption),
            child: _buildOptionBox(
              context: context,
              text: secondOption,
              isSelected: selectedOption == secondOption,
              isMetricEmpty: isMetricEmpty,
            ),
          ),
        ),
        (isStepOne ?? false)
            ? getValueForScreenType(
                context: context,
                mobile: kDim.kGap20,
                tablet: kDim.kGap20,
                desktop: kDim.kGap25,
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Container _buildOptionBox({
    required BuildContext context,
    required String text,
    required bool isSelected,
    required bool isMetricEmpty,
  }) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(
            color: isMetricEmpty ? AppColors.maroon : AppColors.grey),
        borderRadius: kDim.kRadius04,
        color: isSelected ? AppColors.maroon : AppColors.lightGrey,
      ),
      child: Center(
        child: KStyles().reg(
          size: getValueForScreenType(
            context: context,
            mobile: 10,
            tablet: 12,
            desktop: 14,
          ),
          text: text,
          color: isSelected ? AppColors.white : AppColors.grey,
        ),
      ),
    );
  }
}

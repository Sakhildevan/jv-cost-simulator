import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:johnsonville_cost_simulator/widgets/row_width.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../styles/text_styles.dart';
import '../../../themes/app_colors.dart';

class CustomTableRowHeading extends StatelessWidget {
  const CustomTableRowHeading({super.key, required this.heading});
  final String heading;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: RowWidth(
              padding: EdgeInsets.only(
                top: 10,
                left: getValueForScreenType(
                  context: context,
                  mobile: 5,
                  tablet: 5,
                  desktop: 10,
                ),
              ),
              alignment: Alignment.centerLeft,
              child: KStyles().black(
                text: heading,
                color: AppColors.maroon,
                size: getValueForScreenType(
                  context: context,
                  mobile: 10,
                  tablet: 13,
                  desktop: 13,
                ),
              ),
            ),
          ),
          5.width,
          const Expanded(
              child: RowWidth(
            color: AppColors.lightMaroon,
          )),
          5.width,
          const Expanded(
            child: RowWidth(
              color: AppColors.lightGreen,
            ),
          ),
        ],
      ),
    );
  }
}

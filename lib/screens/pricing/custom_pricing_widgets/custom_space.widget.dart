import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:johnsonville_cost_simulator/widgets/row_width.dart';

import '../../../themes/app_colors.dart';

class CustomSpace extends StatelessWidget {
  const CustomSpace({
    super.key,
    this.height,
  });
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 10,
      child: Row(
        children: [
          const Expanded(
            child: RowWidth(),
          ),
          5.width,
          const Expanded(
            child: RowWidth(
              color: AppColors.lightMaroon,
            ),
          ),
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
// firstRowColor: color ?? AppColors.cream,
                // secondRowColor: color ?? AppColors.lighterMaroon,
                // thirdRowColor: color ?? AppColors.green,
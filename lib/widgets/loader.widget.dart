import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/themes/app_colors.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return uiCon.bounceLoader(
      loaderSize: 50,
      color: AppColors.lightGreen,
    );
  }
}

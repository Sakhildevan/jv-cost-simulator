import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../themes/app_colors.dart';
import '../utils/string_const.dart';

class CustomTableTitleViewAll extends StatelessWidget {
  //text for the last created simulator
  final String lastCreatedText;
  //function to be called when view all button is pressed
  final void Function()? onPressed;

  const CustomTableTitleViewAll({
    super.key,
    required this.lastCreatedText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildLastCreatedText(context, lastCreatedText),
        buildViewAllButton(
          context,
          onPressed,
        ),
      ],
    );
  }

  Text buildLastCreatedText(BuildContext context, String lastCreatedText) {
    return Text(
      lastCreatedText,
      style: TextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 12,
          tablet: 12,
          desktop: 16,
        ),
        fontWeight: FontWeight.bold,
        color: AppColors.kTextBlue,
      ),
    );
  }

  TextButton buildViewAllButton(
      BuildContext context, void Function()? onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        StringConst.viewAll,
        style: TextStyle(
            fontSize: getValueForScreenType(
              context: context,
              mobile: 12,
              tablet: 14,
              desktop: 16,
            ),
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline),
      ),
    );
  }
}

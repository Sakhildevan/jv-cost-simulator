// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/utils/string_const.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../config/config.dart';
import '../styles/text_styles.dart';
import '../themes/app_colors.dart';

class CustomDialogBox extends StatelessWidget {
  final dynamic state;
  final String? title;
  final String? subTitle;
  final String? backButtonText;
  final String? continueButtonText;

  final bool? isLoading;
  final void Function()? onPressed;

  const CustomDialogBox({
    super.key,
    this.state,
    this.title,
    this.subTitle,
    this.backButtonText,
    this.continueButtonText,
    this.onPressed,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: kDim.kRadius15,
        color: AppColors.cardCream,
      ),
      // height: 260,
      width: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center, // Center other content
        children: [
          Align(
            alignment: Alignment.topRight, // Align icon to the right
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close_rounded,
                color: AppColors.maroon,
              ),
            ),
          ),
          kDim.kGap05,
          KStyles().bold(
            text: title ?? '',
            color: AppColors.maroon,
            size: getValueForScreenType(
              context: context,
              mobile: 18,
              tablet: 25,
              desktop: 30,
            ),
          ),
          kDim.kGap10,
          KStyles().med(
            textAlign: TextAlign.center,
            text: subTitle ?? '',
            color: AppColors.black,
            size: getValueForScreenType(
              context: context,
              mobile: 15,
              tablet: 18,
              desktop: 20,
            ),
            overflow: TextOverflow.visible,
          ),
          kDim.kGap20,
          //const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              kDim.kGap10,
              Expanded(
                //back button
                child: uiCon.simButton(
                  color: AppColors.buttonColor,
                  height: getValueForScreenType(
                    context: context,
                    mobile: 30,
                    tablet: 40,
                    desktop: 50,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const SizedBox.shrink(),
                  text: backButtonText ?? StringConst.cancel,
                  fontSize: getValueForScreenType(
                    context: context,
                    mobile: 12,
                    tablet: 15,
                    desktop: 18,
                  ),
                ),
              ),
              kDim.kGap05,
              //continue button
              Expanded(
                child: uiCon.simButton(
                  isLoading: isLoading,
                  height: getValueForScreenType(
                    context: context,
                    mobile: 30,
                    tablet: 40,
                    desktop: 50,
                  ),
                  onPressed: onPressed,
                  child: const SizedBox.shrink(),
                  text: continueButtonText ??
                      StringConst.continueText.toUpperCase(),
                  fontSize: getValueForScreenType(
                    context: context,
                    mobile: 12,
                    tablet: 15,
                    desktop: 18,
                  ),
                ),
              ),
              kDim.kGap05,
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/utils/constants.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../styles/text_styles.dart';
import '../../../themes/app_colors.dart';

import '../../../widgets/row_width.dart';
import 'pricing_number_widget.dart';

class CustomTableRowData extends StatelessWidget {
  const CustomTableRowData({
    super.key,
    required this.title,
    required this.componentName,
    this.valueInUsd,
    this.isReviewList,
    this.volUsd,
    this.packUsd,
    this.caseUsd,
    this.linkUsd,
    this.volCad,
    this.packCad,
    this.caseCad,
    this.linkCad,
    this.firstRowColor,
    this.secondRowColor,
    this.thirdRowColor,
    this.textColor,
    this.isPercent,
    this.blueEditNumberVolUsd = false,
    this.total = false,
    this.totalPercent = false,
    this.blueEditNumberPackUsd = false,
    this.blueEditNumberCaseUsd = false,
    this.blueEditNumberLinkUsd = false,
    this.blueEditNumberVolCad = false,
    this.blueEditNumberPackCad = false,
    this.blueEditNumberCaseCad = false,
    this.blueEditNumberLinkCad = false,
    this.blueEditNumberValueInUsd = false,
    this.onSliderOneChange,
    this.onSliderTwoChange,
    this.sliderValue1,
    this.sliderValue2,
    this.saveOnPressed,
    this.heading,
    this.sliderSubtitle1,
    this.sliderSubtitle2,
    this.editTextColor,
  });
  final Color? firstRowColor;
  final Color? secondRowColor;
  final Color? thirdRowColor;
  final Color? textColor;
  final Color? editTextColor;
  final String title;
  final String componentName;
  final String? valueInUsd;
  final String? volUsd;
  final String? packUsd;
  final String? caseUsd;
  final String? linkUsd;
  final String? volCad;
  final String? packCad;
  final String? caseCad;
  final String? linkCad;
  final String? heading;
  final String? sliderSubtitle1;
  final String? sliderSubtitle2;
  final bool total;
  final bool? isPercent;
  final bool? isReviewList;
  final bool totalPercent;
  final bool blueEditNumberVolUsd;
  final bool blueEditNumberPackUsd;
  final bool blueEditNumberCaseUsd;
  final bool blueEditNumberLinkUsd;
  final bool blueEditNumberValueInUsd;
  final bool blueEditNumberVolCad;
  final bool blueEditNumberPackCad;
  final bool blueEditNumberCaseCad;
  final bool blueEditNumberLinkCad;
  final void Function(double)? onSliderOneChange;
  final void Function(double)? onSliderTwoChange;
  final void Function()? saveOnPressed;
  final double? sliderValue1;
  final double? sliderValue2;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: _textWithoutIcon(
              context,
            ),
          ),
          5.width,
          // !-----------------usdBasisColumn----------------
          _usdBasisColumn(context),
          5.width,
          // !-----------------foreign CurrencyColumn----------------
          _foreignCurrencyColumn(context),
        ],
      ),
    );
  }

//!-----------------textWithoutIcon----------------
  RowWidth _textWithoutIcon(
    BuildContext context,
  ) {
    return RowWidth(
      color: firstRowColor,
      padding: EdgeInsets.symmetric(
        horizontal: getValueForScreenType(
          context: context,
          mobile: 10,
          tablet: 15,
          desktop: 20,
        ),
      ),
      //  total
      //     ? EdgeInsets.symmetric(
      //         vertical: 4,
      //         horizontal: getValueForScreenType(
      //           context: context,
      //           mobile: 5,
      //           tablet: 5,
      //           desktop: 10,
      //         ),
      //       )
      //     : EdgeInsets.symmetric(
      //         horizontal: getValueForScreenType(
      //           context: context,
      //           mobile: 10,
      //           tablet: 15,
      //           desktop: 20,
      //         ),
      //       ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: total
                ? KStyles().bold(
                    overflow: TextOverflow.visible,
                    text: title,
                    size: getValueForScreenType(
                      context: context,
                      mobile: 8,
                      tablet: 11,
                      desktop: 14,
                    ),
                    color: textColor ?? AppColors.maroon,
                  )
                : KStyles().med(
                    overflow: TextOverflow.visible,
                    text: title,
                    size: getValueForScreenType(
                      context: context,
                      mobile: 8,
                      tablet: 11,
                      desktop: 14,
                    ),
                    color: textColor ?? AppColors.black,
                  ),
          ),
          PricingNumberWidget(
            isReviewList: isReviewList,
            componentName: componentName,
            subTitle: title,
            heading: heading,
            editTextColor: editTextColor,
            totalPercent: totalPercent,
            total: total,
            number: valueInUsd,
            textColor: textColor,
            blueEditNumber: blueEditNumberValueInUsd,
          ),
        ],
      ),
    );
  }

//!-----------------foreignCurrencyColumn----------------
  Expanded _foreignCurrencyColumn(BuildContext context) {
    return Expanded(
      child: RowWidth(
        color: thirdRowColor ?? AppColors.lightGreen,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PricingNumberWidget(
              isReviewList: isReviewList,
              subTitle: title,
              componentName: componentName,
              heading: heading,
              editTextColor: editTextColor,
              total: total,
              totalPercent: totalPercent,
              number: volCad,
              textColor: textColor,
              blueEditNumber: blueEditNumberVolCad,
            ),
            commonWidth(context),
            PricingNumberWidget(
              isReviewList: isReviewList,
              subTitle: title,
              componentName: componentName,
              heading: heading,
              editTextColor: editTextColor,
              total: total,
              totalPercent: totalPercent,
              textColor: textColor,
              number: packCad,
              blueEditNumber: blueEditNumberPackCad,
            ),
            commonWidth(context),
            PricingNumberWidget(
              isReviewList: isReviewList,
              subTitle: title,
              componentName: componentName,
              heading: heading,
              editTextColor: editTextColor,
              total: total,
              totalPercent: totalPercent,
              number: caseCad,
              textColor: textColor,
              blueEditNumber: blueEditNumberCaseCad,
            ),
            commonWidth(context),
            PricingNumberWidget(
              isReviewList: isReviewList,
              subTitle: title,
              componentName: componentName,
              heading: heading,
              editTextColor: editTextColor,
              total: total,
              totalPercent: totalPercent,
              number: linkCad,
              textColor: textColor,
              blueEditNumber: blueEditNumberLinkCad,
            ),
            commonWidth(context),
          ],
        ),
      ),
    );
  }

//!----------------UsdBasisColumn----------------
  Expanded _usdBasisColumn(BuildContext context) {
    return Expanded(
      child: RowWidth(
        color: secondRowColor ?? AppColors.lightMaroon,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PricingNumberWidget(
              isReviewList: isReviewList,
              subTitle: title,
              componentName: componentName,
              heading: heading,
              editTextColor: editTextColor,
              total: total,
              totalPercent: totalPercent,
              number: volUsd,
              textColor: textColor,
              blueEditNumber: blueEditNumberVolUsd,
            ),
            commonWidth(context),
            PricingNumberWidget(
              isReviewList: isReviewList,
              subTitle: title,
              componentName: componentName,
              heading: heading,
              editTextColor: editTextColor,
              total: total,
              totalPercent: totalPercent,
              number: packUsd,
              textColor: textColor,
              blueEditNumber: blueEditNumberPackUsd,
            ),
            commonWidth(context),
            PricingNumberWidget(
              isReviewList: isReviewList,
              subTitle: title,
              componentName: componentName,
              heading: heading,
              editTextColor: editTextColor,
              total: total,
              totalPercent: totalPercent,
              number: caseUsd,
              textColor: textColor,
              blueEditNumber: blueEditNumberCaseUsd,
            ),
            commonWidth(context),
            PricingNumberWidget(
              isReviewList: isReviewList,
              subTitle: title,
              componentName: componentName,
              heading: heading,
              editTextColor: editTextColor,
              total: total,
              totalPercent: totalPercent,
              number: linkUsd,
              textColor: textColor,
              blueEditNumber: blueEditNumberLinkUsd,
            ),
            commonWidth(context),
          ],
        ),
      ),
    );
  }

  Widget commonWidth(BuildContext context) {
    return getValueForScreenType(
      context: context,
      mobile: kDim.kGap02,
      tablet: kDim.kGap02,
      desktop: SizedBox(
        width: Constants.width * .015,
      ),
    );
  }
}

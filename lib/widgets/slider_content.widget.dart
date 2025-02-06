import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../gen/assets.gen.dart';
import '../styles/text_styles.dart';
import '../themes/app_colors.dart';
import '../utils/constants.dart';
import '../utils/string_const.dart';
import 'custom_slider_widget.dart';

//!------------------------------------SliderContent Page-----------------------------------------
class SliderContent extends StatelessWidget {
  const SliderContent({
    super.key,
    this.sliderValue1,
    this.sliderValue2,
    this.onSliderOneChange,
    this.onSliderTwoChange,
    this.sliderSubtitle1,
    this.sliderSubtitle2,
  });

  final double? sliderValue1;
  final double? sliderValue2;
  final void Function(double)? onSliderOneChange;
  final void Function(double)? onSliderTwoChange;
  final String? sliderSubtitle1;
  final String? sliderSubtitle2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //!----------Pricing popup left side----------------
          pricingPopupLeftSection(context),
          //!------------Pricing popup right section--------------
          pricingPopupRightSection(context),
        ],
      ),
    );
  }

//!-----------------pricingPopupLeftSection----------------
  SizedBox pricingPopupLeftSection(BuildContext context) {
    return SizedBox(
      width: getValueForScreenType(
        context: context,
        mobile: Constants.width * .35,
        desktop: Constants.width * .18,
        tablet: Constants.width * .18,
      ),
      //!----------Column----------------
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //!----------sub-title and value----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getValueForScreenType(
                  context: context,
                  mobile: Constants.width * .25,
                  desktop: Constants.width * .12,
                  tablet: Constants.width * .12,
                ),
                //!----------sliderSubtitle----------------
                child: KStyles().bold(
                  text: sliderSubtitle1 ?? '',
                  color: AppColors.maroon,
                  size: getValueForScreenType(
                    context: context,
                    mobile: 9,
                    tablet: 9,
                    desktop: 13,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
              //!----------value----------------
              Container(
                alignment: Alignment.center,
                color: AppColors.lightGrey,
                width: getValueForScreenType(
                  context: context,
                  mobile: 25,
                  tablet: 25,
                  desktop: 50,
                ),
                height: 20,
                //displaying the value of the slider
                child: KStyles().bold(
                  text: sliderValue1?.toStringAsFixed(2) ?? "0.00",
                  color: AppColors.maroon,
                  size: getValueForScreenType(
                    context: context,
                    mobile: 9,
                    tablet: 9,
                    desktop: 13,
                  ),
                ),
              )
            ],
          ),
          15.height,
          //!----------2 sub-title & value Row----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //!----------sub-title----------------
              SizedBox(
                width: getValueForScreenType(
                  context: context,
                  mobile: Constants.width * .25,
                  desktop: Constants.width * .12,
                  tablet: Constants.width * .12,
                ),
                child: KStyles().bold(
                  overflow: TextOverflow.visible,
                  text: sliderSubtitle2 ?? '',
                  color: AppColors.maroon,
                  size: getValueForScreenType(
                    context: context,
                    mobile: 9,
                    tablet: 9,
                    desktop: 13,
                  ),
                ),
              ),
              //!----------value----------------
              Container(
                alignment: Alignment.center,
                color: AppColors.lightGrey,
                width: getValueForScreenType(
                  context: context,
                  mobile: 25,
                  tablet: 25,
                  desktop: 50,
                ),
                height: 20,
                //displaying the value of the slider
                child: KStyles().bold(
                  text: sliderValue2?.toStringAsFixed(2) ?? "0.00",
                  color: AppColors.maroon,
                  size: getValueForScreenType(
                    context: context,
                    mobile: 9,
                    tablet: 9,
                    desktop: 13,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

//!----------Pricing popup right section----------------
  SizedBox pricingPopupRightSection(BuildContext context) {
    return SizedBox(
      width: getValueForScreenType(
        context: context,
        mobile: Constants.width * .3,
        desktop: Constants.width * .15,
        tablet: Constants.width * .18,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //!--------title---------------
          KStyles().bold(
            text: StringConst.sensitiveAnalysis,
            color: AppColors.headingTextBlue,
            size: getValueForScreenType(
              context: context,
              mobile: 10,
              tablet: 10,
              desktop: 15,
            ),
          ),
          //!-----------sliderSubtitle--------------
          // KStyles().bold(
          //   text: StringConst.toSeeImpact,
          //   color: AppColors.black,
          //   size: getValueForScreenType(
          //     context: context,
          //     mobile: 7,
          //     tablet: 7,
          //     desktop: 9,
          //   ),
          // ),
          Row(
            children: [
              uiCon.svgIcon(
                ht: 8,
                wd: 8,
                assetImage: Assets.icons.up,
                color: AppColors.headingTextBlue,
              ),
              5.width,
              KStyles().bold(
                text: StringConst.or,
                color: AppColors.black,
                size: getValueForScreenType(
                  context: context,
                  mobile: 7,
                  tablet: 9,
                  desktop: 11,
                ),
              ),
              5.width,
              uiCon.svgIcon(
                ht: 8,
                wd: 8,
                assetImage: Assets.icons.down,
                color: AppColors.maroon,
              ),
              5.width,
              KStyles().bold(
                text: StringConst.toSeeImpact,
                color: AppColors.black,
                size: getValueForScreenType(
                  context: context,
                  mobile: 7,
                  tablet: 9,
                  desktop: 11,
                ),
              ),
            ],
          ),
          10.height,
          //!----------CustomSlider----------------
          SizedBox(
            height: getValueForScreenType(
              context: context,
              mobile: 20,
              tablet: 18,
              desktop: 28,
            ),
            child: CustomSlider(
              min: 0,
              max: 100,
              divisions: 200,
              onChanged: onSliderOneChange,
              //label: sliderValue1?.toStringAsFixed(2) ?? "0.00",
              sliderValue: sliderValue1 ?? 0,
            ),
          ),
          15.height,
          //!----------CustomSlider----------------
          SizedBox(
            height: getValueForScreenType(
              context: context,
              mobile: 20,
              tablet: 18,
              desktop: 28,
            ),
            child: CustomSlider(
              min: 0,
              max: 100,
              divisions: 200,
              onChanged: onSliderTwoChange,
              //label: sliderValue2?.toStringAsFixed(2) ?? "0.00",
              sliderValue: sliderValue2 ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}

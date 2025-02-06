import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/pricing_bloc/pricing_bloc.dart';
import '../../../styles/text_styles.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/string_const.dart';
import '../../../widgets/custom_text_field.widget.dart';

//!------------------------------------SliderContent Page-----------------------------------------
class PricingSlider extends StatelessWidget {
  const PricingSlider({
    super.key,
    this.onSliderChange,
    this.sliderSubtitle,
    this.onChanged,
    this.inputFormat,
    required this.textCtrl,
  });

  final void Function(double)? onSliderChange;
  final String? sliderSubtitle;

  final void Function(String)? onChanged;
  final TextEditingController textCtrl;
  final List<TextInputFormatter>? inputFormat;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //!----------Pricing popup left side----------------
              pricingPopupLeftSection(context, state),
              //!------------Pricing popup right section--------------
              pricingPopupRightSection(context, textCtrl, state),
            ],
          ),
        );
      },
    );
  }

//!-----------------pricingPopupLeftSection----------------
  SizedBox pricingPopupLeftSection(BuildContext context, PricingState state) {
    return SizedBox(
      //!----------Column----------------
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //*--------saving status is failed then display the error message
          state.isSaveError ?? false
              ? SizedBox(
                  height: getValueForScreenType(
                    context: context,
                    mobile: 10,
                    tablet: 10,
                    desktop: 17,
                  ),
                )
              : const SizedBox(),
          //!----------sub-title and value----------------
          KStyles().bold(
            text: sliderSubtitle ?? '',
            color: AppColors.maroon,
            size: getValueForScreenType(
              context: context,
              mobile: 9,
              tablet: 9,
              desktop: 13,
            ),
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }

//!----------Pricing popup right section----------------
  SizedBox pricingPopupRightSection(
    BuildContext context,
    TextEditingController textCtrl,
    PricingState state,
  ) {
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
          //*--------saving status is failed then display the error message
          (state.isSaveError ?? false)
              ? KStyles().med(
                  color: AppColors.red,
                  text: StringConst.pleasetryAgain,
                  size: getValueForScreenType(
                    context: context,
                    mobile: 10,
                    tablet: 10,
                    desktop: 14,
                  ),
                )
              : const SizedBox(),
          //!----------CustomTextField----------------
          CustomTextField(
            isError: state.isSaveError,
            height: getValueForScreenType(
              context: context,
              mobile: 20,
              tablet: 18,
              desktop: 28,
            ),
            cursorheight: 17,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            inputFormat: inputFormat,
            // textCtrl.text.contains("%")
            //     ? <TextInputFormatter>[
            //         FilteringTextInputFormatter.allow(
            //           RegExp(r'^\d*\.?\d{0,2}'),
            //         ),
            //       ]
            //     : <TextInputFormatter>[
            //         DecimalFormatter(decimalDigits: 2),
            //       ],
            controller: textCtrl,
            onChanged: onChanged,
            enabled: true,
          ),
        ],
      ),
    );
  }
}

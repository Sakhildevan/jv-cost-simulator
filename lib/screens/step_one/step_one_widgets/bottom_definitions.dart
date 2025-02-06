import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:johnsonville_cost_simulator/gen/assets.gen.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/constants.dart';
import '../../../utils/global_extensions.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/string_const.dart';

class BottomDefinitions extends StatelessWidget {
  const BottomDefinitions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KStyles().bold(
          text: StringConst.definitions,
          color: AppColors.headingTextBlue,
          size: 14,
        ),
        _contentWithDefinitions(context),
      ],
    );
  }

  Row _contentWithDefinitions(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _bottomDefCustom(
          image: Assets.images.costSimulator.path,
          text: StringConst.costSimulatorUsageDefinition,
          title: StringConst.costSimulatorUsage,
          context: context,
        ),
        getValueForScreenType(
          context: context,
          mobile: 0.width,
          tablet: 0.width,
          desktop: Constants.width <= 1050 ? 20.width : 50.width,
        ),
        _bottomDefCustom(
          image: Assets.images.metricConvertion.path,
          text: StringConst.metricConversionsDefinitions,
          title: StringConst.metricConversions,
          context: context,
        ),
        _bottomDefCustom(
          image: Assets.images.exchangePlans.path,
          text: StringConst.exchangeRatesDefinitions,
          title: StringConst.exchangeRates,
          context: context,
        ),
        getValueForScreenType(
          context: context,
          mobile: 0.width,
          tablet: 0.width,
          desktop: Constants.width <= 1050 ? 20.width : 50.width,
        ),
        _bottomDefCustom(
          image: Assets.images.referenceLookup.path,
          text: StringConst.referenceLookUpOptionsDefinitions,
          title: StringConst.referenceLookUpOptions,
          context: context,
        ),
      ],
    );
  }

  Widget _bottomDefCustom(
      {required String text,
      required String image,
      required String title,
      required BuildContext context}) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _iconsForDefinitions(image, context),
          5.width,
          Expanded(
            child: _textAndTitle(title, context, text),
          )
        ],
      ),
    );
  }

  Image _iconsForDefinitions(String image, BuildContext context) {
    return Image.asset(
      image,
      width: getValueForScreenType(
        context: context,
        mobile: 15,
        tablet: 30,
        desktop: 40,
      ),
      height: getValueForScreenType(
        context: context,
        mobile: 15,
        tablet: 30,
        desktop: 40,
      ),
    );
  }

  Column _textAndTitle(String title, BuildContext context, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KStyles().semiBold(
          text: title,
          color: AppColors.maroon,
          size: getValueForScreenType(
            context: context,
            mobile: 11,
            tablet: 15,
            desktop: 15,
          ),
        ),
        KStyles().reg(
          text: text,
          color: AppColors.black,
          overflow: TextOverflow.visible,
          size: getValueForScreenType(
            context: context,
            mobile: 9,
            tablet: 12,
            desktop: 13,
          ),
        ),
      ],
    );
  }
}

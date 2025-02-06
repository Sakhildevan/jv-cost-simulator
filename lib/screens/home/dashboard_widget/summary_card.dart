import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/utils/constants.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../themes/app_colors.dart';

// !-----------------------------------Custom Summary card------------------------------!
class SummaryCard extends StatelessWidget {
  final Widget richText;
  final String buttonText;
  final VoidCallback onTap;

  const SummaryCard({
    super.key,
    required this.richText,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    //!---------------------------gesture detector-----------------------------!
    return InkWell(
      onTap: onTap,
      //!---------------------------responsive builder-----------------------------!
      child: ResponsiveBuilder(
          builder: (BuildContext context, SizingInformation size) {
        //!--------------card container------------------!
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.cardCream,
              borderRadius: BorderRadius.circular(
                5,
              )),
          height: getValueForScreenType(
            context: context,
            mobile: Constants.height * .2,
            tablet: Constants.height * .25,
            desktop: Constants.width >= 1040
                ? Constants.height * .35
                : Constants.height * .3,
          ),
          // height: Constants.height * .3,
          width: getValueForScreenType(
            context: context,
            mobile: Constants.width * .9,
            tablet: Constants.width * .22,
            desktop: Constants.width * .22,
          ),
          child: Padding(
            padding: EdgeInsets.all(
              getValueForScreenType(
                context: context,
                mobile: 10,
                tablet: Constants.width < 640 ? 5 : 15,
                desktop: Constants.width < 1300 ? 20 : 35,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //mainAxisSize: MainAxisSize.min,
              children: [
                //!---------------------------rich text-----------------------------!
                buildRichText(),
                //!---------------------------simulatorCardButton-----------------------------!
                simulatorCardButton(context),
              ],
            ),
          ),
        );
      }),
    );
  }

//!---------------------------simulatorCardButton-----------------------------!
  Widget simulatorCardButton(BuildContext context) {
    return Center(
      child: Container(
        height: getValueForScreenType(
          context: context,
          mobile: Constants.height * .04,
          tablet: Constants.height * .05,
          desktop: Constants.height * .065,
        ),
        width: getValueForScreenType(
          context: context,
          mobile: Constants.width * .5,
          tablet: Constants.width * .15,
          desktop: Constants.width * .2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.maroon,
          boxShadow: [ColorConst.completeBoxShadow],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(),
            Flexible(
              //!---------------------------text-----------------------------!
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: commonTextSize(context),
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
            //!---------------------------icon container-----------------------------!
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.white,
              ),

              //!---------------------------icon-----------------------------!
              child: Icon(
                Icons.play_arrow,
                color: AppColors.maroon,
                size: commonIconSize(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double commonTextSize(BuildContext context) {
    return getValueForScreenType(
      context: context,
      mobile: Constants.height * .015,
      tablet: Constants.height * .015,
      desktop: Constants.height * .022,
    );
  }

  double commonIconSize(BuildContext context) {
    return getValueForScreenType(
      context: context,
      mobile: 10,
      tablet: 13,
      desktop: Constants.height * .03,
    );
  }

//!---------------------------expanded rich text-----------------------------!
  Expanded buildRichText() => Expanded(
          child: Center(
        child: richText,
      ));
}

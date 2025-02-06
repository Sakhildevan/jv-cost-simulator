// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/screens/home/dashboard_widget/summary_card.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:johnsonville_cost_simulator/utils/constants.dart';
import 'package:johnsonville_cost_simulator/utils/enums.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../bloc/home_bloc/home_bloc.dart';
import '../../../routes/routes_constants.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/string_const.dart';

class SummaryCardList extends StatelessWidget {
  const SummaryCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //!---------responsive builder-----------------------------!
      child: ResponsiveBuilder(
          builder: (BuildContext context, SizingInformation size) {
        //!--------------------------mobile view-----------------------------!
        if (size.isMobile) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //-----------------------create new pricing card------------------------!
              newPricingCard(context),
              SizedBox(
                height: Constants.height * .02,
              ),
              //-----------------------pending price card------------------------!
              pendingPriceCard(context),
              SizedBox(
                height: Constants.height * .02,
              ),
              //-----------------------existing pricing card------------------------!
              existingPricingCard(context),
            ],
          );
        }
        //!--------------------------tablet & desktop view-----------------------------!
        else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //-----------------------create new pricing card------------------------!
              newPricingCard(context),
              SizedBox(),
              //-----------------------pending price card------------------------!
              pendingPriceCard(context),
              SizedBox(),
              //-----------------------existing pricing card------------------------!
              existingPricingCard(context),
            ],
          );
        }
      }),
    );
  }

//!------------------new pricing card1---------------
  SummaryCard newPricingCard(BuildContext context) {
    return SummaryCard(
      richText: RichText(
        text: TextSpan(
          children: <TextSpan>[
            //------------create text------------
            buildCreateText(context),
            //-------------an text----------
            buildAText(context),
            //-----------new pricing text-------------
            buildNewPricing(context),
            //------------simulator text-----------
            buildSimulator(context),
          ],
        ),
      ),
      //!-----------------start now button-----------------
      buttonText: StringConst.startNow,
      onTap: () {
        context.goNamed(RouteConstants.name.stepOne);
      },
    );
  }

//!---------------------------create text-----------------------------
  TextSpan buildCreateText(BuildContext context) {
    return TextSpan(
      text: StringConst.create,
      style: KStyles()
          .bold(
            text: '',
            size: commonTextSize(context),
            color: AppColors.maroon,
          )
          .style,
    );
  }

  double commonTextSize(BuildContext context) {
    return getValueForScreenType(
      context: context,
      mobile: 16,
      tablet: 18,
      desktop: Constants.width >= 1050
          ? Constants.height * .033
          : Constants.height * .025,
    );
  }

//!-------------------------an text-----------------------------
  // TextSpan buildAnText(BuildContext context) {
  //   return TextSpan(
  //     text: StringConst.an.toUpperCase(),
  //     style: TextStyle(
  //       fontSize: commonTextSize(context),
  //     ),
  //   );
  // }

//!---------------------------new pricing text-----------------------------
  TextSpan buildNewPricing(BuildContext context) {
    return TextSpan(
      text: StringConst.newPricing,
      style: KStyles()
          .bold(
            text: '',
            size: commonTextSize(context),
            color: AppColors.black,
          )
          .style,
    );
  }

  //!---------------simulator text-------------
  TextSpan buildSimulator(BuildContext context) {
    return TextSpan(
      text: StringConst.simulator,
      style: TextStyle(
        fontSize: commonTextSize(context),
        color: AppColors.black,
      ),
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////////
//!---------------------------pending price card2------------------------!
  SummaryCard pendingPriceCard(BuildContext context) {
    return SummaryCard(
      richText: RichText(
        text: TextSpan(
          children: <TextSpan>[
            //!-------------------complete text-------------
            buildCompleteText(context),
            //!------------------a text------------
            // buildAText(context),
            //!-------------pending price text-----------
            buildPendingPrice(context),
            //!-------------------simulator text-------------
            buildSimulator(context),
          ],
        ),
      ),
      //!------show all button--
      buttonText: StringConst.showAll,
      onTap: () {
        //!note: we use this method to prevent duplication
        context
            .read<HomeBloc>()
            .add(const ChangeMenu(StringConst.pendingSimulator));
      },
    );
  }

//!-------------------complete text-------------
  TextSpan buildCompleteText(BuildContext context) {
    return TextSpan(
      text: StringConst.complete,
      style: KStyles()
          .bold(
            text: '',
            size: commonTextSize(context),
            color: AppColors.kTextBlue,
          )
          .style,
    );
  }

  //!-------------------a text--------------------
  TextSpan buildAText(BuildContext context) {
    return TextSpan(
      text: StringConst.a,
      style: TextStyle(
        fontSize: commonTextSize(context),
      ),
    );
  }

//!-------------------pending price text-------------
  TextSpan buildPendingPrice(BuildContext context) {
    return TextSpan(
      text: StringConst.pendingPrice,
      style: KStyles()
          .bold(
            text: '',
            size: commonTextSize(context),
            color: AppColors.black,
          )
          .style,
    );
  }
////////////////////////////////////////////////////////////////////////////////////////////

//!--------------------------existing pricing card3------------------------!
  SummaryCard existingPricingCard(BuildContext context) {
    return SummaryCard(
      richText: RichText(
        textWidthBasis: TextWidthBasis.parent,
        textAlign: TextAlign.start,
        text: TextSpan(
          children: <TextSpan>[
            //!---------------------------review text-----------------------------
            buildReviewText(context),
            //!---------------------------an text-----------------------------
            // buildAnText(context),
            //!---------------------------existing pricing text-----------------------------
            buildExistingPricing(context),
            //!---------------------------simulator reuse setting text-----------------------------
            buildSimulatorReuse(context),
          ],
        ),
      ),
      //!---------------------------show all button-----------------------------
      buttonText: StringConst.showAll,
      onTap: () {
        context
            .goNamed(RouteConstants.name.simulatorCategory, queryParameters: {
          "type": fCon.simulatorCategoryStatus(
            SimulatorStatus.completed,
          )
        });
      },
    );
  }

//!---------------------------review text-----------------------------
  TextSpan buildReviewText(BuildContext context) {
    return TextSpan(
      text: StringConst.review,
      style: KStyles()
          .bold(
            text: '',
            size: commonTextSize(context),
            color: AppColors.kTextBlue,
          )
          .style,
    );
  }

//!---------------------------existing pricing text-----------------------------
  TextSpan buildExistingPricing(BuildContext context) {
    return TextSpan(
      text: StringConst.existingPricing,
      style: KStyles()
          .bold(
            text: '',
            size: commonTextSize(context),
            color: AppColors.black,
          )
          .style,
    );
  }

//!---------------------------simulator reuse setting text-----------------------------
  TextSpan buildSimulatorReuse(BuildContext context) {
    return TextSpan(
      text: StringConst.simulatorReuseSetting,
      style: TextStyle(
        fontSize: commonTextSize(context),
        color: AppColors.black,
      ),
    );
  }

// //!====== common font size
//   double? commonTextSize(BuildContext context) {
//     return getValueForScreenType(
//       context: context,
//       mobile: Constants.width * .03,
//       tablet: Constants.width * .02,
//       desktop: Constants.height * .025,
//     );
//   }
}

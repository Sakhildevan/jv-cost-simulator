import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../bloc/pricing_bloc/pricing_bloc.dart';
import '../config/config.dart';
import '../gen/assets.gen.dart';
import '../routes/routes_constants.dart';
import '../styles/text_styles.dart';
import '../themes/app_colors.dart';
import '../utils/constants.dart';
import '../utils/string_const.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required this.simId,
    required this.packUOM,
    required this.sellPriceUOM,
  });
  final String simId;
  final String packUOM;
  final String sellPriceUOM;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        return uiCon.bgImage(
            child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getValueForScreenType(
              context: context,
              mobile: 8,
              tablet: 50,
              desktop: 60,
            ),
            vertical: 10,
          ),
          child: Column(
            children: [
              uiCon.pageHeader(userName: state.userName ?? ""),
              kDim.kGap10,
              //* Error Content(Icon and Text)
              Expanded(
                child: errorContent(context, state),
              ),

              kDim.kGap10,
              //* Bottom Button
              _bottomButton(context, state),
            ],
          ),
        ));
      },
    );
  }

  Container errorContent(BuildContext context, PricingState state) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getValueForScreenType(
          context: context,
          mobile: 14,
          tablet: 18,
          desktop: 20,
        ),
        vertical: 8,
      ),
      width: Constants.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColors.boxBackGround,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //* Error Icon
          uiCon.svgIcon(
            fit: BoxFit.cover,
            ht: 200,
            wd: 400,
            assetImage: Assets.icons.errorLogo,
          ),
          //* Error Text
          KStyles().black(
            text: StringConst.anErrorOccurred,
            color: AppColors.black.withOpacity(0.7),
            size: getValueForScreenType(
              context: context,
              mobile: 20,
              tablet: 30,
              desktop: 40,
            ),
          ),
          //* sub title
          KStyles().semiBold(
            // text: state.pricingData?.errorOnFailure ?? "",
            text: StringConst.errorMessage,
            color: AppColors.black.withOpacity(0.7),
            size: getValueForScreenType(
              context: context,
              mobile: 10,
              tablet: 15,
              desktop: 20,
            ),
          ),
        ],
      ),
    );
  }

//* Bottom Button
  Row _bottomButton(BuildContext context, PricingState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        uiCon.globalButton(
          context: context,
          iconHt: 25,
          iconWd: 25,
          isIconFirst: true,
          isPng: true,
          text: StringConst.backToHome,
          fontSize: getValueForScreenType(
            context: context,
            mobile: 10,
            tablet: 13,
            desktop: 14,
          ),
          assetImage: Assets.images.back.path,
          height: getValueForScreenType(
            context: context,
            mobile: 30,
            desktop: 40,
            tablet: 35,
          ),
          width: getValueForScreenType(
            context: context,
            mobile: 200,
            desktop: 200,
            tablet: 150,
          ),
          onPressed: () {
            context.goNamed(
              RouteConstants.name.home,
            );
          },
        ),
        kDim.kGap10,
        uiCon.globalButton(
          context: context,
          height: getValueForScreenType(
            context: context,
            mobile: 30,
            desktop: 40,
            tablet: 35,
          ),
          width: getValueForScreenType(
            context: context,
            mobile: 120,
            desktop: 200,
            tablet: 140,
          ),
          text: StringConst.tryAgain,
          fontSize: getValueForScreenType(
            context: context,
            mobile: 10,
            tablet: 13,
            desktop: 14,
          ),
          color: AppColors.maroon,
          isIconFirst: false,
          isPng: true,
          assetImage: Assets.images.next.path,
          iconHt: 25,
          iconWd: 25,
          onPressed: () {
            context.read<PricingBloc>().add(PricingInit(
                  simId: state.simId ?? simId,
                  packUOM: state.packUOM ?? packUOM,
                  sellPriceUOM: state.sellPriceUOM ?? sellPriceUOM,
                ));
          },
        ),
      ],
    );
  }
}

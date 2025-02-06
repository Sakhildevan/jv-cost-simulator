import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:johnsonville_cost_simulator/bloc/step_one_bloc/step_one_bloc.dart';
import 'package:johnsonville_cost_simulator/utils/enums.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../config/config.dart';
import '../../gen/assets.gen.dart';
import '../../routes/routes_constants.dart';
import '../../themes/app_colors.dart';
import '../../utils/global_extensions.dart';
import '../../utils/string_const.dart';
import '../../widgets/background_screen.dart';
import '../../widgets/heading_step_box.dart';
import 'step_one_widgets/bottom_definitions.dart';
import 'step_one_widgets/item_details_box.dart';
import 'step_one_widgets/item_reference_data_box.dart';
import 'step_one_widgets/project_information_box.dart';
import 'step_one_widgets/provide_delivery_info_box.dart';
import 'step_one_widgets/provide_sell_details_box.dart';
import 'step_one_widgets/provide_sell_vol_box.dart';

class StepOneLargeView extends StatelessWidget {
  StepOneLargeView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return BlocConsumer<StepOneBloc, StepOneState>(listener: (context, state) {
      //TODO: Need to update the failure logic
      // if (state.createSimLoadingStatus == LoadingStatus.failure) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text(StringConst.errorText),
      //       backgroundColor: Colors.red,
      //     ),
      //   );
      // }
      if (state.isStepOneCompleted ?? false) {
        context.goNamed(RouteConstants.name.stepTwo, queryParameters: {
          "id": state.costSimulatorId,
        });
      } else {}
    }, builder: (context, state) {
      return BackgroundScreen(
        userName: state.userName,
        button: _bottomButtons(context, context.read<StepOneBloc>().state),
        child: LayoutBuilder(builder: (context, constraints) {
          return Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: scrollController,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: _contentBody(context, state),
                ),
              ),
            ),
          );
        }),
      );
    });
  }

//!----------content body--------------
  Widget _contentBody(BuildContext context, StepOneState state) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getValueForScreenType(
            context: context,
            mobile: 14,
            tablet: 18,
            desktop: 20,
          ),
          vertical: 8,
        ),
        child: Column(
          children: [
            BlocBuilder<StepOneBloc, StepOneState>(
              builder: (context, state) {
                return HeadingForStepBox(
                  stepNo: StringConst.step1,
                  createdBy: state.createdBy?.toUpperCase() ?? "",
                  createdOn: state.createdOn?.toUpperCase() ?? "",
                  approvedBy: state.approvedBy?.toUpperCase() ?? "",
                  approvedOn: state.approvedOn?.toUpperCase() ?? "",
                  status: state.simStatus ?? '',
                );
              },
            ),
            const Gap(10),
            Expanded(
              child: Column(
                children: [
                  //!--------item information and provided volume data-------------
                  _itemInfoAndProvideVolData(),
                  15.height,

                  //!------------------item details and sell details---------------
                  _itemDetailsSellDetails(scrollCtrl: scrollController),
                  15.height,

                  //!---------item reference data and provide delivery information-
                  _itemRefAndDeliveryInfo(),
                  10.height,
                  // 10.height,
                ],
              ),
            ),
            const BottomDefinitions(),
          ],
        ),
      ),
    );
  }

//!-----------------bottom buttons-------------------
  Widget _bottomButtons(BuildContext context, StepOneState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _backButton(context),
        10.width,
        _nextButton(context, state),
      ],
    );
  }

//*----------next button--------------
  Widget _nextButton(BuildContext context, StepOneState state) {
    if (state.createSimLoadingStatus == LoadingStatus.loading) {
      return SizedBox(
        height: getValueForScreenType(
          context: context,
          mobile: 20,
          desktop: 25,
          tablet: 25,
        ),
        width: getValueForScreenType(
          context: context,
          mobile: 20,
          desktop: 25,
          tablet: 25,
        ),
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.maroon),
        ),
      );
    }

    // Return the button for all other states
    return uiCon.globalButton(
      context: context,
      fontSize: getValueForScreenType(
        context: context,
        mobile: 10,
        tablet: 12,
        desktop: 14,
      ),
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
      text: StringConst.next,
      color: AppColors.maroon,
      isIconFirst: false,
      isPng: true,
      assetImage: Assets.images.next.path,
      iconHt: getValueForScreenType(
        context: context,
        mobile: 20,
        tablet: 20,
        desktop: 25,
      ),
      iconWd: getValueForScreenType(
        context: context,
        mobile: 20,
        tablet: 20,
        desktop: 25,
      ),
      onPressed: () {
        context.read<StepOneBloc>().add(CheckMetrics(
            sellVolumeUnit: state.sellVolumeUnit ?? '',
            packUom: state.packUom ?? ''));
        if (formKey.currentState!.validate()) {
          if ((state.sellVolumeUnit ?? '').isNotEmpty &&
              (state.packUom ?? '').isNotEmpty) {
            context.read<StepOneBloc>().add(const OnNextTap());
          }
        }
      },
    );
  }

//*-----------------back button-------------------
  Widget _backButton(BuildContext context) {
    return BlocBuilder<StepOneBloc, StepOneState>(
      builder: (context, state) {
        return uiCon.globalButton(
          context: context,
          fontSize: getValueForScreenType(
            context: context,
            mobile: 10,
            tablet: 12,
            desktop: 14,
          ),
          iconHt: getValueForScreenType(
            context: context,
            mobile: 20,
            tablet: 20,
            desktop: 25,
          ),
          iconWd: getValueForScreenType(
            context: context,
            mobile: 20,
            tablet: 20,
            desktop: 25,
          ),
          isIconFirst: true,
          isPng: true,
          text: StringConst.back,
          assetImage: Assets.images.back.path,
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
          onPressed: () {
            context.goNamed(
              RouteConstants.name.home,
            );
          },
        );
      },
    );
  }

//!--------item information and provided volume data--------------
  Widget _itemInfoAndProvideVolData() {
    return IntrinsicHeight(
      child: Row(
        children: [
          //!------item information box------
          const Expanded(
            child: ProjectInformationBox(),
          ),
          20.width,
          //!------provide sell volume box------
          const Expanded(
            child: ProvideSellVolBox(),
          ),
        ],
      ),
    );
  }

//!------------------item details and sell details----------------
  Widget _itemDetailsSellDetails({
    required ScrollController scrollCtrl,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            //!------item details box------
            child: ItemDetailsBox(
              scrollcontroller: scrollCtrl,
            ),
          ),
          20.width,
          const Expanded(
            //!------provide sell details box------
            child: ProvideSellDetailsBox(),
          ),
        ],
      ),
    );
  }

  //!------------------item reference data and provide delivery information----------------
  Widget _itemRefAndDeliveryInfo() {
    return IntrinsicHeight(
      child: Row(
        children: [
          const Expanded(
            //!------item reference data box------
            child: ItemReferenceDataBox(),
          ),
          20.width,
          const Expanded(
            //!------provide delivery information box------
            child: ProvideDeliveryInformationBox(),
          ),
        ],
      ),
    );
  }
}

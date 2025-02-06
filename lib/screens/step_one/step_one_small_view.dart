import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:johnsonville_cost_simulator/bloc/step_one_bloc/step_one_bloc.dart';
import 'package:johnsonville_cost_simulator/routes/routes_constants.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../config/config.dart';
import '../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../utils/enums.dart';
import 'step_one_widgets/item_reference_data_box.dart';
import 'step_one_widgets/provide_sell_details_box.dart';
import 'step_one_widgets/provide_delivery_info_box.dart';
import '../../utils/global_extensions.dart';
import '../../widgets/background_screen.dart';
import '../../utils/string_const.dart';
import '../../widgets/heading_step_box.dart';
import 'step_one_widgets/bottom_definitions.dart';
import 'step_one_widgets/item_details_box.dart';
import 'step_one_widgets/project_information_box.dart';
import 'step_one_widgets/provide_sell_vol_box.dart';

class StepOneSmallView extends StatefulWidget {
  const StepOneSmallView({super.key});

  @override
  State<StepOneSmallView> createState() => _StepOneSmallViewState();
}

class _StepOneSmallViewState extends State<StepOneSmallView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return BlocConsumer<StepOneBloc, StepOneState>(
      listener: (context, state) {
        if (state.isStepOneCompleted ?? false) {
          context.goNamed(RouteConstants.name.stepTwo, queryParameters: {
            "id": state.costSimulatorId,
          });
        } else {}
      },
      builder: (context, state) {
        return BackgroundScreen(
          button: _bottomButtons(context, context.read<StepOneBloc>().state),
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Form(
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
                          HeadingForStepBox(
                            stepNo: StringConst.step1,
                            status: state.simStatus ?? '',
                            createdBy: state.createdBy?.toUpperCase() ?? "-",
                            createdOn: state.createdOn?.toUpperCase() ?? "-",
                            approvedBy: state.approvedBy?.toUpperCase() ?? "-",
                            approvedOn: state.approvedOn?.toUpperCase() ?? "-",
                          ),
                          10.height,
                          _itemInfoAndProvideVolData(),
                          15.height,
                          _itemDetailsSellDetails(scrollCtrl: scrollController),
                          15.height,
                          _itemRefAndDeliveryInfo(),
                          10.height,
                          const BottomDefinitions(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _itemInfoAndProvideVolData() {
    return IntrinsicHeight(
      child: Column(
        children: [
          const ProjectInformationBox(),
          20.height,
          const ProvideSellVolBox(),
        ],
      ),
    );
  }

  Widget _itemDetailsSellDetails({required ScrollController scrollCtrl}) {
    return IntrinsicHeight(
      child: Column(
        children: [
          ItemDetailsBox(
            scrollcontroller: scrollCtrl,
          ),
          20.height,
          const ProvideSellDetailsBox(),
        ],
      ),
    );
  }

  Widget _itemRefAndDeliveryInfo() {
    return IntrinsicHeight(
      child: Column(
        children: [
          const ItemReferenceDataBox(),
          20.height,
          const ProvideDeliveryInformationBox(),
        ],
      ),
    );
  }

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
      height: getValueForScreenType(
        context: context,
        mobile: 30,
        tablet: 35,
        desktop: 40,
      ),
      width: getValueForScreenType(
        context: context,
        mobile: 120,
        tablet: 140,
        desktop: 200,
      ),
      text: StringConst.next,
      color: AppColors.maroon,
      isIconFirst: false,
      isPng: true,
      assetImage: Assets.images.next.path,
      iconHt: 25,
      iconWd: 25,
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
          fontSize: getValueForScreenType(
            context: context,
            mobile: 13,
            tablet: 12,
            desktop: 14,
          ),
          context: context,
          iconHt: 25,
          iconWd: 25,
          isIconFirst: true,
          isPng: true,
          text: StringConst.back,
          assetImage: Assets.images.back.path,
          height: getValueForScreenType(
            context: context,
            mobile: 30,
            tablet: 35,
            desktop: 40,
          ),
          width: getValueForScreenType(
            context: context,
            mobile: 120,
            tablet: 140,
            desktop: 200,
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
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/step_two_bloc/step_two_bloc.dart';
import '../../gen/assets.gen.dart';
import '../../routes/routes_constants.dart';
import '../../styles/text_styles.dart';
import '../../themes/app_colors.dart';
import '../../utils/enums.dart';
import '../../utils/global_extensions.dart';
import '../../utils/string_const.dart';
import '../../widgets/background_screen.dart';
import '../../widgets/custom_save_dialogue.dart';
import '../../widgets/heading_step_box.dart';
import 'step_two_widgets/cost_of_sales_box.dart';
import 'step_two_widgets/delivery_supply_chain.dart';
import 'step_two_widgets/sell_and_discounts_box.dart';
import 'step_two_widgets/selling_expense_box.dart';
import 'step_two_widgets/tax_margin_box.dart';

//!------------------------------------StepTwoLargeView Page-----------------------------------------!
class StepTwoLargeView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  StepTwoLargeView({super.key});

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
    return BlocConsumer<StepTwoBloc, StepTwoState>(
      listener: (context, state) {
        if (state.isStepTwoCompleted) {
          context.goNamed(
            RouteConstants.name.pricing,
            queryParameters: {
              "id": state.costSimulatorDetails.costSimulatorId,
              "packUOM": state.costSimulatorDetails.packUOM,
              "sellPriceUOM":
                  state.costSimulatorDetails.sellUnitOfMeasure?.unitCode,
            },
          );
        } else {}
      },
      builder: (context, state) {
        return BackgroundScreen(
          userName: state.userName,
          button: _bottomButtons(
            context,
            state,
          ),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
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
                    child: _contentBody(context),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _contentBody(BuildContext context) {
    return Form(
      key: _formKey,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<StepTwoBloc, StepTwoState>(
              builder: (context, state) {
                return HeadingForStepBox(
                  status: state.simStatus ?? '',
                  createdBy: state.createdBy?.toUpperCase() ?? "",
                  createdOn: state.createdOn?.toUpperCase() ?? "",
                  approvedBy: state.approvedBy?.toUpperCase() ?? "",
                  approvedOn: state.approvedOn?.toUpperCase() ?? "",
                  stepNo: StringConst.step2,
                  color: state.isEdited
                      ? AppColors.headingTextBlue
                      : AppColors.grey,
                  onPressed: state.isEdited
                      ? () {
                          context.read<StepTwoBloc>().add(const StepTwoSave());
                        }
                      : null,
                );
              },
            ),
            const Gap(10),
            Expanded(
              child: Column(
                children: [
                  //!--------------Tax Margin and cost sale row -------------------------!
                  _taxMarginAndCostSalesRow(),
                  10.height,
                  //!--------------Jvl sell Discount and Supply Chain row -------------------------!
                  _jvlsellDiscountAndSupplyChainRow(),
                  10.height,
                  //!--------------Sell Expense And Distributor Margin row -------------------------!
                  _sellExpenseAndDistributorMarginRow(),
                  10.height,
                ],
              ),
            ),
            _bottomReferText(),
          ],
        ),
      ),
    );
  }

  Widget _bottomButtons(BuildContext context, StepTwoState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _backButton(context),
        10.width,
        _viewPricingButton(context, state),
      ],
    );
  }

  Widget _backButton(BuildContext context) {
    return BlocBuilder<StepTwoBloc, StepTwoState>(
      builder: (context, state) {
        return uiCon.globalButton(
          context: context,
          fontSize: getValueForScreenType(
            context: context,
            mobile: 10,
            tablet: 12,
            desktop: 14,
          ),
          iconHt: 25,
          iconWd: 25,
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
            if (state.isEdited) {
              uiCon.dialogBuilder(
                context: context,
                child: CustomDialogBox(
                  title: StringConst.unsavedChanges,
                  subTitle: StringConst.unsavedChangesDesc,
                  onPressed: () {
                    context
                        .goNamed(RouteConstants.name.stepOne, queryParameters: {
                      "id": state.costSimulatorDetails.costSimulatorId,
                    });
                  },
                  state: state,
                ),
              );
            } else {
              context.goNamed(RouteConstants.name.stepOne, queryParameters: {
                "id": state.costSimulatorDetails.costSimulatorId,
              });
            }

            // context.goNamed(RouteConstants.name.stepOne, queryParameters: {
            //   "id": state.costSimulatorDetails.costSimulatorId,
            // });
          },
        );
      },
    );
  }

  Widget _viewPricingButton(BuildContext context, StepTwoState state) {
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
    {
      return uiCon.globalButton(
        context: context,
        fontSize: getValueForScreenType(
          context: context,
          mobile: 10,
          tablet: 10,
          desktop: 12,
        ),
        textAlign: TextAlign.center,
        iconHt: 25,
        iconWd: 25,
        color: AppColors.maroon,
        isIconFirst: false,
        isPng: true,
        text: StringConst.viewPricingWorksheet,
        assetImage: Assets.images.next.path,
        height: getValueForScreenType(
            context: context, mobile: 30, desktop: 40, tablet: 35),
        width: getValueForScreenType(
            context: context, mobile: 120, desktop: 200, tablet: 140),
        onPressed: () async {
          // context.goNamed(RouteConstants.name.pricing);

          if (_formKey.currentState!.validate()) {
            context.read<StepTwoBloc>().add(const ViewPricingSheet());
          }
          //print assetimage path
        },
      );
    }
  }

//!------------------------------------Sell Expense row And Distributor Margin-----------------------------------------!
  Widget _sellExpenseAndDistributorMarginRow() {
    return IntrinsicHeight(
      child: Row(
        children: [
          const Expanded(
            //!-----------------SellingExpenseBox----------------
            child: SellingExpenseBox(),
          ),
          20.width,
          const Expanded(
            //!-----------------DeliverySupplyChainBox----------------
            child: DeliverySupplyChainBox(),
          ),
          // const Expanded(
          //   //!-----------------DistributorMarginBox----------------
          //   child: DistributorMarginBox(),
          // ),
        ],
      ),
    );
  }

//!------------------------------------JvlSellDiscount and Supply Chain row -----------------------------------------!
  Widget _jvlsellDiscountAndSupplyChainRow() {
    return IntrinsicHeight(
      child: Row(
        children: [
          const Expanded(
            //!-----------------JvlSellAndDiscountsBox----------------
            child: JvlSellAndDiscountsBox(),
          ),
          20.width,
          const Expanded(
            child: CostOfSalesBox(),
          ),
          // const Expanded(
          //   //!-----------------DeliverySupplyChainBox----------------
          //   child: DeliverySupplyChainBox(),
          // ),
        ],
      ),
    );
  }

//!------------------------------------Tax Margin and cost sale row -----------------------------------------!
  Widget _taxMarginAndCostSalesRow() {
    return const IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: RetailTaxMarginBox(),
          ),
          // 20.width,
          // const Expanded(
          //   child: CostOfSalesBox(),
          // ),
        ],
      ),
    );
  }

  Widget _bottomReferText() {
    return KStyles().med(
      text: StringConst.taxRefersToVatReferenceBottom,
      size: 12,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/routes/routes_constants.dart';
import 'package:johnsonville_cost_simulator/screens/pricing/pricing_widgets/review_list.widget.dart';
import 'package:johnsonville_cost_simulator/screens/pricing/pricing_widgets/sheet_row_title_sub.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:johnsonville_cost_simulator/widgets/custom_save_dialogue.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../gen/assets.gen.dart';
import '../../styles/text_styles.dart';
import '../../themes/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../utils/string_const.dart';
import 'custom_pricing_widgets/custom_space.widget.dart';
import 'pricing_header.widget.dart';
import 'pricing_widgets/cost_of_sales_row.dart';
import 'pricing_widgets/delivery_and_supply_chain.dart';
import 'pricing_widgets/delivery_and_supply_chain_total_row.dart';
import 'pricing_widgets/distributor_margin_row.dart';
import 'pricing_widgets/gross_profit_percent_row.dart';
import 'pricing_widgets/gross_profit_row.dart';
import 'pricing_widgets/gross_sales_row.dart';
import 'pricing_widgets/jvl_sell_price_and_discount_row.dart';
import 'pricing_widgets/net_sales_row.dart';
import 'pricing_widgets/operating_profit_row.dart';
import 'pricing_widgets/operation_profit_percent.row.dart';
import 'pricing_widgets/retail_tax_margins.dart';
import 'pricing_widgets/sell_expense_total.row.dart';
import 'pricing_widgets/selling_expenses_row.dart';
import 'pricing_widgets/standard_cost_row.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({
    super.key,
    required this.simulatorId,
    required this.packUOM,
    required this.sellPriceUOM,
  });
  final String simulatorId;
  final String packUOM;
  final String sellPriceUOM;

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  ScrollController scrollController = ScrollController();
  bool showBanner = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PricingBloc>().add(PricingInit(
            simId: widget.simulatorId,
            packUOM: widget.packUOM,
            sellPriceUOM: widget.sellPriceUOM,
          ));
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
            getValueForScreenType(
              context: context,
              mobile: 390,
              tablet: 450,
//if screen size is <=1024 the size 200 else 300
              desktop: (Constants.width <= 1054) ? 550 : 340,

              //desktop: 300,
            )) {
          setState(() {
            showBanner = true;
          });
          // context
          //     .read<PricingBloc>()
          //     .add(const ShowBannerEvent(showBanner: true));
        } else {
          setState(() {
            showBanner = false;
          });
          // context
          //     .read<PricingBloc>()
          //     .add(const ShowBannerEvent(showBanner: false));
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Constants.width = MediaQuery.of(context).size.width;
    Constants.height = MediaQuery.of(context).size.height;

    return SelectionArea(
      child: Scaffold(
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(
    BuildContext context,
  ) {
    //// ScrollController scrollController = ScrollController();
    return BlocConsumer<PricingBloc, PricingState>(
      listener: (context, state) {
        if (state.pricingSaveStatus == LoadingStatus.success) {
          context.goNamed(
            RouteConstants.name.home,
          );
        }
        if (state.pricingConfirmStatus == LoadingStatus.success) {
          context.goNamed(
            RouteConstants.name.home,
          );
        }
        if (state.replicateSheetStatus == LoadingStatus.success) {
          context.goNamed(
            RouteConstants.name.stepOne,
            queryParameters: {
              "id": state.replicateSimId,
            },
          );
        }
      },
      builder: (context, state) {
        if (state.loadingStatus == LoadingStatus.loading) {
          return uiCon.bgImage(
              child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getValueForScreenType(
                context: context,
                mobile: 8,
                tablet: 18,
                desktop: 60,
              ),
              vertical: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                uiCon.pageHeader(userName: state.userName ?? ""),
                kDim.kGap10,
                Expanded(
                    child: Container(
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
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.maroon,
                    ),
                  ),
                )),
              ],
            ),
          ));
        }
        //*----(if loading status is failure)
        else if (state.loadingStatus == LoadingStatus.failure) {
          return uiCon.bgImage(
              child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getValueForScreenType(
                context: context,
                mobile: 8,
                tablet: 18,
                desktop: 60,
              ),
              vertical: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                uiCon.pageHeader(userName: state.userName ?? ""),
                kDim.kGap10,
                Expanded(
                    child: Container(
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
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.maroon,
                    ),
                  ),
                )),
              ],
            ),
          ));
        }
        // //*----(if loading status is failure)
        // else if (state.loadingStatus == LoadingStatus.failure) {
        //   return ErrorScreen(
        //     simId: widget.simulatorId,
        //   );
        // }
        else {
          return Scrollbar(
            controller: scrollController,
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                if (showBanner) // Show SliverAppBar only when visible
                  SliverAppBar(
                      backgroundColor: AppColors.transparent,
                      floating: false,
                      pinned: true,
                      collapsedHeight: getValueForScreenType(
                        context: context,
                        mobile: 390,
                        tablet: 390,
                        // desktop: 300,
                        desktop: Constants.width <= 1054 ? 450 : 370,
                      ),
                      flexibleSpace:
                          LayoutBuilder(builder: (context, constraints) {
                        return FlexibleSpaceBar(
                          background: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getValueForScreenType(
                                context: context,
                                mobile: 8,
                                tablet: 18,
                                desktop: 60,
                              ),
                              // vertical: 10,
                            ),
                            child: Container(
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
                              decoration: const BoxDecoration(
                                color: AppColors.boxBackGround,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    color: AppColors.cardCream,
                                    child: const SheetRowTitleAndSub(),
                                  ),
                                  // Main widget to display in the app bar
                                  const ReviewList(), // Another widget inside the app bar
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: 1,
                  (context, index) {
                    return uiCon.bgImage(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getValueForScreenType(
                            context: context,
                            mobile: 8,
                            tablet: 18,
                            desktop: 60,
                          ),
                          vertical: 10,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            uiCon.pageHeader(
                              userName: state.userName ?? "",
                            ),
                            kDim.kGap10,
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _contentBody(
                                  context,
                                  state,
                                ),
                              ],
                            ),
                            15.height,
                            state.pricingData?.pricingWorksheetSegmentItems
                                        ?.status ==
                                    StringConst.completed.toUpperCase()
                                ? bottomCompletedButton(context)
                                : (state.userRole == StringConst.admin)
                                    ? _bottomAdminButtons(context, state)
                                    : state
                                                    .pricingData
                                                    ?.pricingWorksheetSegmentItems
                                                    ?.status ==
                                                StringConst.approval
                                                    .toUpperCase() &&
                                            (state.userRole !=
                                                StringConst.admin)
                                        ? bottomCompletedButton(context)
                                        : _bottomButtons(context, state),
                          ],
                        ),
                      ),
                    );
                  },
                )),
              ],
              controller: scrollController,
              // child:
            ),
          );
        }
      },
    );
  }

  Widget bottomCompletedButton(BuildContext context) {
    return uiCon.globalButton(
      context: context,
      color: AppColors.maroon,
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
    );
  }

  //!--------(itemInnerScreen)
  Container _contentBody(
    BuildContext context,
    PricingState state,
  ) {
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
      child: buildTableAndInfo(
        context,
        state,
      ),
    );
  }

  Column buildTableAndInfo(
    BuildContext context,
    PricingState state,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //*--------(Pricing Header)
        const PricingHeader(),
        //*---- Pricing sheet data
        Container(
          color: AppColors.cardCream,
          child: Column(
            children: [
              //----Sheet Row Title And Sub
              (showBanner)
                  ? const SizedBox.shrink()
                  : const SheetRowTitleAndSub(),

              (showBanner) ? const SizedBox.shrink() : const ReviewList(),

              //----The RetailTaxMargins Row data
              const RetailTaxMargins(),
              //Gross sales
              const GrossSalesRow(),
              //---(Jvl Sell Price And Discount Row)
              const JvlSellPriceAndDiscountRow(),

              //---(net sales row )
              const NetSalesRow(),
              //---(Distributor margin row)
              const DistributorMarginRow(),
              //
              //----The StandardCost Row data
              const StandardCost(),
              //----The Cost Good Sold Total Row data
              //TODO: commented for future use
              // const CostGoodSoldTotalRow(),
              //----The DeliveryAndSupplyChain Row data
              const DeliveryAndSupplyChain(),
              //----The DeliveryAndSupplyChain total Row data
              const DeliveryAndSupplyTotalRow(),
              const CustomSpace(),
              //----The CostOfSalesRow Row data
              const CostOfSalesRow(),

              const CustomSpace(),
              //----The GrossProfit Total Row data
              const GrossProfitRow(),
              //----The GrossProfit percent Total Row data
              const CustomSpace(),
              const GrossProfitPercentRow(),
              //----The SellingExpenses Row data
              const SellingExpensesRow(),
              //----The SellingExpenses total Row data
              const SellExpenseTotalRow(),
              //----The OperatingProfit Total Row data
              const OperationProfitRow(),
              //----The OperatingProfit percent Row data
              const OperationProfitPercentRow(),
            ],
          ),
        ),
        //!------------Bottom Note
        kDim.kGap10,
        buildNote(context)
      ],
    );
  }

//!------------update,print and download-------------
  Row buildNote(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildBottomIconWithText(context),
        10.width,
        buildTaxInfo(context),
      ],
    );
  }

  Flexible buildBottomIconWithText(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Row(
        children: [
          uiCon.svgIcon(
            ht: 20,
            wd: 20,
            assetImage: Assets.icons.edit,
            color: AppColors.headingTextBlue,
          ),
          const SizedBox(width: 5), // Add space between the icon and text
          Expanded(
            child: KStyles().reg(
              text: StringConst.note,
              size: getValueForScreenType(
                context: context,
                mobile: 10,
                tablet: 10,
                desktop: 13,
              ),
              overflow: TextOverflow.visible,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Flexible buildTaxInfo(BuildContext context) {
    return Flexible(
      flex: 1,
      child: KStyles().reg(
        text: StringConst.tax,
        size: getValueForScreenType(
          context: context,
          mobile: 10,
          tablet: 10,
          desktop: 13,
        ),
        overflow: TextOverflow.visible,
        textAlign: TextAlign.right,
      ),
      //  Text(
      //   StringConst.tax,
      //   textAlign: TextAlign.right,
      //   style: TextStyle(
      //     fontSize: 12,
      //   ),
      // ),
    );
  }

  Widget _bottomButtons(
    BuildContext context,
    PricingState state,
  ) {
    return BlocListener<PricingBloc, PricingState>(
      listener: (context, state) {
        // Automatically close the dialog after saving successfully
        if (state.saveThisVersionStatus == LoadingStatus.success ||
            state.saveThisVersionStatus == LoadingStatus.failure) {
          Future.delayed(const Duration(seconds: 1), () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop(); // Auto-close the dialog
              // Reset the state for further actions
              context
                  .read<PricingBloc>()
                  .add(const ResetSaveVersionStatusEvent());
            }
          });
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          uiCon.globalButton(
            context: context,
            iconColor: AppColors.white,
            isPng: false,
            isIconFirst: true,
            onPressed: () {
              context.goNamed(
                RouteConstants.name.stepOne,
                queryParameters: {
                  "id": widget.simulatorId,
                },
              );
            },
          ),
          // _saveButton(context),
          10.width,
          // save this version
          uiCon.saveButton(
              width: getValueForScreenType(
                context: context,
                mobile: 160,
                tablet: 180,
                desktop: 220,
              ),
              text: StringConst.saveThisVersion.toUpperCase(),
              context: context,
              onPressed: () {
                _showSaveDialog(context);
              }),
          10.width,
          uiCon.saveButton(
              isSvg: true,
              assetImage: Assets.icons.confirmTick,
              iconHt: getValueForScreenType(
                context: context,
                mobile: 16,
                tablet: 18,
                desktop: 20,
              ),
              iconWd: getValueForScreenType(
                context: context,
                mobile: 16,
                tablet: 18,
                desktop: 20,
              ),
              color: AppColors.kTextBlue,
              width: getValueForScreenType(
                context: context,
                mobile: 160,
                tablet: 200,
                desktop: 220,
              ),
              text: StringConst.submitForApproval.toUpperCase(),
              context: context,
              onPressed: () {
                uiCon.dialogBuilder(
                    context: context,
                    child: BlocBuilder<PricingBloc, PricingState>(
                      builder: (context, state) {
                        return CustomDialogBox(
                          isLoading:
                              state.pricingSaveStatus == LoadingStatus.loading,
                          title: StringConst.confirmSubmission,
                          subTitle: StringConst.saveSubTitle,
                          continueButtonText: StringConst.confirm,
                          onPressed: () {
                            context
                                .read<PricingBloc>()
                                .add(const PricingCompletedEvent());
                          },
                        );
                      },
                    ));
                //context.read<PricingBloc>().add(const PricingCompletedEvent());
              }),
        ],
      ),
    );
  }

//!------------Admin bottom button-------------
  Widget _bottomAdminButtons(
    BuildContext context,
    PricingState state,
  ) {
    return BlocListener<PricingBloc, PricingState>(
      listener: (context, state) {
        // Automatically close the dialog after saving successfully
        if (state.saveThisVersionStatus == LoadingStatus.success ||
            state.saveThisVersionStatus == LoadingStatus.failure) {
          Future.delayed(const Duration(seconds: 1), () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop(); // Auto-close the dialog
              // Reset the state for further actions
              context
                  .read<PricingBloc>()
                  .add(const ResetSaveVersionStatusEvent());
            }
          });
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          uiCon.globalButton(
            context: context,
            iconColor: AppColors.white,
            isPng: false,
            isIconFirst: true,
            onPressed: () {
              context.goNamed(
                RouteConstants.name.stepOne,
                queryParameters: {
                  "id": widget.simulatorId,
                },
              );
            },
          ),
          10.width,
          uiCon.saveButton(
            width: getValueForScreenType(
              context: context,
              mobile: 160,
              tablet: 180,
              desktop: 200,
            ),
            text: StringConst.saveThisVersion.toUpperCase(),
            context: context,
            onPressed: () {
              _showSaveDialog(context);
            },
          ),
          10.width,
          uiCon.saveButton(
            isSvg: true,
            assetImage: Assets.icons.confirmTick,
            iconHt: getValueForScreenType(
              context: context,
              mobile: 16,
              tablet: 18,
              desktop: 20,
            ),
            iconWd: getValueForScreenType(
              context: context,
              mobile: 16,
              tablet: 18,
              desktop: 20,
            ),
            text: StringConst.approve,
            color: AppColors.kTextBlue,
            onPressed: () {
              uiCon.dialogBuilder(
                context: context,
                child: BlocBuilder<PricingBloc, PricingState>(
                  builder: (context, state) {
                    return CustomDialogBox(
                      isLoading:
                          state.pricingConfirmStatus == LoadingStatus.loading,
                      title: StringConst.confirmApproval,
                      subTitle: StringConst.approvalSubTitle,
                      continueButtonText: StringConst.confirm,
                      onPressed: () {
                        context
                            .read<PricingBloc>()
                            .add(const PricingApproveEvent());
                      },
                    );
                  },
                ),
              );
            },
            context: context,
          ),
        ],
      ),
    );
  }

  void _showSaveDialog(BuildContext context) {
    uiCon
        .dialogBuilder(
      context: context,
      child: BlocBuilder<PricingBloc, PricingState>(
        builder: (context, state) {
          if (state.saveThisVersionStatus == LoadingStatus.loading) {
            return CustomDialogBox(
              isLoading: true,
              title: StringConst.saveCurrentVersion,
              subTitle: StringConst.saveCurrentVersionSubTitle,
              continueButtonText: StringConst.save,
              onPressed: () {
                context.read<PricingBloc>().add(const SaveThisVersionEvent());
              },
            );
          } else if (state.saveThisVersionStatus == LoadingStatus.success) {
            //!------------(success pop up)
            return uiCon.customStatusPop(
              type: DialogType.success,
              title: StringConst.success,
              subTitle: "Saved Current Version Successfully",
            );
          } else if (state.saveThisVersionStatus == LoadingStatus.failure) {
            //!------------(failure pop up)
            return uiCon.customStatusPop(
                type: DialogType.failure,
                title: StringConst.failure,
                subTitle: state.versionResp?.errorOnFailure ?? "");
          } else {
            return CustomDialogBox(
              isLoading: false,
              title: StringConst.saveCurrentVersion,
              subTitle: StringConst.saveCurrentVersionSubTitle,
              continueButtonText: StringConst.save,
              onPressed: () {
                context.read<PricingBloc>().add(const SaveThisVersionEvent());
              },
            );
          }
        },
      ),
    )
        .then(
      (value) {
        context.read<PricingBloc>().add(const ResetSaveVersionStatusEvent());
      },
    );
  }
}

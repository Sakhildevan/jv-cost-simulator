// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';
// import 'package:johnsonville_cost_simulator/config/config.dart';
// import 'package:johnsonville_cost_simulator/routes/routes_constants.dart';
// import 'package:johnsonville_cost_simulator/screens/pricing/pricing_widgets/review_list.widget.dart';
// import 'package:johnsonville_cost_simulator/screens/pricing/pricing_widgets/sheet_row_title_sub.dart';
// import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
// import 'package:johnsonville_cost_simulator/widgets/custom_save_dialogue.dart';
// import 'package:johnsonville_cost_simulator/widgets/error_screen.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import '../../gen/assets.gen.dart';
// import '../../styles/text_styles.dart';
// import '../../themes/app_colors.dart';
// import '../../utils/constants.dart';
// import '../../utils/enums.dart';
// import '../../utils/string_const.dart';
// import 'pricing_header.widget.dart';
// import 'pricing_widgets/cost_good_sold_total_row.dart';
// import 'pricing_widgets/cost_of_sales_row.dart';
// import 'pricing_widgets/delivery_and_supply_chain.dart';
// import 'pricing_widgets/delivery_and_supply_chain_total_row.dart';
// import 'pricing_widgets/distributor_margin_row.dart';
// import 'pricing_widgets/gross_profit_percent_row.dart';
// import 'pricing_widgets/gross_profit_row.dart';
// import 'pricing_widgets/jvl_sell_price_and_discount_row.dart';
// import 'pricing_widgets/net_sales_row.dart';
// import 'pricing_widgets/operating_profit_row.dart';
// import 'pricing_widgets/operation_profit_percent.row.dart';
// import 'pricing_widgets/retail_tax_margins.dart';
// import 'pricing_widgets/sell_expense_total.row.dart';
// import 'pricing_widgets/selling_expenses_row.dart';

// class PricingScreen extends StatefulWidget {
//   const PricingScreen({
//     super.key,
//     required this.simulatorId,
//   });
//   final String simulatorId;

//   @override
//   State<PricingScreen> createState() => _PricingScreenState();
// }

// class _PricingScreenState extends State<PricingScreen> {
//   ScrollController scrollController = ScrollController();
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<PricingBloc>().add(PricingInit(
//             simId: widget.simulatorId,
//           ));
//     });
//     Constants.width = MediaQuery.of(context).size.width;
//     Constants.height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: buildBody(context),
//     );
//   }

//   Widget buildBody(
//     BuildContext context,
//   ) {
//     ScrollController scrollController = ScrollController();
//     return BlocConsumer<PricingBloc, PricingState>(
//       listener: (context, state) {
//         scrollController.addListener(() {
//           //TODO: add get value type here
//           if (scrollController.position.pixels >=
//               getValueForScreenType(
//                 context: context,
//                 mobile: 386,
//                 tablet: 450,
// //if screen size is <=1024 the size 200 else 300
//                 desktop: (Constants.width <= 1024) ? 450 : 300,

//                 //desktop: 300,
//               )) {
//             context
//                 .read<PricingBloc>()
//                 .add(const ShowBannerEvent(showBanner: true));
//           } else {
//             context
//                 .read<PricingBloc>()
//                 .add(const ShowBannerEvent(showBanner: false));
//           }
//         });
//         if (state.pricingSaveStatus == LoadingStatus.success) {
//           context.goNamed(
//             RouteConstants.name.home,
//           );
//         }
//         if (state.pricingConfirmStatus == LoadingStatus.success) {
//           context.goNamed(
//             RouteConstants.name.home,
//           );
//         }
//         if (state.replicateSheetStatus == LoadingStatus.success) {
//           context.goNamed(
//             RouteConstants.name.stepOne,
//             queryParameters: {
//               "id": state.replicateSimId,
//             },
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state.loadingStatus == LoadingStatus.loading) {
//           return uiCon.bgImage(
//               child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: getValueForScreenType(
//                 context: context,
//                 mobile: 8,
//                 tablet: 18,
//                 desktop: 60,
//               ),
//               vertical: 10,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 uiCon.pageHeader(userName: state.userName ?? ""),
//                 kDim.kGap10,
//                 Expanded(
//                     child: Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: getValueForScreenType(
//                       context: context,
//                       mobile: 14,
//                       tablet: 18,
//                       desktop: 20,
//                     ),
//                     vertical: 8,
//                   ),
//                   width: Constants.width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     color: AppColors.boxBackGround,
//                   ),
//                   child: const Center(
//                     child: CircularProgressIndicator(
//                       color: AppColors.maroon,
//                     ),
//                   ),
//                 )),
//               ],
//             ),
//           ));
//         }
//         //*----(if loading status is failure)
//         else if (state.loadingStatus == LoadingStatus.failure) {
//           return ErrorScreen(
//             simId: widget.simulatorId,
//           );
//         } else {
//           return Scrollbar(
//             controller: scrollController,
//             child: CustomScrollView(
//               shrinkWrap: true,
//               slivers: [
//                 if (state.showBanner ??
//                     false) // Show SliverAppBar only when visible
//                   SliverAppBar(
//                       backgroundColor: AppColors.transparent,
//                       floating: false,
//                       pinned: true,
//                       //TODO: add get value type here
//                       collapsedHeight: getValueForScreenType(
//                         context: context,
//                         mobile: 386,
//                         tablet: 400,
//                         // desktop: 300,
//                         desktop: Constants.width <= 1024 ? 450 : 300,
//                       ),
//                       flexibleSpace:
//                           LayoutBuilder(builder: (context, constraints) {
//                         return FlexibleSpaceBar(
//                           background: Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: getValueForScreenType(
//                                 context: context,
//                                 mobile: 8,
//                                 tablet: 18,
//                                 desktop: 60,
//                               ),
//                               // vertical: 10,
//                             ),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: getValueForScreenType(
//                                   context: context,
//                                   mobile: 14,
//                                   tablet: 18,
//                                   desktop: 20,
//                                 ),
//                                 vertical: 8,
//                               ),
//                               width: Constants.width,
//                               decoration: const BoxDecoration(
//                                 color: AppColors.boxBackGround,
//                               ),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     color: AppColors.cardCream,
//                                     child: const SheetRowTitleAndSub(),
//                                   ), // Main widget to display in the app bar
//                                   const ReviewList(), // Another widget inside the app bar
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       })),
//                 SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                   childCount: 1,
//                   (context, index) {
//                     return uiCon.bgImage(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: getValueForScreenType(
//                             context: context,
//                             mobile: 8,
//                             tablet: 18,
//                             desktop: 60,
//                           ),
//                           vertical: 10,
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             uiCon.pageHeader(
//                               userName: state.userName ?? "",
//                             ),
//                             kDim.kGap10,
//                             Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 _contentBody(
//                                   context,
//                                   state,
//                                 ),
//                               ],
//                             ),
//                             15.height,
//                             state.pricingData?.pricingWorksheetSegmentItems
//                                         ?.status ==
//                                     StringConst.completed.toUpperCase()
//                                 ? bottomCompletedButton(context)
//                                 : (state.userRole == StringConst.admin)
//                                     ? _bottomAdminButtons(context, state)
//                                     : state
//                                                     .pricingData
//                                                     ?.pricingWorksheetSegmentItems
//                                                     ?.status ==
//                                                 StringConst.approval
//                                                     .toUpperCase() &&
//                                             (state.userRole !=
//                                                 StringConst.admin)
//                                         ? bottomCompletedButton(context)
//                                         : _bottomButtons(context, state),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 )),
//               ],
//               controller: scrollController,
//               // child:
//             ),
//           );
//         }
//       },
//     );
//   }

//   Widget bottomCompletedButton(BuildContext context) {
//     return uiCon.globalButton(
//       context: context,
//       color: AppColors.maroon,
//       iconHt: 25,
//       iconWd: 25,
//       isIconFirst: true,
//       isPng: true,
//       text: StringConst.backToHome,
//       fontSize: getValueForScreenType(
//         context: context,
//         mobile: 10,
//         tablet: 13,
//         desktop: 14,
//       ),
//       assetImage: Assets.images.back.path,
//       height: getValueForScreenType(
//         context: context,
//         mobile: 30,
//         desktop: 40,
//         tablet: 35,
//       ),
//       width: getValueForScreenType(
//         context: context,
//         mobile: 200,
//         desktop: 200,
//         tablet: 150,
//       ),
//       onPressed: () {
//         context.goNamed(
//           RouteConstants.name.home,
//         );
//       },
//     );
//   }

//   //!--------(itemInnerScreen)
//   Container _contentBody(
//     BuildContext context,
//     PricingState state,
//   ) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: getValueForScreenType(
//           context: context,
//           mobile: 14,
//           tablet: 18,
//           desktop: 20,
//         ),
//         vertical: 8,
//       ),
//       width: Constants.width,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         color: AppColors.boxBackGround,
//       ),
//       child: buildTableAndInfo(
//         context,
//         state,
//       ),
//     );
//   }

//   Column buildTableAndInfo(
//     BuildContext context,
//     PricingState state,
//   ) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         //*--------(Pricing Header)
//         const PricingHeader(),
//         //*---- Pricing sheet data
//         Container(
//           color: AppColors.cardCream,
//           child: Column(
//             children: [
//               //----Sheet Row Title And Sub
//               (state.showBanner ?? false)
//                   ? const SizedBox.shrink()
//                   : const SheetRowTitleAndSub(),

//               (state.showBanner ?? false)
//                   ? const SizedBox.shrink()
//                   : const ReviewList(),

//               //----The RetailTaxMargins Row data
//               const RetailTaxMargins(),
//               //---(Distributor margin row)
//               const DistributorMarginRow(),
//               //---(Jvl Sell Price And Discount Row)
//               const JvlSellPriceAndDiscountRow(),
//               //---(net sales row )
//               const NetSalesRow(),
//               //----The CostOfSalesRow Row data
//               const CostOfSalesRow(),
//               //----The Cost Good Sold Total Row data
//               const CostGoodSoldTotalRow(),
//               //----The DeliveryAndSupplyChain Row data
//               const DeliveryAndSupplyChain(),
//               //----The DeliveryAndSupplyChain total Row data
//               const DeliveryAndSupplyTotalRow(),
//               //----The GrossProfit Total Row data
//               const GrossProfitRow(),
//               //----The GrossProfit percent Total Row data
//               const GrossProfitPercentRow(),
//               //----The SellingExpenses Row data
//               const SellingExpensesRow(),
//               //----The SellingExpenses total Row data
//               const SellExpenseTotalRow(),
//               //----The OperatingProfit Total Row data
//               const OperationProfitRow(),
//               //----The OperatingProfit percent Row data
//               const OperationProfitPercentRow(),
//             ],
//           ),
//         ),
//         //!------------Bottom Note
//         kDim.kGap10,
//         buildNote(context)
//       ],
//     );
//   }

// //!------------update,print and download-------------
//   Row buildNote(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         buildBottomIconWithText(context),
//         10.width,
//         buildTaxInfo(context),
//       ],
//     );
//   }

//   Flexible buildBottomIconWithText(BuildContext context) {
//     return Flexible(
//       flex: 1,
//       child: Row(
//         children: [
//           uiCon.svgIcon(
//             ht: 20,
//             wd: 20,
//             assetImage: Assets.icons.edit,
//             color: AppColors.headingTextBlue,
//           ),
//           const SizedBox(width: 5), // Add space between the icon and text
//           Expanded(
//             child: KStyles().reg(
//               text: StringConst.note,
//               size: getValueForScreenType(
//                 context: context,
//                 mobile: 10,
//                 tablet: 10,
//                 desktop: 13,
//               ),
//               overflow: TextOverflow.visible,
//               textAlign: TextAlign.left,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Flexible buildTaxInfo(BuildContext context) {
//     return Flexible(
//       flex: 1,
//       child: KStyles().reg(
//         text: StringConst.tax,
//         size: getValueForScreenType(
//           context: context,
//           mobile: 10,
//           tablet: 10,
//           desktop: 13,
//         ),
//         overflow: TextOverflow.visible,
//         textAlign: TextAlign.right,
//       ),
//       //  Text(
//       //   StringConst.tax,
//       //   textAlign: TextAlign.right,
//       //   style: TextStyle(
//       //     fontSize: 12,
//       //   ),
//       // ),
//     );
//   }

//   Widget _bottomButtons(
//     BuildContext context,
//     PricingState state,
//   ) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         uiCon.globalButton(
//           context: context,
//           iconColor: AppColors.white,
//           isPng: false,
//           isIconFirst: true,
//           onPressed: () {
//             context.goNamed(
//               RouteConstants.name.stepOne,
//               queryParameters: {
//                 "id": widget.simulatorId,
//               },
//             );
//           },
//         ),
//         // _saveButton(context),
//         10.width,

//         uiCon.saveButton(
//             context: context,
//             onPressed: () {
//               uiCon.dialogBuilder(
//                   context: context,
//                   child: BlocBuilder<PricingBloc, PricingState>(
//                     builder: (context, state) {
//                       return CustomDialogBox(
//                         isLoading:
//                             state.pricingSaveStatus == LoadingStatus.loading,
//                         title: StringConst.confirmSubmission,
//                         subTitle: StringConst.saveSubTitle,
//                         continueButtonText: StringConst.confirm,
//                         onPressed: () {
//                           context
//                               .read<PricingBloc>()
//                               .add(const PricingCompletedEvent());
//                         },
//                       );
//                     },
//                   ));
//               //context.read<PricingBloc>().add(const PricingCompletedEvent());
//             }),
//       ],
//     );
//   }

//   Widget _bottomAdminButtons(
//     BuildContext context,
//     PricingState state,
//   ) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         uiCon.globalButton(
//           context: context,
//           iconColor: AppColors.white,
//           isPng: false,
//           isIconFirst: true,
//           onPressed: () {
//             context.goNamed(
//               RouteConstants.name.stepOne,
//               queryParameters: {
//                 "id": widget.simulatorId,
//               },
//             );
//           },
//         ),
//         // _saveButton(context),
//         10.width,

//         uiCon.saveButton(
//             context: context,
//             onPressed: () {
//               uiCon.dialogBuilder(
//                   context: context,
//                   child: BlocBuilder<PricingBloc, PricingState>(
//                     builder: (context, state) {
//                       return CustomDialogBox(
//                         isLoading:
//                             state.pricingSaveStatus == LoadingStatus.loading,
//                         title: StringConst.confirmSubmission,
//                         subTitle: StringConst.saveSubTitle,
//                         continueButtonText: StringConst.confirm,
//                         onPressed: () {
//                           context
//                               .read<PricingBloc>()
//                               .add(const PricingCompletedEvent());
//                         },
//                       );
//                     },
//                   ));
//               //context.read<PricingBloc>().add(const PricingCompletedEvent());
//             }),
//         10.width,

//         uiCon.saveButton(
//           isSvg: true,
//           assetImage: Assets.icons.confirmTick,
//           iconHt: getValueForScreenType(
//             context: context,
//             mobile: 16,
//             tablet: 18,
//             desktop: 20,
//           ),
//           iconWd: getValueForScreenType(
//             context: context,
//             mobile: 16,
//             tablet: 18,
//             desktop: 20,
//           ),
//           text: StringConst.approve,
//           color: AppColors.kTextBlue,
//           onPressed: () {
//             uiCon.dialogBuilder(
//                 context: context,
//                 child: BlocBuilder<PricingBloc, PricingState>(
//                   builder: (context, state) {
//                     return CustomDialogBox(
//                       isLoading:
//                           state.pricingConfirmStatus == LoadingStatus.loading,
//                       title: StringConst.confirmApproval,
//                       subTitle: StringConst.approvalSubTitle,
//                       continueButtonText: StringConst.confirm,
//                       onPressed: () {
//                         context
//                             .read<PricingBloc>()
//                             .add(const PricingApproveEvent());
//                       },
//                     );
//                   },
//                 ));
//           },
//           context: context,
//         ),
//       ],
//     );
//   }
// }

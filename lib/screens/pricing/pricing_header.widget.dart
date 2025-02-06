import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/utils/enums.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../bloc/pricing_bloc/pricing_bloc.dart';
import '../../gen/assets.gen.dart';
import '../../styles/text_styles.dart';
import '../../themes/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/string_const.dart';
import '../../widgets/custom_save_dialogue.dart';
import 'custom_pricing_widgets/responsive_image_button.widget.dart';
import 'pricing_widgets/sim_version_card.widget.dart';

class PricingHeader extends StatelessWidget {
  const PricingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        return Column(
          children: [
            // buildMonthCustomerInfo(context, state),
            // 10.height,
            buildPrintDownload(
              context,
              state,
            ),
            5.height,
          ],
        );
      },
    );
  }
}

Widget buildPrintDownload(
  BuildContext context,
  PricingState state,
) {
  var pricingItems = state.pricingData?.pricingWorksheetSegmentItems;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      //*--------created by and approved by ,last update--------

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildMonthCustomerInfo(context, state),
            10.height,
            //created by and created on
            Flexible(
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                    child: KStyles().bold(
                      color: AppColors.headingTextBlue,
                      text: "${StringConst.createdBy.toUpperCase()} : ",
                      size: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 10,
                        desktop: 13,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  WidgetSpan(
                    child: KStyles().bold(
                      color: AppColors.maroon,
                      text: (pricingItems?.createdBy?.isNotEmpty ?? false)
                          ? "${pricingItems?.createdBy?.toUpperCase() ?? ""} , "
                          : "",
                      size: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 10,
                        desktop: 13,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  WidgetSpan(
                    child: KStyles().bold(
                      color: AppColors.maroon,
                      text: (pricingItems?.createdOn?.isNotEmpty ?? false)
                          ? (pricingItems?.createdOn?.toUpperCase() ?? "")
                          : "",
                      size: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 10,
                        desktop: 13,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ]),
              ),
            ),
            //approved by and approved on

            Flexible(
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                    child: KStyles().bold(
                      color: AppColors.headingTextBlue,
                      text: "${StringConst.approvedBy.toUpperCase()} : ",
                      size: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 10,
                        desktop: 13,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  WidgetSpan(
                    child: KStyles().bold(
                      color: AppColors.maroon,
                      text: (pricingItems?.approvedBy?.isNotEmpty ?? false)
                          ? "${pricingItems?.approvedBy?.toUpperCase() ?? ""} , "
                          : "",
                      size: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 10,
                        desktop: 13,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  WidgetSpan(
                    child: KStyles().bold(
                      color: AppColors.maroon,
                      text: (pricingItems?.approvedOn?.isNotEmpty ?? false)
                          ? (pricingItems?.approvedOn?.toUpperCase() ?? "")
                          : "",
                      size: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 10,
                        desktop: 13,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ]),
              ),
            ),
            // subsidiary sold
            Flexible(
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                    child: KStyles().bold(
                      color: AppColors.headingTextBlue,
                      text: (state.pricingData?.pricingWorksheetSegmentItems
                                      ?.customers ??
                                  "")
                              .contains(",")
                          ? "${StringConst.customers.toUpperCase()} : "
                          : "${StringConst.customer.toUpperCase()} : ",
                      size: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 10,
                        desktop: 13,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  WidgetSpan(
                    child: KStyles().bold(
                      color: AppColors.maroon,
                      text: fCon.removeExtraSpaces(state.pricingData
                              ?.pricingWorksheetSegmentItems?.customers ??
                          ""),
                      size: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 10,
                        desktop: 13,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ]),
              ),
            ),
            //subsidiary sold
            Flexible(
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                    child: KStyles().bold(
                      color: AppColors.headingTextBlue,
                      text: "${StringConst.subsidiarySold.toUpperCase()} : ",
                      size: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 10,
                        desktop: 13,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  WidgetSpan(
                    child: KStyles().bold(
                      color: AppColors.maroon,
                      text: state.pricingData?.pricingWorksheetSegmentItems
                              ?.jvlSubsidiary ??
                          "",
                      size: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 10,
                        desktop: 13,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ]),
              ),
            ),
            Flexible(
              child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                    child: KStyles().bold(
                      color: AppColors.headingTextBlue,
                      text: "${StringConst.estimatedSellVol.toUpperCase()} : ",
                      size: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 10,
                        desktop: 13,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  WidgetSpan(
                    child: KStyles().bold(
                      color: AppColors.maroon,
                      text: fCon.formatWithThousandSeparator(state.pricingData
                              ?.pricingWorksheetSegmentItems?.sellVolume ??
                          ""),
                      size: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 10,
                        desktop: 13,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),

//*--------sim version card--------
      const Flexible(
        child: SimVersionCard(),
      ),

      //*--------print & download--------
      Column(
        crossAxisAlignment: getValueForScreenType(
          context: context,
          mobile: CrossAxisAlignment.end,
          tablet: CrossAxisAlignment.end,
          desktop: CrossAxisAlignment.start,
        ),
        children: [
          //*--------Reuse section--------
          state.pricingData?.pricingWorksheetSegmentItems?.status ==
                  StringConst.completed.toUpperCase()
              ? ResponsiveImageButton(
                  // isLoading:
                  //     state.replicateSheetStatus == LoadingStatus.loading,
                  onTap: () {
                    uiCon.dialogBuilder(
                        context: context,
                        child: BlocBuilder<PricingBloc, PricingState>(
                          builder: (context, state) {
                            return CustomDialogBox(
                              isLoading: state.replicateSheetStatus ==
                                  LoadingStatus.loading,
                              title: StringConst.confirmReplication,
                              subTitle: StringConst.replicateSubTitle,
                              continueButtonText:
                                  StringConst.replicate.toUpperCase(),
                              onPressed: () {
                                context
                                    .read<PricingBloc>()
                                    .add(const ReplicateSheetEvent());
                                // context
                                //     .read<PricingBloc>()
                                //     .add(const PricingCompletedEvent());
                              },
                            );
                          },
                        ));
                    // context
                    //     .read<PricingBloc>()
                    //     .add(const ReplicateSheetEvent());
                  },
                  image: Assets.images.reuse.path,
                  text: StringConst.replicate.toUpperCase(),
                )
              : const SizedBox.shrink(),
          kDim.kGap05,
          ResponsiveImageButton(
            isLoading: state.excelDownloadingStatus == LoadingStatus.loading,
            onTap: () {
              context.read<PricingBloc>().add(const DownloadExcelEvent());
            },
            image: Assets.images.download.path,
            text: StringConst.downloadExcel,
          ),
          kDim.kGap05,

          //*------print to pdf------
          ResponsiveImageButton(
            isLoading: state.pdfDownloadingStatus == LoadingStatus.loading,
            onTap: () async {
              context.read<PricingBloc>().add(const DownloadPdfEvent());
            },
            image: Assets.images.print.path,
            text: StringConst.print,
          ),
          // ResponsiveDownloadButton(),
        ],
      ),
    ],
  );
}

//*-----------pricing sheet heading-------------
Widget buildMonthCustomerInfo(
  BuildContext context,
  PricingState state,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        // flex: 3,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KStyles().bold(
              overflow: TextOverflow.visible,
              size: getValueForScreenType(
                context: context,
                mobile: 13,
                tablet: 18,
                desktop: Constants.width >= 1040 ? 25 : 20,
              ),
              text:
                  state.pricingData?.pricingWorksheetSegmentItems?.title ?? "",
              color: AppColors.headingTextBlue,
            ),
            KStyles().bold(
              size: getValueForScreenType(
                context: context,
                mobile: 13,
                tablet: 18,
                desktop: Constants.width >= 1040 ? 25 : 20,
              ),
              text: " - ",
              color: AppColors.maroon,
            ),
            KStyles().bold(
              size: getValueForScreenType(
                context: context,
                mobile: 13,
                tablet: 18,
                desktop: Constants.width >= 1040 ? 25 : 20,
              ),
              text: state
                      .pricingData?.pricingWorksheetSegmentItems?.projectName ??
                  "",
              color: AppColors.maroon,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 8,
            //   ),
            //   child: Container(
            //     width: 1,
            //     height: 30,
            //     color: AppColors.kTextBlue,
            //   ),
            // ),
            // uiCon.statusBar(
            //   context,
            //   status:
            //       state.pricingData?.pricingWorksheetSegmentItems?.status ?? "",
            // ),
            // 50.width,
          ],
        ),
      ),
      // uiCon.statusBar(
      //   context,
      //   showReview: false,
      //   reviewerName: "Jamie Wisman".toUpperCase(),
      //   status: state.pricingData?.pricingWorksheetSegmentItems?.status ?? "",
      // ),
      //*----(month and location details)
      // _monthAndLocationDetails(context, state),
    ],
  );
}

//*----------(month and location details)-------------
// Widget _monthAndLocationDetails(
//   BuildContext context,
//   PricingState state,
// ) {
//   return Expanded(
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Flexible(
//           child: _monthLocation(context),
//         ),
//         10.width,
//         Flexible(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //*-----month------------
//               Flexible(
//                 child: KStyles().bold(
//                   size: getValueForScreenType(
//                     context: context,
//                     mobile: 9,
//                     tablet: 12,
//                     desktop: 14,
//                   ),
//                   text:
//                       state.pricingData?.pricingWorksheetSegmentItems?.month ??
//                           "",
//                   color: AppColors.maroon,
//                 ),
//               ),
//               //*----Location------------
//               Flexible(
//                 child: KStyles().bold(
//                   overflow: TextOverflow.visible,
//                   size: getValueForScreenType(
//                     context: context,
//                     mobile: 9,
//                     tablet: 12,
//                     desktop: 13,
//                   ),
//                   text: state.pricingData?.pricingWorksheetSegmentItems
//                           ?.jvlSubsidiary ??
//                       "",
//                   color: AppColors.maroon,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

//*------------month & customer heading-----------
// Column _monthLocation(context) {
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     crossAxisAlignment: CrossAxisAlignment.end,
//     children: [
// //*-----month heading-----------
//       Flexible(
//         child: KStyles().bold(
//           size: getValueForScreenType(
//             context: context,
//             mobile: 9,
//             tablet: 12,
//             desktop: 14,
//           ),
//           text: "${StringConst.month} :",
//           color: AppColors.headingTextBlue,
//         ),
//       ),
//       //*----customer heading-----------
//       Flexible(
//         child: KStyles().bold(
//           size: getValueForScreenType(
//             context: context,
//             mobile: 9,
//             tablet: 12,
//             desktop: 14,
//           ),
//           text: "${StringConst.subsidiarySold} :",
//           color: AppColors.headingTextBlue,
//         ),
//       ),
//     ],
//   );
// }

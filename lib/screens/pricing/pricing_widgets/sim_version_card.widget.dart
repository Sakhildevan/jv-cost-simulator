import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';
import 'package:johnsonville_cost_simulator/utils/enums.dart';
import 'package:johnsonville_cost_simulator/utils/string_const.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../config/config.dart';
import '../../../styles/text_styles.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_save_dialogue.dart';
import 'pricing_version_chip.widget.dart';

class SimVersionCard extends StatelessWidget {
  const SimVersionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PricingBloc, PricingState>(
      listener: (context, state) {
        // Automatically close the dialog after saving successfully
        if (state.deleteThisVersionStatus == LoadingStatus.success ||
            state.deleteThisVersionStatus == LoadingStatus.failure) {
          Future.delayed(const Duration(seconds: 1), () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop(); // Auto-close the dialog
              // Reset the state for further actions
              context.read<PricingBloc>().add(const ResetStatusEvent());
            }
          });
        }
      },
      builder: (context, state) {
        return Container(
          // height: 150,
          // color: AppColors.red,
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: kDim.kRadius10,
              color: AppColors.cardCream,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    KStyles().bold(
                      text:
                          "No. of Simulations : ${state.revisionList?.length ?? 0}"
                              .toUpperCase(),
                      size: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 12,
                        desktop: Constants.width <= 1024 ? 18 : 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Container(
                        width: 1,
                        height: 30,
                        color: AppColors.kTextBlue,
                      ),
                    ),
                    uiCon.statusBar(
                      context,
                      status: state.pricingData?.pricingWorksheetSegmentItems
                              ?.status ??
                          "",
                    ),
                  ],
                ),
                kDim.kGap05,
                if (state.pricingData?.pricingWorksheetSegmentItems?.status
                            ?.toUpperCase() ==
                        StringConst.approval.toUpperCase() ||
                    state.pricingData?.pricingWorksheetSegmentItems?.status
                            ?.toUpperCase() ==
                        StringConst.completed.toUpperCase())
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: kDim.kRadius05,
                      color: AppColors.kTextBlue,
                    ),
                    child: KStyles().med(
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      color: AppColors.white,
                      text:
                          "Optimised Simulator GP: ${state.pricingData?.pricingWorksheetSegmentItems?.grossProfitpercent?.data?.firstOrNull?.valInUsd ?? "0"} %"
                              .toUpperCase(),
                      size: getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 13,
                        desktop: 15,
                      ),
                    ),
                  ),
                if (state.pricingData?.pricingWorksheetSegmentItems?.status
                            ?.toUpperCase() ==
                        StringConst.approval.toUpperCase() ||
                    state.pricingData?.pricingWorksheetSegmentItems?.status
                            ?.toUpperCase() ==
                        StringConst.completed.toUpperCase())
                  kDim.kGap05,
                Wrap(
                  runSpacing: 5,
                  spacing: 3,
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: List.generate(
                    state.revisionList?.length ?? 0,
                    (index) {
                      var data = state.revisionList?[index];
                      return CustomPricingChip(
                        showDelete: state.pricingData
                                        ?.pricingWorksheetSegmentItems?.status
                                        ?.toUpperCase() ==
                                    StringConst.approval.toUpperCase() &&
                                state.userRole?.toUpperCase() ==
                                    StringConst.admin.toUpperCase() ||
                            state.pricingData?.pricingWorksheetSegmentItems
                                    ?.status
                                    ?.toUpperCase() ==
                                StringConst.pending.toUpperCase(),
                        isLoading: (data?.revisionNo) ==
                                state.selectedVersion &&
                            state.versionExcelStatus == LoadingStatus.loading,
                        onTap: () {
                          context.read<PricingBloc>().add(
                                VersionDownloadExcelEvent(
                                  versionNo: data?.revisionNo ?? "",
                                ),
                              );
                        },
                        onDeleteTap: () {
                          _showDeleteDialog(
                            context: context,
                            versionNo: data?.revisionNo ?? "",
                          );
                          // uiCon.dialogBuilder(
                          //   context: context,
                          //   child: BlocBuilder<PricingBloc, PricingState>(
                          //     builder: (context, state) {
                          //       return CustomDialogBox(
                          //         isLoading: state.deleteThisVersionStatus ==
                          //             LoadingStatus.loading,
                          //         title: StringConst.confirmDelete,
                          //         subTitle: StringConst.deleteSubTitle,
                          //         continueButtonText: StringConst.confirm,
                          //         onPressed: () {
                          //           context.read<PricingBloc>().add(
                          //                 DeleteVersionEvent(
                          //                   versionNo: data?.revisionNo ?? "",
                          //                 ),
                          //               );
                          //         },
                          //       );
                          //     },
                          //   ),
                          // );
                        },
                        overflow: TextOverflow.visible,
                        label: data?.revisionNoText ?? "",
                        textColor: AppColors.black,
                        color: AppColors.cream,
                        borderColor: AppColors.transparent,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteDialog({
    required BuildContext context,
    required String versionNo,
  }) {
    uiCon
        .dialogBuilder(
      context: context,
      child: BlocBuilder<PricingBloc, PricingState>(
        builder: (context, state) {
          if (state.deleteThisVersionStatus == LoadingStatus.loading) {
            return CustomDialogBox(
              isLoading: true,
              title: StringConst.confirmDelete,
              subTitle: StringConst.deleteSubTitle,
              continueButtonText: StringConst.confirm,
              onPressed: () {
                context.read<PricingBloc>().add(
                      DeleteVersionEvent(
                        versionNo: versionNo,
                      ),
                    );
              },
            );
          } else if (state.deleteThisVersionStatus == LoadingStatus.success) {
            //!------------(success pop up)
            return uiCon.customStatusPop(
              type: DialogType.success,
              title: StringConst.success,
              subTitle: "Version deleted successfully",
            );
          } else if (state.deleteThisVersionStatus == LoadingStatus.failure) {
            //!------------(failure pop up)
            return uiCon.customStatusPop(
                type: DialogType.failure,
                title: StringConst.failure,
                subTitle: state.versionResp?.errorOnFailure ?? "");
          } else {
            return CustomDialogBox(
              isLoading: false,
              title: StringConst.confirmDelete,
              subTitle: StringConst.deleteSubTitle,
              continueButtonText: StringConst.confirm,
              onPressed: () {
                context.read<PricingBloc>().add(
                      DeleteVersionEvent(
                        versionNo: versionNo,
                      ),
                    );
              },
            );
          }
        },
      ),
    )
        .then(
      (value) {
        context.read<PricingBloc>().add(const ResetStatusEvent());
      },
    );
  }
}

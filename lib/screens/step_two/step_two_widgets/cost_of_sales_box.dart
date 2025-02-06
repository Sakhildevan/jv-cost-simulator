import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';

import '../../../bloc/step_two_bloc/step_two_bloc.dart';
import '../../../config/config.dart';
import '../../../gen/assets.gen.dart';
import '../../../styles/text_styles.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/string_const.dart';
import '../../../widgets/custom_box_title.dart';
import '../../../widgets/custom_input_formatter.dart';
import '../../../widgets/custom_text_field_label.dart';
import '../../../widgets/post_frame_callback.dart';
import '../../step_one/step_one_widgets/custom_selection_box.widget.dart';

//*------------------------------------CostOfSalesBox Page-----------------------------------------!
class CostOfSalesBox extends StatelessWidget {
  const CostOfSalesBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //*-----------------Menu Controllers----------------
    MenuController stdMenuCtrl = MenuController();
    // MenuController ppvMenuCtrl = MenuController();
    // MenuController mgmMenuCtrl = MenuController();
    //MenuController cosOthersCtrl = MenuController();
    //*-----------------Text Controllers----------------
    final TextEditingController stdCostCtrl = TextEditingController();
    final TextEditingController calculatedStdCostCtrl = TextEditingController();
    // final TextEditingController meatPpvCtrl = TextEditingController();
    // final TextEditingController mgfVarCtrl = TextEditingController();
    // final TextEditingController othersLabelTxtCtrl = TextEditingController();
    // final TextEditingController othersValueTxtCtrl = TextEditingController();
    final TextEditingController stdCostCommentCtrl = TextEditingController();
    final TextEditingController grossMarginTargetCtrl = TextEditingController();
    // final TextEditingController meatPpvCommentCtrl = TextEditingController();
    // final TextEditingController cosOthersCommentCtrl = TextEditingController();
    // final TextEditingController mgfVarCommentCtrl = TextEditingController();

    void addPostFrameCallback() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final state = context.read<StepTwoBloc>().state;

        //   formatWithThousandSeparator((() {
        //     final shelfPriceTax =
        //         double.tryParse(state.costSimulatorDetails.shelfPriceTax) ?? 0;
        //     final retailMargin =
        //         double.tryParse(state.costSimulatorDetails.retailerMargin) ?? 0;
        //     final estDistributorMargin = double.tryParse(
        //             state.costSimulatorDetails.estDistributorMarginOn) ??
        //         0;

        //     return (shelfPriceTax *
        //             (1 - (retailMargin / 100)) *
        //             (1 - (estDistributorMargin / 100)))
        //         .toStringAsFixed(2);
        //   })()),
        // );
        //*----- gross margin target
        updateTextController(
          showPercentage: true,
          grossMarginTargetCtrl,
          state.costSimulatorDetails.estDistributorMarginOn,
        );
        //*---- calculated Std cost
        updateTextController(
          calculatedStdCostCtrl,
          formatWithThousandSeparator(
              state.costSimulatorDetails.calculatedStandardCost),
        );
        //*--- std cost
        updateTextController(
          stdCostCtrl,
          formatWithThousandSeparator(state.costSimulatorDetails.standardCost),
        );
        //*--- meat ppv
        // updateTextController(
        //   meatPpvCtrl,
        //   state.costSimulatorDetails.cosMeatPpv,
        // );
        //*--- mgf variance
        // updateTextController(
        //   mgfVarCtrl,
        //   state.costSimulatorDetails.cosMfgVariance,
        // );
        //*--- others label
        // updateTextController(
        //   othersLabelTxtCtrl,
        //   state.costSimulatorDetails.cosOther?.label,
        // );
        //*--- others value
        // updateTextController(
        //   othersValueTxtCtrl,
        //   state.costSimulatorDetails.cosOther?.value,
        // );
        // updateTextController(
        //   cosOthersCommentCtrl,
        //   state.commentFields.cosOthersComment,
        // );
        //*--- cost of sales comment
        updateTextController(
          stdCostCommentCtrl,
          state.commentFields.costofSalesComment,
        );
        // updateTextController(
        //   meatPpvCommentCtrl,
        //   state.commentFields.meatPpvComment,
        // );
        // updateTextController(
        //   mgfVarCommentCtrl,
        //   state.commentFields.mgfVarianceComment,
        // );
      });
    }

    return BlocConsumer<StepTwoBloc, StepTwoState>(
      listener: (context, state) {},
      builder: (context, state) {
        addPostFrameCallback();
        if (state.loadingStatus == LoadingStatus.loading) {
          return uiCon.shimmerLoader(
            type: ShimmerType.box,
          );
        }
        //*-----------------CustomBoxTitle----------------
        return CustomBoxTitle(
          commentCtrl: stdCostCommentCtrl,
          comment: state.commentFields.costofSalesComment,
          menuCtrl: stdMenuCtrl,
          cmntBox: true,
          messageOnSaved: (String message) {
            context
                .read<StepTwoBloc>()
                .add(CostOfSales(coscostofSalesComment: message));
            context.read<StepTwoBloc>().add(
                  SaveComment(
                    commentFieldName: StringConst.costsaleCmnt,
                    commentDescription: message,
                  ),
                );
          },
          imagePath: Assets.images.costOfSales.path,
          title: StringConst.costOfSales,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //*--------- gross margin target
              CustomTextFieldLabel(
                keyboardType: TextInputType.number,
                inputFormat: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}'),
                  ),
                ],
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                onChanged: (estDistributorMarginOn) {
                  context.read<StepTwoBloc>().add(DistributorMarginImport(
                      estDistributorMarginOn: estDistributorMarginOn));
                },
                controller: grossMarginTargetCtrl,
                text: StringConst.grossMarginTarget,
                content: true,
                message: false,
                child: _subText("%", context),
              ),
              10.height,

              //*----------------- calculated COGS
              CustomTextFieldLabel(
                readOnly: true,
                enabled: false,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                ],
                // commonValidator: (String? value) {
                //   return fCon.commonValidation(
                //     inputValue: value ?? "",
                //     errorMsg: StringConst.enterValueError,
                //   );
                // },
                onChanged: (calculatedStandardCost) {
                  context.read<StepTwoBloc>().add(CostOfSales(
                      standardCost: fCon.removeComma(calculatedStandardCost)));
                },
                menuCtrl: stdMenuCtrl,
                controller: calculatedStdCostCtrl,
                text: StringConst.calculatedCogsEst,
                // text: StringConst.calculatedStandardCost,
                content: true,
                message: false,
                child: _subRichText(state, context),
              ),
              10.height,
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: KStyles().med(
                      size: fontCon.boxLabelFontSize(context),
                      overflow: TextOverflow.visible,
                      text: StringConst.isYourCalCogsDiffFromAbove,
                      color: AppColors.black,
                    ),
                  ),
                  10.width,
                  Expanded(
                    flex: 2,
                    child: CustomSelectionRow(
                      firstOption: StringConst.yes,
                      secondOption: StringConst.no,
                      onTap: (String value) {
                        if (value == StringConst.yes) {
                          context.read<StepTwoBloc>().add(
                                CostOfSales(
                                  isYourStdCostDiffFromAbove: value,
                                  standardCost: '',
                                ),
                              );
                        } else {
                          context.read<StepTwoBloc>().add(
                                CostOfSales(
                                  isYourStdCostDiffFromAbove: value,
                                  standardCost: state.costSimulatorDetails
                                      .calculatedStandardCost,
                                ),
                              );
                        }
                      },
                      selectedOption:
                          state.costSimulatorDetails.isYourStdCostDiffFromAbove,
                      isMetricEmpty: false,
                    ),
                  ),
                  10.width,
                  const Expanded(flex: 2, child: SizedBox()),
                ],
              ),

              10.height,
              //*-----------------Calculated cost TextFieldLabel----------------
              CustomTextFieldLabel(
                readOnly:
                    state.costSimulatorDetails.isYourStdCostDiffFromAbove ==
                            StringConst.no
                        ? true
                        : false,
                enabled:
                    state.costSimulatorDetails.isYourStdCostDiffFromAbove ==
                            StringConst.no
                        ? false
                        : true,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                ],
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                onChanged: (standardCost) {
                  context.read<StepTwoBloc>().add(CostOfSales(
                      standardCost: fCon.removeComma(standardCost)));
                },
                menuCtrl: stdMenuCtrl,
                controller: stdCostCtrl,
                text: StringConst.calculatedCogsEstUpdated,
                content: true,
                message: false,
                child: _subRichText(state, context),
              ),
              10.height,
              //*-----------------meat ppv TextFieldLabel----------------
              // CustomTextFieldLabel(
              //   keyboardType: TextInputType.number,
              //   inputFormat: [
              //     FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              //   ],
              //   controller: meatPpvCtrl,
              //   // commentCtrl: meatPpvCommentCtrl,
              //   // addbuttonenabled: false,
              //   // messageOnSaved: (String? message) {
              //   //   context
              //   //       .read<StepTwoBloc>()
              //   //       .add(CostOfSales(cosMeatPpvComment: message));
              //   //   //?*---- message on saved
              //   //   context.read<StepTwoBloc>().add(
              //   //         SaveComment(
              //   //           commentDescription: message,
              //   //           commentFieldName: StringConst.meatPPV,
              //   //         ),
              //   //       );
              //   // },
              //   commonValidator: (String? value) {
              //     return fCon.commonValidation(
              //       inputValue: value ?? "",
              //       errorMsg: StringConst.enterValueError,
              //     );
              //   },
              //   onChanged: (cosMeatPpv) {
              //     context
              //         .read<StepTwoBloc>()
              //         .add(CostOfSales(cosMeatPpv: cosMeatPpv));
              //   },
              //   // menuCtrl: ppvMenuCtrl,
              //   //TODO  /:comment message box
              //   message: false,
              //   text: StringConst.meatPPV,
              //   content: true,
              //   // comment: state.commentFields.meatPpvComment,
              //   child: _subText(
              //     StringConst.usdMetric,
              //     context,
              //   ),
              // ),
              // 10.height,
              //*-----------------Mgf variance TextFieldLabel----------------
              // CustomTextFieldLabel(
              //   keyboardType: TextInputType.number,
              //   inputFormat: [
              //     FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              //   ],
              //   //commentCtrl: mgfVarCommentCtrl,
              //   // messageOnSaved: (String? message) {
              //   //   context
              //   //       .read<StepTwoBloc>()
              //   //       .add(CostOfSales(cosMfgVarianceComment: message));
              //   //   //?*---- message on saved
              //   //   context.read<StepTwoBloc>().add(
              //   //         SaveComment(
              //   //           commentDescription: message,
              //   //           commentFieldName: StringConst.mgfVariance,
              //   //         ),
              //   //       );
              //   // },
              //   controller: mgfVarCtrl,
              //   // addbuttonenabled: false,
              //   commonValidator: (String? value) {
              //     return fCon.commonValidation(
              //       inputValue: value ?? "",
              //       errorMsg: StringConst.enterValueError,
              //     );
              //   },
              //   onChanged: (String cosMfgVariance) {
              //     context
              //         .read<StepTwoBloc>()
              //         .add(CostOfSales(cosMfgVariance: cosMfgVariance));
              //   },
              //   // menuCtrl: mgmMenuCtrl,
              //   //TODO  /:comment message box
              //   message: false,
              //   text: StringConst.mgfVariance,
              //   content: true,
              //   // comment: state.commentFields.mgfVarianceComment,
              //   child: _subText(
              //     StringConst.usdMetric,
              //     context,
              //   ),
              // ),
              // 10.height,
              //*------------others field
              //ToDo-------------------others field----------------
              // CustomTextfieldOthers(
              //   othersLimit: state.costSimulatorDetails.othersLimit,
              //   labelController: othersLabelTxtCtrl,
              //   valueController: othersValueTxtCtrl,
              //   dataList: state.costSimulatorDetails.cosOtherList,
              //   onAddTap: () {
              //     context.read<StepTwoBloc>().add(const OtherListAdd(
              //           otherType: OtherType.costOfSales,
              //         ));
              //   },
              //   onValueChanged: (Other other) {
              //     context.read<StepTwoBloc>().add(CostOfSales(cosOther: other));
              //   },
              //   onDeleteTap: (int index) {
              //     context.read<StepTwoBloc>().add(OtherListRemove(
              //           index: index,
              //           otherType: OtherType.costOfSales,
              //         ));
              //   },
              // ),

              //*-----------------SelectionYesNoBox----------------
              // Row(
              //   children: [
              //     Expanded(
              //       flex: 2,
              //       child: KStyles().reg(
              //         size: getValueForScreenType(
              //           context: context,
              //           mobile: 10,
              //           tablet: 12,
              //           desktop: 14,
              //         ),
              //         text: StringConst.others,
              //         color: AppColors.black,
              //       ),
              //     ),
              //     10.width,
              //     Expanded(
              //         flex: 2,
              //         child: CustomSelectionRow(
              //           firstOption: StringConst.yes,
              //           secondOption: StringConst.no,
              //           onTap: (String value) {
              //             context
              //                 .read<StepTwoBloc>()
              //                 .add(CostOfSales(isOtherSelected: value));
              //           },
              //           selectedOption:
              //               state.costSimulatorDetails.isOtherSelected,
              //           isMetricEmpty: false,
              //         )),
              //     10.width,
              //     const Expanded(flex: 2, child: SizedBox()),
              //   ],
              // ),
              // 10.height,
              // //*-----------------Visibility----------------
              // _onPressYesShow(state, othersTxtCtrl, cosOthersCommentCtrl,
              //     cosOthersCtrl, context),
            ],
          ),
        );
      },
    );
  }

//*-----------------Visibility----------------
  // Visibility _onPressYesShow(
  //     StepTwoState state,
  //     TextEditingController othersTxtCtrl,
  //     TextEditingController cosOthersCommentCtrl,
  //     MenuController cosOthersCtrl,
  //     BuildContext context) {
  //   return Visibility(
  //     visible: state.costSimulatorDetails.isOtherSelected == StringConst.yes,
  //     child: Column(
  //       children: [
  //         CustomTextFieldLabel(
  //           keyboardType: TextInputType.number,
  //           inputFormat: [
  //             FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
  //           ],
  //           commentCtrl: cosOthersCommentCtrl,
  //           messageOnSaved: (String? message) {
  //             context
  //                 .read<StepTwoBloc>()
  //                 .add(CostOfSales(cosOthersComment: message));
  //             //?*---- message on saved
  //             context.read<StepTwoBloc>().add(
  //                   SaveComment(
  //                     commentDescription: message,
  //                     commentFieldName: StringConst.cosOthers,
  //                   ),
  //                 );
  //           },
  //           controller: othersTxtCtrl,
  //           onChanged: (String cosOthers) {
  //             context
  //                 .read<StepTwoBloc>()
  //                 .add(CostOfSales(cosOthers: cosOthers));
  //           },
  //           commonValidator: (String? value) {
  //             return fCon.commonValidation(
  //               inputValue: value ?? "",
  //               errorMsg: StringConst.enterValueError,
  //             );
  //           },
  //           menuCtrl: cosOthersCtrl,
  //           //TODO  /:comment message box
  //           message: false,
  //           comment: state.commentFields.cosOthersComment,
  //           text: StringConst.others,
  //           content: true,
  //           //addbuttonenabled: false,
  //           child: _subText(
  //             StringConst.usdMetric,
  //             context,
  //           ),
  //         ),
  //         10.height,
  //       ],
  //     ),
  //   );
  // }

//*-----------------subRichText----------------
  RichText _subRichText(StepTwoState state, BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: KStyles().med(
              text: state.costSimulatorDetails.itemCurrency,
              color: AppColors.maroon,
              size: fontCon.boxsubFontSize(context),
            ),
          ),
          WidgetSpan(
            child: (state.costSimulatorDetails.sellUnitOfMeasure?.unitCode
                        ?.isNotEmpty ??
                    false)
                ? _subText(
                    "/${state.costSimulatorDetails.sellUnitOfMeasure?.unitCode ?? ""}",
                    context,
                  )
                : _subText(
                    StringConst.metricWithSlash,
                    context,
                  ),
          ),
        ],
      ),
    );
  }
//*-----------------SubText----------------

  Widget _subText(String subText, BuildContext context) {
    return KStyles().med(
      text: subText,
      color: AppColors.black,
      size: fontCon.boxsubFontSize(context),
    );
  }
}

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

//*------------------------------------SellingExpenseBox Page-----------------------------------------!
class SellingExpenseBox extends StatelessWidget {
  const SellingExpenseBox({super.key});

  @override
  Widget build(BuildContext context) {
    //*---------Menu Controllers----------------
    MenuController sellExpenseMenuCtrl = MenuController();
    // MenuController advConsumerMenuCtrl = MenuController();
    // MenuController tradeSpendMenuCtrl = MenuController();
    // MenuController peopleOthersMenuCtrl = MenuController();
    //MenuController sellingOtherMenuCtrl = MenuController();
    //*---------Text Controllers----------------
    final TextEditingController subsidiaryTradeTxtCtrl =
        TextEditingController();
    final TextEditingController advConsumerTxtCtrl = TextEditingController();
    final TextEditingController tradeSpendTxtCtrl = TextEditingController();
    final TextEditingController brokerTxtCtrl = TextEditingController();
    // final TextEditingController othersLabelTxtCtrl = TextEditingController();
    // final TextEditingController othersValueTxtCtrl = TextEditingController();
    // final TextEditingController sellingOtherComntCtrl = TextEditingController();

    final TextEditingController peopleOthersTxtCtrl = TextEditingController();
    //*-------- comment controller-------
    final TextEditingController sellExpenseCommentCtrl =
        TextEditingController();
    // final TextEditingController advConsCommentCtrl = TextEditingController();
    // final TextEditingController tradeSpendCommentCtrl = TextEditingController();
    // final TextEditingController peopleOthersCommentCtrl =
    //     TextEditingController();
    //*---------PostFrameCallback----------------
    void addPostFrameCallback() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final state = context.read<StepTwoBloc>().state;
        updateTextController(
          subsidiaryTradeTxtCtrl,
          formatWithThousandSeparator(
            state.costSimulatorDetails.subsidiaryTrade,
          ),
        );
        updateTextController(
          advConsumerTxtCtrl,
          formatWithThousandSeparator(
            state.costSimulatorDetails.advConsumer,
          ),
        );
        updateTextController(
          tradeSpendTxtCtrl,
          formatWithThousandSeparator(
            state.costSimulatorDetails.tradeSpend,
          ),
        );
        updateTextController(
          brokerTxtCtrl,
          formatWithThousandSeparator(
            state.costSimulatorDetails.broker,
          ),
        );
        // updateTextController(
        //   sellingOtherComntCtrl,
        //   state.commentFields.sellingExpensesOthersCmmnt,
        // );
        updateTextController(
          peopleOthersTxtCtrl,
          formatWithThousandSeparator(
              state.costSimulatorDetails.peopleAndOthers),
        );
        updateTextController(
          sellExpenseCommentCtrl,
          state.commentFields.sellingExpensesComment,
        );
        // updateTextController(
        //   advConsCommentCtrl,
        //   state.commentFields.advConsumerComment,
        // );
        // updateTextController(
        //   tradeSpendCommentCtrl,
        //   state.commentFields.tradeSpendComment,
        // );
        // updateTextController(
        //   peopleOthersCommentCtrl,
        //   state.commentFields.peopleOthersComment,
        // );
        // updateTextController(
        //   othersLabelTxtCtrl,
        //   state.costSimulatorDetails.sellingExpensesOther?.label,
        // );
        // updateTextController(
        //   othersValueTxtCtrl,
        //   state.costSimulatorDetails.sellingExpensesOther?.value,
        // );
      });
    }

    //*---------CustomBoxTitle----------------
    return BlocConsumer<StepTwoBloc, StepTwoState>(
      listener: (context, state) {
        // addPostFrameCallback();
      },
      builder: (context, state) {
        addPostFrameCallback();
        if (state.loadingStatus == LoadingStatus.loading) {
          return uiCon.shimmerLoader(
            type: ShimmerType.box,
          );
        }
        return CustomBoxTitle(
          cmntBox: true,
          commentCtrl: sellExpenseCommentCtrl,
          menuCtrl: sellExpenseMenuCtrl,
          comment: state.commentFields.sellingExpensesComment,
          messageOnSaved: (String? message) {
            context.read<StepTwoBloc>().add(
                  SellingExpense(sellingExpensesComment: message),
                );
            context.read<StepTwoBloc>().add(
                  SaveComment(
                    commentFieldName: StringConst.sellingExpenseCmnt,
                    commentDescription: message,
                  ),
                );
          },
          imagePath: Assets.images.retailTaxMargin.path,
          title: StringConst.sellingExpenses,
          child: Column(
            children: [
              //*-----------------Subsidiary Trade/Mktg ----------------
              CustomTextFieldLabel(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                ],
                //commentCtrl: subTradeCommentCtrl,
                // messageOnSaved: (String? message) {
                //   context
                //       .read<StepTwoBloc>()
                //       .add(SellingExpense(subsidiaryTradeComment: message));
                //   //?*---- message on saved
                //   context.read<StepTwoBloc>().add(SaveComment(
                //         commentDescription: message,
                //         commentFieldName: StringConst.subsidiaryTrade,
                //       ));
                // },
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                onChanged: (subsidiaryTrade) {
                  context.read<StepTwoBloc>().add(SellingExpense(
                      subsidiaryTrade: fCon.removeComma(subsidiaryTrade)));
                },
                controller: subsidiaryTradeTxtCtrl,
                // menuCtrl: subsidiaryTradeMenuCtrl,
                //todo  /:comment message box
                message: false,
                // addbuttonenabled: false,
                text: StringConst.subsidiaryTradeMktg,
                content: true,
                // comment: state.commentFields.subsidiaryTradeComment,
                child: _subRichText(state, context),
              ),
              10.height,
              //*-----------------Adv Consumer ----------------
              CustomTextFieldLabel(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                ],
                // commentCtrl: advConsCommentCtrl,
                // messageOnSaved: (String? message) {
                //   context
                //       .read<StepTwoBloc>()
                //       .add(SellingExpense(advConsumerComment: message));
                //   //?*---- message on saved
                //   context.read<StepTwoBloc>().add(
                //         SaveComment(
                //           commentDescription: message,
                //           commentFieldName: StringConst.advAndConsumer,
                //         ),
                //       );
                // },
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                onChanged: (advConsumer) {
                  context.read<StepTwoBloc>().add(SellingExpense(
                      advConsumer: fCon.removeComma(advConsumer)));
                },
                controller: advConsumerTxtCtrl,
                // menuCtrl: advConsumerMenuCtrl,
                //todo  /:comment message box
                message: false,
                // addbuttonenabled: false,
                text: StringConst.advConsumer,
                content: true,
                // comment: state.commentFields.advConsumerComment,
                child: _subRichText(state, context),
                //  _subText(StringConst.usdMetric, context),
              ),
              10.height,
              //*-----------------Trade Spend ----------------
              CustomTextFieldLabel(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                ],
                // commentCtrl: tradeSpendCommentCtrl,
                // messageOnSaved: (String? message) {
                //   context
                //       .read<StepTwoBloc>()
                //       .add(SellingExpense(tradeSpendComment: message));
                //   //?*---- message on saved
                //   context.read<StepTwoBloc>().add(
                //         SaveComment(
                //           commentDescription: message,
                //           commentFieldName: StringConst.tradeSpend,
                //         ),
                //       );
                //   addPostFrameCallback();
                // },
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                onChanged: (tradeSpend) {
                  context.read<StepTwoBloc>().add(
                      SellingExpense(tradeSpend: fCon.removeComma(tradeSpend)));
                },
                controller: tradeSpendTxtCtrl,
                // menuCtrl: tradeSpendMenuCtrl,
                //todo  /:comment message box
                message: false,
                // addbuttonenabled: false,
                text: StringConst.tradeSpend,
                content: true,
                // comment: state.commentFields.tradeSpendComment,
                child: _subRichText(state, context),
                // child: _subText(StringConst.usdMetric, context),
              ),
              10.height,
              //*-----------------Broker ----------------
              CustomTextFieldLabel(
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
                onChanged: (broker) {
                  context.read<StepTwoBloc>().add(
                        SellingExpense(
                          broker: fCon.removeComma(broker),
                        ),
                      );
                },
                controller: brokerTxtCtrl,
                message: false,

                text: StringConst.broker,
                content: true,
                // comment: state.commentFields.tradeSpendComment,
                child: _subRichText(state, context),
                // child: _subText(StringConst.usdMetric, context),
              ),
              10.height,
              //*-----------------People & Others ----------------
              CustomTextFieldLabel(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                ],
                // commentCtrl: peopleOthersCommentCtrl,
                // messageOnSaved: (String? message) {
                //   context
                //       .read<StepTwoBloc>()
                //       .add(SellingExpense(peopleAndOthersComment: message));
                //   //?*---- message on saved
                //   context.read<StepTwoBloc>().add(
                //         SaveComment(
                //           commentDescription: message,
                //           commentFieldName: StringConst.peopleAndOthers,
                //         ),
                //       );
                // },
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                onChanged: (peopleAndOthers) {
                  context.read<StepTwoBloc>().add(SellingExpense(
                      peopleAndOthers: fCon.removeComma(peopleAndOthers)));
                },
                controller: peopleOthersTxtCtrl,
                //menuCtrl: peopleOthersMenuCtrl,
                //todo  /:comment message box
                message: false,
                // addbuttonenabled: false,
                text: StringConst.peopleAndOthers,
                content: true,
                // comment: state.commentFields.peopleOthersComment,
                child: _subRichText(state, context),
                // child: _subText(StringConst.usdMetric, context),
              ),
              10.height,
              //*---------other field----------
              //ToDo-------------------others field----------------
              // CustomTextfieldOthers(
              //   othersLimit: state.costSimulatorDetails.othersLimit,
              //   labelController: othersLabelTxtCtrl,
              //   valueController: othersValueTxtCtrl,
              //   dataList: state.costSimulatorDetails.sellExpenseOtherList,
              //   onAddTap: () {
              //     context.read<StepTwoBloc>().add(const OtherListAdd(
              //           otherType: OtherType.sellExpense,
              //         ));
              //   },
              //   onDeleteTap: (int index) {
              //     context.read<StepTwoBloc>().add(OtherListRemove(
              //           index: index,
              //           otherType: OtherType.sellExpense,
              //         ));
              //   },
              //   onValueChanged: (Other other) {
              //     context
              //         .read<StepTwoBloc>()
              //         .add(SellingExpense(sellingExpensesOthers: other));
              //   },
              // ),
              // CustomTextFieldLabel(
              //   keyboardType: TextInputType.number,
              //   inputFormat: [
              //     FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              //   ],
              //   commentCtrl: sellingOtherComntCtrl,
              //   messageOnSaved: (String? message) {
              //     context.read<StepTwoBloc>().add(
              //           SellingExpense(sellingExpensesOthersCmmnt: message),
              //         );
              //     context.read<StepTwoBloc>().add(
              //           SaveComment(
              //               commentFieldName: StringConst.sellingOthers,
              //               commentDescription: message),
              //         );
              //   },

              //   controller: othersTxtCtrl,
              //   onChanged: (String value) {
              //     context.read<StepTwoBloc>().add(
              //           SellingExpense(sellingExpensesOthers: value),
              //         );
              //   },
              //   // commonValidator: (String? value) {
              //   //   return fCon.commonValidation(
              //   //     inputValue: value ?? "",
              //   //     errorMsg: StringConst.enterValueError,
              //   //   );
              //   // },
              //   menuCtrl: sellingOtherMenuCtrl,
              //   //todo  /:comment message box
              //   message: false,
              //   comment: state.commentFields.sellingExpensesOthersCmmnt,
              //   text: StringConst.others,
              //   content: true,
              //   // addbuttonenabled: false,
              //   child: _subText(
              //     StringConst.usdMetric,
              //     context,
              //   ),
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
              //             context.read<StepTwoBloc>().add(
              //                   SellingExpense(isOtherSelected: value),
              //                 );
              //           },
              //           selectedOption: state
              //               .costSimulatorDetails.isSellingExpenseOtherSelected,
              //           isMetricEmpty: false,
              //         )),
              //     10.width,
              //     const Expanded(flex: 2, child: SizedBox()),
              //   ],
              // ),
              // 10.height,
              // _onPressYesShow(
              //   state,
              //   othersTxtCtrl,
              //   sellingOtherComntCtrl,
              //   sellingOtherMenuCtrl,
              //   context,
              // ),
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
  //     TextEditingController sellingOtherComntCtrl,
  //     MenuController sellingOtherMenuctrl,
  //     BuildContext context) {
  //   return Visibility(
  //     visible: state.costSimulatorDetails.isSellingExpenseOtherSelected ==
  //         StringConst.yes,
  //     child: Column(
  //       children: [
  //         CustomTextFieldLabel(
  //           keyboardType: TextInputType.number,
  //           inputFormat: [
  //             FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
  //           ],
  //           commentCtrl: sellingOtherComntCtrl,
  //           messageOnSaved: (String? message) {
  //             context.read<StepTwoBloc>().add(
  //                   SellingExpense(sellingExpensesOthersCmmnt: message),
  //                 );
  //             context.read<StepTwoBloc>().add(
  //                   SaveComment(
  //                       commentFieldName: StringConst.sellingOthers,
  //                       commentDescription: message),
  //                 );
  //           },

  //           controller: othersTxtCtrl,
  //           onChanged: (String value) {
  //             context.read<StepTwoBloc>().add(
  //                   SellingExpense(sellingExpensesOthers: value),
  //                 );
  //           },
  //           commonValidator: (String? value) {
  //             return fCon.commonValidation(
  //               inputValue: value ?? "",
  //               errorMsg: StringConst.enterValueError,
  //             );
  //           },
  //           menuCtrl: sellingOtherMenuctrl,
  //           //todo  /:comment message box
  //           message: false,
  //           comment: state.commentFields.sellingExpensesOthersCmmnt,
  //           text: StringConst.others,
  //           content: true,
  //           // addbuttonenabled: false,
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

//*------------------------------------Subtext-----------------------------------------!
  // RichText _subRichText(StepTwoState state, BuildContext context) {
  //   return RichText(
  //     text: TextSpan(
  //       children: [
  //         WidgetSpan(
  //           child: KStyles().med(
  //             text: state.costSimulatorDetails.itemCurrency,
  //             color: AppColors.maroon,
  //             size: fontCon.boxsubFontSize(context),
  //           ),
  //         ),
  //         WidgetSpan(
  //           child: _subText(
  //             StringConst.metricWithSlash,
  //             context,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
//*------------------------------------SellingExpenseBox Page-----------------------------------------!

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
            child: (state.costSimulatorDetails.sellUnitOfMeasure?.unitName
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

  Widget _subText(String subText, BuildContext context) {
    return KStyles().med(
      text: subText,
      color: AppColors.black,
      size: fontCon.boxsubFontSize(context),
    );
  }
  // Widget _subText(String subText, BuildContext context) {
  //   return KStyles().med(
  //     text: subText,
  //     color: AppColors.black,
  //     size: fontCon.boxsubFontSize(context),
  //   );
  // }
}

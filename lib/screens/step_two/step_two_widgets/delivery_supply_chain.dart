import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:johnsonville_cost_simulator/utils/string_const.dart';

import '../../../bloc/step_two_bloc/step_two_bloc.dart';
import '../../../config/config.dart';
import '../../../data/model/load_simulator.model.dart';
import '../../../gen/assets.gen.dart';
import '../../../styles/text_styles.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../widgets/custom_box_title.dart';
import '../../../widgets/custom_input_formatter.dart';
import '../../../widgets/custom_text_field_label.dart';
import '../../../widgets/custom_textfield_others.dart';
import '../../../widgets/post_frame_callback.dart';

//!------------------------------------DeliverySupplyChainBox Page-----------------------------------------!
class DeliverySupplyChainBox extends StatelessWidget {
  const DeliverySupplyChainBox({super.key});

  @override
  Widget build(BuildContext context) {
    //!---------Menu Controllers----------------
    MenuController deliveryMenuCtrl = MenuController();
    // MenuController localTransMenuCtrl = MenuController();
    // MenuController importFeeMenuCtrl = MenuController();
    // MenuController foreignSupplyMenuCtrl = MenuController();
    // MenuController usSupplyMenuCtrl = MenuController();
    //MenuController deliverySupplyMenuCtrl = MenuController();
    //!---------Text Controllers----------------
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController localTransTxtCtrl = TextEditingController();
    final TextEditingController importFeeTxtCtrl = TextEditingController();
    final TextEditingController foreignTxtCtrl = TextEditingController();
    final TextEditingController usDeliveryTxtCtrl = TextEditingController();
    final TextEditingController usSupplyTxtCtrl = TextEditingController();
    //!---------Comment Controllers----------------
    final TextEditingController deliverySupplyCommentCtrl =
        TextEditingController();
    final TextEditingController othersLabelTxtCtrl = TextEditingController();
    final TextEditingController othersValueTxtCtrl = TextEditingController();
    // final TextEditingController othersTxtCtrl = TextEditingController();
    // final TextEditingController importFeeCommentCtrl = TextEditingController();
    // final TextEditingController foreignCommentCtrl = TextEditingController();
    // final TextEditingController usDeliveryCommentCtrl = TextEditingController();
    // final TextEditingController localTransCommentCtrl = TextEditingController();
    // final TextEditingController usSupplyCommentCtrl = TextEditingController();
    void addPostFrameCallback() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final state = context.read<StepTwoBloc>().state;
        updateTextController(
          localTransTxtCtrl,
          formatWithThousandSeparator(
              state.costSimulatorDetails.localTransport),
        );
        updateTextController(
          importFeeTxtCtrl,
          formatWithThousandSeparator(state.costSimulatorDetails.importFees),
        );
        updateTextController(
          foreignTxtCtrl,
          formatWithThousandSeparator(
              state.costSimulatorDetails.foreignSupplyChain),
        );
        updateTextController(
          usDeliveryTxtCtrl,
          formatWithThousandSeparator(state.costSimulatorDetails.usDelivery),
        );
        updateTextController(
          usSupplyTxtCtrl,
          formatWithThousandSeparator(state.costSimulatorDetails.usSupplyChain),
        );
        updateTextController(
          deliverySupplyCommentCtrl,
          formatWithThousandSeparator(
              state.commentFields.deliveryandSuppChainComment),
        );
        // updateTextController(
        //   localTransCommentCtrl,
        //   state.commentFields.localTransportComment,
        // );
        // updateTextController(
        //   importFeeCommentCtrl,
        //   state.commentFields.importFeesComment,
        // );
        // updateTextController(
        //   foreignCommentCtrl,
        //   state.commentFields.foreignSupplyChainComment,
        // );
        // updateTextController(
        //   usDeliveryCommentCtrl,
        //   state.commentFields.usDeliveryComment,
        // );
        // updateTextController(
        //   usSupplyCommentCtrl,
        //   state.commentFields.usSupplyChainComment,
        // );
        updateTextController(
          othersLabelTxtCtrl,
          state.costSimulatorDetails.deliverySupplyChainOther?.label,
        );
        updateTextController(
          othersValueTxtCtrl,
          formatWithThousandSeparator(
              state.costSimulatorDetails.deliverySupplyChainOther?.value),
        );
        // updateTextController(
        //   localTransCommentCtrl,
        //   state.commentFields.localTransportComment,
        // );
        // updateTextController(
        //   importFeeCommentCtrl,
        //   state.commentFields.importFeesComment,
        // );
        // updateTextController(
        //   foreignCommentCtrl,
        //   state.commentFields.foreignSupplyChainComment,
        // );
        // updateTextController(
        //   usDeliveryCommentCtrl,
        //   state.commentFields.usDeliveryComment,
        // );
        // updateTextController(
        //   usSupplyCommentCtrl,
        //   state.commentFields.usSupplyChainComment,
        // );
      });
    }

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
          commentCtrl: deliverySupplyCommentCtrl,
          menuCtrl: deliveryMenuCtrl,
          comment: state.commentFields.deliveryandSuppChainComment,
          messageOnSaved: (String message) {
            context.read<StepTwoBloc>().add(DeliveryAndSupplyChain(
                  deliveryandSuppChainComment: message,
                ));
            //?*---- message on saved
            context.read<StepTwoBloc>().add(
                  SaveComment(
                    commentDescription: message,
                    commentFieldName: StringConst.deliverysupplyCmnt,
                  ),
                );
          },
          imagePath: Assets.images.delivery.path,
          title: StringConst.deliveryAndSupplyChain,
          child: Column(
            children: [
              //!-----------------importFees TextField----------------
              CustomTextFieldLabel(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                ],
                // commentCtrl: importFeeCommentCtrl,
                // messageOnSaved: (String? message) {
                //   context.read<StepTwoBloc>().add(DeliveryAndSupplyChain(
                //         importFeesComment: message,
                //       ));
                //   //?*---- message on saved
                //   context.read<StepTwoBloc>().add(
                //         SaveComment(
                //           commentDescription: message,
                //           commentFieldName: StringConst.importFees,
                //         ),
                //       );
                // },
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                controller: importFeeTxtCtrl,
                // addbuttonenabled: false,
                onChanged: (importFees) {
                  context.read<StepTwoBloc>().add(DeliveryAndSupplyChain(
                      importFees: fCon.removeComma(importFees)));
                },
                // menuCtrl: importFeeMenuCtrl,
                text: StringConst.importFees,
                content: true,
                //TODO  /:comment message box
                message: false,
                // comment: state.commentFields.importFeesComment,
                child: _subRichText(state, context),
                //  _subText(
                //   StringConst.usdMetric,
                //   context,
                // ),
              ),
              10.height,
              //!-----------------localTransport----------------
              CustomTextFieldLabel(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                ],
                //commentCtrl: localTransCommentCtrl,
                // messageOnSaved: (String? message) {
                //   context.read<StepTwoBloc>().add(
                //       DeliveryAndSupplyChain(localTransportComment: message));
                //   //?*---- message on saved
                //   context.read<StepTwoBloc>().add(
                //         SaveComment(
                //           commentDescription: message,
                //           commentFieldName: StringConst.localTransport,
                //         ),
                //       );
                // },
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                onChanged: (localTransport) {
                  context.read<StepTwoBloc>().add(DeliveryAndSupplyChain(
                      localTransport: fCon.removeComma(localTransport)));
                },
                //menuCtrl: localTransMenuCtrl,
                controller: localTransTxtCtrl,
                //TODO  /:comment message box
                message: false,
                text: StringConst.localTransport,
                content: true,
                //comment: state.commentFields.localTransportComment,
                child: _subRichText(state, context),
                //  _subText(
                //   StringConst.usdMetric,
                //   context,
                // ),
              ),
              10.height,
              //!-----------------foreignSupplyChain----------------
              CustomTextFieldLabel(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                ],
                // commentCtrl: foreignCommentCtrl,
                // messageOnSaved: (String? message) {
                //   context.read<StepTwoBloc>().add(DeliveryAndSupplyChain(
                //       foreignSupplyChainComment: message));
                //   //?*---- message on saved
                //   context.read<StepTwoBloc>().add(
                //         SaveComment(
                //           commentDescription: message,
                //           commentFieldName: StringConst.foreignSupplyChain,
                //         ),
                //       );
                // },
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                onChanged: (foreignSupplyChain) {
                  context.read<StepTwoBloc>().add(DeliveryAndSupplyChain(
                      foreignSupplyChain:
                          fCon.removeComma(foreignSupplyChain)));
                },
                // menuCtrl: foreignSupplyMenuCtrl,
                controller: foreignTxtCtrl,
                // addbuttonenabled: false,
                //TODO  /:comment message box
                message: false,
                text: StringConst.foreignLocalChainSplashObsol,
                content: true,
                // comment: state.commentFields.foreignSupplyChainComment,
                child: _subRichText(state, context),
                //  _subText(
                //   StringConst.usdMetric,
                //   context,
                // ),
              ),
              10.height,
              //!-----------------usDelivery----------------
              CustomTextFieldLabel(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                ],
                // commentCtrl: usDeliveryCommentCtrl,
                // messageOnSaved: (String? message) {
                //   context
                //       .read<StepTwoBloc>()
                //       .add(DeliveryAndSupplyChain(usDeliveryComment: message));
                //   //?*---- message on saved
                //   context.read<StepTwoBloc>().add(
                //         SaveComment(
                //           commentDescription: message,
                //           commentFieldName: StringConst.usDelivery,
                //         ),
                //       );
                // },
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                onChanged: (usDelivery) {
                  context.read<StepTwoBloc>().add(DeliveryAndSupplyChain(
                      usDelivery: fCon.removeComma(usDelivery)));
                },
                // menuCtrl: usDeliveryMenuCtrl,
                controller: usDeliveryTxtCtrl,
                // addbuttonenabled: false,
                //TODO  /:comment message box
                message: false,
                text: StringConst.delivery,
                content: true,
                // comment: state.commentFields.usDeliveryComment,
                child: _subRichText(state, context),
                //  _subText(
                //   StringConst.usdMetric,
                //   context,
                // ),
              ),
              10.height,
              //!-----------------usSupplyChain----------------
              CustomTextFieldLabel(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                ],
                //  commentCtrl: usSupplyCommentCtrl,
                // messageOnSaved: (String? message) {
                //   context.read<StepTwoBloc>().add(
                //       DeliveryAndSupplyChain(usSupplyChainComment: message));
                //   //?*---- message on saved
                //   context.read<StepTwoBloc>().add(
                //         SaveComment(
                //           commentDescription: message,
                //           commentFieldName: StringConst.usSupplyChain,
                //         ),
                //       );
                // },
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                onChanged: (usSupplyChain) {
                  context.read<StepTwoBloc>().add(DeliveryAndSupplyChain(
                      usSupplyChain: fCon.removeComma(usSupplyChain)));
                },
                // menuCtrl: usSupplyMenuCtrl,
                controller: usSupplyTxtCtrl,
                // addbuttonenabled: false,
                //TODO  /:comment message box
                message: false,
                text: StringConst.supplyChain,
                content: true,
                // comment: state.commentFields.usSupplyChainComment,
                child: _subRichText(state, context),
                // _subText(
                //   StringConst.usdMetric,
                //   context,
                // ),
              ),
              10.height,
              //!-----------others field----------
              //ToDo-------------------others field----------------
              Form(
                key: formKey,
                child: CustomTextfieldOthers(
                  sellUnitOfMeasure:
                      state.costSimulatorDetails.sellUnitOfMeasure?.unitCode,
                  itemCurrency: state.costSimulatorDetails.itemCurrency,
                  othersLimit: state.costSimulatorDetails.othersLimit,
                  labelController: othersLabelTxtCtrl,
                  valueController: othersValueTxtCtrl,
                  dataList: state.costSimulatorDetails.deliverySupplyOtherList,
                  onAddTap: () {
                    if (formKey.currentState!.validate()) {
                      context.read<StepTwoBloc>().add(const OtherListAdd(
                            otherType: OtherType.deliverySupply,
                          ));
                    }
                  },
                  onDeleteTap: (int index) {
                    context.read<StepTwoBloc>().add(OtherListRemove(
                          index: index,
                          otherType: OtherType.deliverySupply,
                        ));
                  },
                  onValueChanged: (Other other) {
                    context.read<StepTwoBloc>().add(DeliveryAndSupplyChain(
                        deliverySupplyChainOthers: other));
                  },
                ),
              ),
              // CustomTextFieldLabel(
              //   keyboardType: TextInputType.number,
              //   inputFormat: [
              //     FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              //   ],
              //   commentCtrl: deliverySupplyCommentCtrl,
              //   messageOnSaved: (String? message) {
              //     context.read<StepTwoBloc>().add(DeliveryAndSupplyChain(
              //         deliverySupplyChainOthersCmmnt: message));
              //     //* message on saved
              //     context.read<StepTwoBloc>().add(
              //           SaveComment(
              //             commentFieldName: StringConst.deliveryothers,
              //             commentDescription: message,
              //           ),
              //         );
              //   },
              //   controller: othersTxtCtrl,
              //   onChanged: (String value) {
              //     context.read<StepTwoBloc>().add(
              //           DeliveryAndSupplyChain(
              //             deliverySupplyChainOthers: value,
              //           ),
              //         );
              //   },
              //   // commonValidator: (String? value) {
              //   //   return fCon.commonValidation(
              //   //     inputValue: value ?? "",
              //   //     errorMsg: StringConst.enterValueError,
              //   //   );
              //   // },
              //   menuCtrl: deliverySupplyMenuCtrl,
              //   //TODO  /:comment message box
              //   message: false,
              //   comment: state.commentFields.deliverySupplyChainOthersCmmnt,
              //   text: StringConst.others,
              //   content: true,
              //   // addbuttonenabled: false,
              //   child: _subText(
              //     StringConst.usdMetric,
              //     context,
              //   ),
              // ),
              //!-----------------SelectionYesNoBox----------------
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
              //                   DeliveryAndSupplyChain(isOtherSelected: value),
              //                 );
              //           },
              //           selectedOption:
              //               state.costSimulatorDetails.isDeliveryOtherSelected,
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
              //   deliverySupplyCommentCtrl,
              //   deliverySupplyMenuCtrl,
              //   context,
              // ),
            ],
          ),
        );
      },
    );
  }

//!-----------------Visibility----------------
  // Visibility _onPressYesShow(
  //     StepTwoState state,
  //     TextEditingController othersTxtCtrl,
  //     TextEditingController deliverySupplyCommentCtrl,
  //     MenuController deliverySupplyMenuCtrl,
  //     BuildContext context) {
  //   return Visibility(
  //     visible:
  //         state.costSimulatorDetails.isDeliveryOtherSelected == StringConst.yes,
  //     child: Column(
  //       children: [
  //         CustomTextFieldLabel(
  //           keyboardType: TextInputType.number,
  //           inputFormat: [
  //             FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
  //           ],
  //           commentCtrl: deliverySupplyCommentCtrl,
  //           messageOnSaved: (String? message) {
  //             context.read<StepTwoBloc>().add(DeliveryAndSupplyChain(
  //                 deliverySupplyChainOthersCmmnt: message));
  //             //* message on saved
  //             context.read<StepTwoBloc>().add(
  //                   SaveComment(
  //                     commentFieldName: StringConst.deliveryothers,
  //                     commentDescription: message,
  //                   ),
  //                 );
  //           },
  //           controller: othersTxtCtrl,
  //           onChanged: (String value) {
  //             context.read<StepTwoBloc>().add(
  //                   DeliveryAndSupplyChain(
  //                     deliverySupplyChainOthers: value,
  //                   ),
  //                 );
  //           },
  //           commonValidator: (String? value) {
  //             return fCon.commonValidation(
  //               inputValue: value ?? "",
  //               errorMsg: StringConst.enterValueError,
  //             );
  //           },
  //           menuCtrl: deliverySupplyMenuCtrl,
  //           //TODO  /:comment message box
  //           message: false,
  //           comment: state.commentFields.deliverySupplyChainOthersCmmnt,
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

//!-----------------subRichText----------------
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

//!-----------------subText----------------
  Widget _subText(String subText, BuildContext context) {
    return KStyles().reg(
      text: subText,
      color: AppColors.black,
      size: fontCon.boxsubFontSize(context),
    );
  }
}

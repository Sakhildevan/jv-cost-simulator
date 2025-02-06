import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';

import '../../../bloc/step_two_bloc/step_two_bloc.dart';
import '../../../config/config.dart';
import '../../../data/model/load_simulator.model.dart';
import '../../../gen/assets.gen.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/string_const.dart';
import '../../../widgets/custom_box_title.dart';
import '../../../widgets/custom_input_formatter.dart';
import '../../../widgets/custom_text_field_label.dart';
import '../../../widgets/custom_textfield_others.dart';
import '../../../widgets/post_frame_callback.dart';

//!------------------------------------JvlSellAndDiscountsBox Page-----------------------------------------!
class JvlSellAndDiscountsBox extends StatelessWidget {
  const JvlSellAndDiscountsBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //!---------Menu Controllers----------------
    // MenuController foreignMenuCtrl = MenuController();
    MenuController sellMenuCtrl = MenuController();
    // MenuController promoMenuDiscount = MenuController();
    // MenuController custDiscountMenuCtrl = MenuController();
    //MenuController sellOtherMenuCtrl = MenuController();

    //!---------Text Controllers----------------
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController sellPriceForeignTxtCtrl =
        TextEditingController();
    final TextEditingController sellPriceUsdTxtCtrl = TextEditingController();
    final TextEditingController promoDisTxtCtrl = TextEditingController();
    final TextEditingController custDisTxtCtrl = TextEditingController();
    final TextEditingController othersLabelTxtCtrl = TextEditingController();
    final TextEditingController othersValueTxtCtrl = TextEditingController();
    // final TextEditingController othersTxtCtrl = TextEditingController();
    // final TextEditingController sellOthersCommentCtrl = TextEditingController();
    //!-------- comment controller-------------
    final TextEditingController sellCommentCtrl = TextEditingController();
    // final TextEditingController sellPriceUsdCommentCtrl =
    //     TextEditingController();
    // final TextEditingController promoDisCommentCtrl = TextEditingController();
    // final TextEditingController custDisCommentCtrl = TextEditingController();
    //!---------PostFrameCallback----------------
    void addPostFrameCallback() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final state = context.read<StepTwoBloc>().state;
        updateTextController(
            sellPriceForeignTxtCtrl,
            formatWithThousandSeparator(
                state.costSimulatorDetails.jvlSellPriceForeignCurr));
        updateTextController(
            sellPriceUsdTxtCtrl,
            formatWithThousandSeparator(
                state.costSimulatorDetails.jvlSellPriceUsd));
        updateTextController(
          promoDisTxtCtrl,
          formatWithThousandSeparator(
              state.costSimulatorDetails.discountsPromo),
        );
        updateTextController(
          custDisTxtCtrl,
          formatWithThousandSeparator(
              state.costSimulatorDetails.discountsCustomer),
        );
        updateTextController(
          sellCommentCtrl,
          state.commentFields.sellPriceandDiscountComment,
        );
        // updateTextController(
        //   sellPriceUsdCommentCtrl,
        //   state.commentFields.jvlSellPriceUsdComment,
        // );
        // updateTextController(
        //   promoDisCommentCtrl,
        //   state.commentFields.discountPromoComment,
        // );
        // updateTextController(
        //   custDisCommentCtrl,
        //   state.commentFields.discountCustomerProgComment,
        // );
        // updateTextController(
        //   sellOthersCommentCtrl,
        //   state.commentFields.sellPriceDiscountOthersCmmnt,
        // );
        updateTextController(
          othersLabelTxtCtrl,
          state.costSimulatorDetails.sellPriceDiscountOther?.label,
        );
        updateTextController(
          othersValueTxtCtrl,
          formatWithThousandSeparator(
              state.costSimulatorDetails.sellPriceDiscountOther?.value),
        );
      });
    }

//!-----------------CustomBoxTitle----------------
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
          commentCtrl: sellCommentCtrl,
          menuCtrl: sellMenuCtrl,
          comment: state.commentFields.sellPriceandDiscountComment,
          messageOnSaved: (String message) {
            context.read<StepTwoBloc>().add(
                  JvlSellPriceAndDiscounts(
                    sellPriceandDiscountComment: message,
                  ),
                );
            context.read<StepTwoBloc>().add(
                  SaveComment(
                    commentDescription: message,
                    commentFieldName: StringConst.sellPriceCmnt,
                  ),
                );
          },
          imagePath: Assets.images.distributorMargin.path,
          title: StringConst.jvlSellPriceAndDiscount,
          child: Column(
            children: [
              //!-----------------SellPriceForeignCurr----------------
              //TODO: commented for future use
              // CustomTextFieldLabel(
              //   keyboardType:
              //       const TextInputType.numberWithOptions(decimal: true),
              //   inputFormat: <TextInputFormatter>[
              //     DecimalFormatter(decimalDigits: 2),
              //   ],

              //   //commentCtrl: sellPriceForeignCommentCtrl,
              //   // messageOnSaved: (String? message) {
              //   //   context.read<StepTwoBloc>().add(JvlSellPriceAndDiscounts(
              //   //         jvlSellPriceForeignCurrComment: message,
              //   //       ));
              //   //   //?*---- message on saved
              //   //   context.read<StepTwoBloc>().add(
              //   //         SaveComment(
              //   //           commentDescription: message,
              //   //           commentFieldName:
              //   //               StringConst.jvlSellPriceForeignCurrency,
              //   //         ),
              //   //       );
              //   // },
              //   commonValidator: (String? value) {
              //     return fCon.commonValidation(
              //       inputValue: value ?? "",
              //       errorMsg: StringConst.enterValueError,
              //     );
              //   },
              //   onChanged: (jvlSellPriceForeignCurr) {
              //     context.read<StepTwoBloc>().add(JvlSellPriceAndDiscounts(
              //           jvlSellPriceForeignCurr:
              //               fCon.removeComma(jvlSellPriceForeignCurr),
              //         ));
              //   },
              //   controller: sellPriceForeignTxtCtrl,
              //   // menuCtrl: foreignMenuCtrl,
              //   // addbuttonenabled: false,
              //   text: StringConst.jvlSellPriceText +
              //       state.costSimulatorDetails.itemCurrency,
              //   content: true,
              //   //TODO  /:comment message box
              //   message: false,
              //   // comment: state.commentFields.jvlSellPriceForeignCurrencyComment,
              //   child: _subRichText(
              //     state,
              //     context,
              //   ),
              // ),
              10.height,
              //!-----------------JvlSellPriceUsd----------------
              // CustomTextFieldLabel(
              //   keyboardType: TextInputType.number,
              //   inputFormat: [
              //     FilteringTextInputFormatter.allow(
              //       RegExp(r'^\d+\.?\d{0,2}'),
              //     ),
              //   ],
              //   commentCtrl: sellPriceUsdCommentCtrl,
              //   messageOnSaved: (String? message) {
              //     context.read<StepTwoBloc>().add(JvlSellPriceAndDiscounts(
              //           jvlSellPriceUsdComment: message,
              //         ));
              //     //?*---- message on saved
              //     context.read<StepTwoBloc>().add(
              //           SaveComment(
              //             commentDescription: message,
              //             commentFieldName: StringConst.jvlSellPriceUsd,
              //           ),
              //         );
              //   },
              //   commonValidator: (String? value) {
              //     return fCon.commonValidation(
              //       inputValue: value ?? "",
              //       errorMsg: StringConst.enterValueError,
              //     );
              //   },
              //   onChanged: (jvlSellPriceUsd) {
              //     context.read<StepTwoBloc>().add(JvlSellPriceAndDiscounts(
              //           jvlSellPriceUsd: jvlSellPriceUsd,
              //         ));
              //   },
              //   controller: sellPriceUsdTxtCtrl,
              //   menuCtrl: sellMenuCtrl,
              // addbuttonenabled: false,
              //   text: StringConst.jvlSellPriceUsd,
              //   content: true,
              //   message: true,
              //   comment: state.commentFields.jvlSellPriceUsdComment,
              //   child: _subText(StringConst.usdMetric, context),
              // ),
              // 10.height,
              //!-----------------DiscountsPromoJvlAllow----------------
              CustomTextFieldLabel(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                ],
                //commentCtrl: promoDisCommentCtrl,
                // messageOnSaved: (String? message) {
                //   context.read<StepTwoBloc>().add(JvlSellPriceAndDiscounts(
                //         discountsPromoComment: message,
                //       ));
                //   //?*---- message on saved
                //   context.read<StepTwoBloc>().add(
                //         SaveComment(
                //           commentDescription: message,
                //           commentFieldName: StringConst.discountsPromo,
                //         ),
                //       );
                // },
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                onChanged: (discountsPromo) {
                  context.read<StepTwoBloc>().add(
                        JvlSellPriceAndDiscounts(
                          discountsPromo: fCon.removeComma(discountsPromo),
                        ),
                      );
                },
                controller: promoDisTxtCtrl,
                //menuCtrl: promoMenuDiscount,
                // addbuttonenabled: false,
                text: StringConst.discountsPromoJvlAllow,
                content: true,
                //TODO  /:comment message box
                message: false,
                // comment: state.commentFields.discountPromoComment,
                child: _subRichText(state, context),
              ),
              10.height,
              //!-----------------DiscountCustomerProg----------------
              CustomTextFieldLabel(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                ],
                //commentCtrl: custDisCommentCtrl,
                // messageOnSaved: (String? message) {
                //   context.read<StepTwoBloc>().add(JvlSellPriceAndDiscounts(
                //         discountsCustomerComment: message,
                //       ));
                //   //?*---- message on saved
                //   context.read<StepTwoBloc>().add(
                //         SaveComment(
                //           commentDescription: message,
                //           commentFieldName: StringConst.discountCustomerProg,
                //         ),
                //       );
                // },
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                onChanged: (discountsCustomer) {
                  context.read<StepTwoBloc>().add(JvlSellPriceAndDiscounts(
                        discountsCustomer: fCon.removeComma(discountsCustomer),
                      ));
                },
                controller: custDisTxtCtrl,
                // menuCtrl: custDiscountMenuCtrl,
                // addbuttonenabled: false,
                text: StringConst.discountCustomerProg,
                content: true,
                //TODO  /:comment message box
                message: false,
                //comment: state.commentFields.discountCustomerProgComment,
                child: _subRichText(state, context),
              ),
              10.height,
              //!------------others field
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
                  dataList: state.costSimulatorDetails.sellDiscountOtherList,
                  onAddTap: () {
                    if (formKey.currentState!.validate()) {
                      context.read<StepTwoBloc>().add(const OtherListAdd(
                            otherType: OtherType.sellPriceAndDiscount,
                          ));
                    }
                  },
                  onDeleteTap: (int index) {
                    context.read<StepTwoBloc>().add(OtherListRemove(
                          index: index,
                          otherType: OtherType.sellPriceAndDiscount,
                        ));
                  },
                  onValueChanged: (Other other) {
                    context.read<StepTwoBloc>().add(JvlSellPriceAndDiscounts(
                        sellPriceDiscountOthers: other));
                  },
                ),
              ),
              // CustomTextFieldLabel(
              //   keyboardType: TextInputType.number,
              //   inputFormat: [
              //     FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              //   ],
              //   commentCtrl: sellOthersCommentCtrl,
              //   messageOnSaved: (String? message) {
              //     context.read<StepTwoBloc>().add(JvlSellPriceAndDiscounts(
              //           sellPriceDiscountOthersCmmnt: message,
              //         ));
              //     //?*---- message on saved
              //     context.read<StepTwoBloc>().add(
              //           SaveComment(
              //             commentDescription: message,
              //             commentFieldName: StringConst.sellPriceDiscountOthers,
              //           ),
              //         );
              //   },
              //   controller: othersTxtCtrl,
              //   onChanged: (String sellPriceDiscountOthers) {
              //     context.read<StepTwoBloc>().add(JvlSellPriceAndDiscounts(
              //         sellPriceDiscountOthers: sellPriceDiscountOthers));
              //   },
              //   // commonValidator: (String? value) {
              //   //   return fCon.commonValidation(
              //   //     inputValue: value ?? "",
              //   //     errorMsg: StringConst.enterValueError,
              //   //   );
              //   // },
              //   menuCtrl: sellOtherMenuCtrl,
              //   //TODO  /:comment message box
              //   message: false,
              //   comment: state.commentFields.sellPriceDiscountOthersCmmnt,
              //   text: StringConst.others,
              //   content: true,
              //   // addbuttonenabled: false,
              //   child: _subText(
              //     StringConst.usdMetric,
              //     context,
              //   ),
              // ),
              10.height,
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
              //                 JvlSellPriceAndDiscounts(isOtherSelected: value));
              //           },
              //           selectedOption: state
              //               .costSimulatorDetails.isSellPriceDisOtherSelected,
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
              //   sellOthersCommentCtrl,
              //   sellOtherMenuCtrl,
              //   context,
              // ),
            ],
          ),
        );
      },
    );
  }

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

//!-----------------Visibility----------------
  // Visibility _onPressYesShow(
  //     StepTwoState state,
  //     TextEditingController othersTxtCtrl,
  //     TextEditingController sellOthersCommentCtrl,
  //     MenuController sellOtherMenuCtrl,
  //     BuildContext context) {
  //   return Visibility(
  //     visible: state.costSimulatorDetails.isSellPriceDisOtherSelected ==
  //         StringConst.yes,
  //     child: Column(
  //       children: [
  //         CustomTextFieldLabel(
  //           keyboardType: TextInputType.number,
  //           inputFormat: [
  //             FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
  //           ],
  //           commentCtrl: sellOthersCommentCtrl,
  //           messageOnSaved: (String? message) {
  //             context.read<StepTwoBloc>().add(JvlSellPriceAndDiscounts(
  //                   sellPriceDiscountOthersCmmnt: message,
  //                 ));
  //             //?*---- message on saved
  //             context.read<StepTwoBloc>().add(
  //                   SaveComment(
  //                     commentDescription: message,
  //                     commentFieldName: StringConst.sellPriceDiscountOthers,
  //                   ),
  //                 );
  //           },
  //           controller: othersTxtCtrl,
  //           onChanged: (String sellPriceDiscountOthers) {
  //             context.read<StepTwoBloc>().add(JvlSellPriceAndDiscounts(
  //                 sellPriceDiscountOthers: sellPriceDiscountOthers));
  //           },
  //           commonValidator: (String? value) {
  //             return fCon.commonValidation(
  //               inputValue: value ?? "",
  //               errorMsg: StringConst.enterValueError,
  //             );
  //           },
  //           menuCtrl: sellOtherMenuCtrl,
  //           //TODO  /:comment message box
  //           message: false,
  //           comment: state.commentFields.sellPriceDiscountOthersCmmnt,
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

  Widget _subText(String subText, BuildContext context) {
    return KStyles().med(
      text: subText,
      color: AppColors.black,
      size: fontCon.boxsubFontSize(context),
    );
  }
}

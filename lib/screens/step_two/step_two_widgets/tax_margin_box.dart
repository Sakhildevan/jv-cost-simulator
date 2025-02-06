// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/utils/constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/step_two_bloc/step_two_bloc.dart';
import '../../../config/config.dart';
import '../../../gen/assets.gen.dart';
import '../../../styles/text_styles.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/global_extensions.dart';
import '../../../utils/string_const.dart';
import '../../../widgets/custom_box_title.dart';
import '../../../widgets/custom_input_formatter.dart';
import '../../../widgets/custom_text_field_label.dart';
import '../../../widgets/post_frame_callback.dart';

class RetailTaxMarginBox extends StatelessWidget {
  const RetailTaxMarginBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //!---------Menu Controllers----------------
    MenuController taxMarginMenuCtrl = MenuController();
    // MenuController distributorMenutrl = MenuController();

    //!---------Text Controllers----------------
    final TextEditingController sellTaxExclusiveTxtCtrl =
        TextEditingController();
    final TextEditingController retailerMarginTxtCtrl = TextEditingController();
    final TextEditingController sellTaxInclusiveTxtCtrl =
        TextEditingController();
    final TextEditingController taxMarginCommentCtrl = TextEditingController();
    // final TextEditingController distributorTxtCtrl = TextEditingController();
    final TextEditingController localTaxTxtCtrl = TextEditingController();
    // final TextEditingController distCommentCtrl = TextEditingController();

    //!---------PostFrameCallback----------------
    void addPostFrameCallback() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final state = context.read<StepTwoBloc>().state;
        updateTextController(
          sellTaxExclusiveTxtCtrl,
          formatWithThousandSeparator(state.costSimulatorDetails.shelfPriceTax),
        );
        updateTextController(
          showPercentage: true,
          retailerMarginTxtCtrl,
          state.costSimulatorDetails.retailerMargin,
        );
        updateTextController(
          sellTaxInclusiveTxtCtrl,
          formatWithThousandSeparator((() {
            if (state.costSimulatorDetails.shelfPriceTax.isNotEmpty &&
                state.costSimulatorDetails.localTaxVat.isNotEmpty) {
              final shelfPriceTax =
                  double.tryParse(state.costSimulatorDetails.shelfPriceTax) ??
                      0;
              final localTaxVat =
                  double.tryParse(state.costSimulatorDetails.localTaxVat) ?? 0;

              return (shelfPriceTax + (shelfPriceTax * (localTaxVat / 100)))
                  .toStringAsFixed(2);
            } else {
              return '0';
            }
          })()),
        );

        // updateTextController(
        //   sellTaxInclusiveTxtCtrl,
        //   state.costSimulatorDetails.taxIncludedInShelfPrice,
        // );
        updateTextController(
          taxMarginCommentCtrl,
          state.commentFields.taxAndMarginsComment,
        );
        //Todo : updateTextController
        updateTextController(
          showPercentage: true,
          localTaxTxtCtrl, state.costSimulatorDetails.localTaxVat,
          // formatWithThousandSeparator(state.costSimulatorDetails.localTaxVat),
        );
        // updateTextController(
        //   distCommentCtrl,
        //   state.commentFields.estDistMarginComment,
        // );
        // updateTextController(
        //   showPercentage: true,
        //   distributorTxtCtrl,
        //   state.costSimulatorDetails.estDistributorMarginOn,
        // );
      });
    }

    //!---------CustomBoxTitle----------------
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
          onChanged: (String message) {
            // context
            //     .read<StepTwoBloc>()
            //     .add(RetailTaxAndMargin(taxAndMarginsComment: message));
          },
          cmntBox: true,
          commentCtrl: taxMarginCommentCtrl,
          comment: state.commentFields.taxAndMarginsComment,
          messageOnSaved: (String message) {
            context
                .read<StepTwoBloc>()
                .add(RetailTaxAndMargin(taxAndMarginsComment: message));
            context.read<StepTwoBloc>().add(
                  SaveComment(
                    commentDescription: message,
                    commentFieldName: StringConst.taxAndMarginsComment,
                  ),
                );
          },
          menuCtrl: taxMarginMenuCtrl,
          //-----------image and title-----------
          imagePath: Assets.images.retailTaxMargin.path,
          title: StringConst.retailTaxAndMargins,
          //!-------content-----------------------------
          child: getDeviceType(MediaQuery.of(context).size) ==
                  DeviceScreenType.mobile
              ? mobileView(
                  context: context,
                  state: state,
                  sellTaxInclusiveTxtCtrl: sellTaxInclusiveTxtCtrl,
                  sellTaxExclusiveTxtCtrl: sellTaxExclusiveTxtCtrl,
                  localTaxTxtCtrl: localTaxTxtCtrl,
                  // distributorTxtCtrl: distributorTxtCtrl,
                  retailerMarginTxtCtrl: retailerMarginTxtCtrl,
                )
              : desktopView(
                  context: context,
                  state: state,
                  sellTaxInclusiveTxtCtrl: sellTaxInclusiveTxtCtrl,
                  sellTaxExclusiveTxtCtrl: sellTaxExclusiveTxtCtrl,
                  localTaxTxtCtrl: localTaxTxtCtrl,
                  // distributorTxtCtrl: distributorTxtCtrl,
                  retailerMarginTxtCtrl: retailerMarginTxtCtrl,
                ),
        );
      },
    );
  }

  Widget mobileView({
    required BuildContext context,
    required StepTwoState state,
    required TextEditingController sellTaxInclusiveTxtCtrl,
    required TextEditingController sellTaxExclusiveTxtCtrl,
    required TextEditingController localTaxTxtCtrl,
    required TextEditingController retailerMarginTxtCtrl,
    // required TextEditingController distributorTxtCtrl,
  }) {
    return Column(
      children: [
        //!---------box left section----------------
        // Row(
        //   children: [
        //     Expanded(
        //       flex: 2,
        //       child: KStyles().med(
        //         size: fontCon.boxLabelFontSize(context),
        //         overflow: TextOverflow.visible,
        //         text: StringConst.isTaxIncludedInShelfPrice,
        //         color: AppColors.black,
        //       ),
        //     ),
        //     10.width,
        //     Expanded(
        //       flex: 2,
        //       child: CustomSelectionRow(
        //         firstOption: StringConst.yes,
        //         secondOption: StringConst.no,
        //         onTap: (String value) {
        //           if (value == StringConst.no) {
        //             context.read<StepTwoBloc>().add(RetailTaxAndMargin(
        //                 isTaxIncludedSelection: value,
        //                 taxIncludedInShelfPrice: '',
        //                 retailMarginOnSales: ''));
        //           } else {
        //             context
        //                 .read<StepTwoBloc>()
        //                 .add(RetailTaxAndMargin(isTaxIncludedSelection: value));
        //           }
        //         },
        //         selectedOption:
        //             state.costSimulatorDetails.isTaxIncludedSelection,
        //         isMetricEmpty: false,
        //       ),
        //     ),
        //     10.width,
        //     const Expanded(flex: 2, child: SizedBox()),
        //   ],
        // ),
        // 10.height,
        CustomTextFieldLabel<UnitMeasure>(
          shrinkDropDown: true,
          displayText: (UnitMeasure? item) {
            return item?.unitName ?? "";
          },
          value: (UnitMeasure? item) {
            return item?.unitCode ?? "";
          },
          dropDownValidator: (UnitMeasure? value) {
            return fCon.commonValidation(
              inputValue: value?.unitCode ?? "",
              errorMsg: StringConst.pleaseSelectAValue,
            );
          },
          dropDownHintText: StringConst.selectAValue,
          contentPadding: EdgeInsets.only(
            left: -5,
            right: 5,
            top: getValueForScreenType(
              context: context,
              mobile: 6,
              tablet: 4,
              desktop: 10,
            ),
            bottom: getValueForScreenType(
              context: context,
              mobile: 10,
              tablet: 13,
              desktop: 10,
            ),
          ),
          dropDownValue: state.costSimulatorDetails.sellUnitOfMeasure,
          text: 'Retail Sell Price (UOM)',
          itemList: state.unitMeasureList,
          dropDown: true,
          onDropDownChanged: (
            UnitMeasure? sellUnitOfMeasure,
          ) {
            context.read<StepTwoBloc>().add(RetailTaxAndMargin(
                  sellUnitOfMeasure: sellUnitOfMeasure,
                ));
          },
        ),

        10.height,
        //!---------Local Tax or Vat----------------
        CustomTextFieldLabel(
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormat: <TextInputFormatter>[
            // DecimalFormatter(decimalDigits: 2),
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          onChanged: (localTaxVat) {
            context.read<StepTwoBloc>().add(DistributorMarginImport(
                localTaxVat: fCon.removeComma(localTaxVat)));
          },
          // commonValidator: (String? value) {
          //   return fCon.commonValidation(
          //     inputValue: value ?? "",
          //     errorMsg: StringConst.enterValueError,
          //   );
          // },
          controller: localTaxTxtCtrl,

          text: StringConst.localTaxOrVat,
          content: true,
          //todo  /:comment message box
          message: false,
          child: KStyles().med(
            text: "%",
            color: AppColors.black,
            size: fontCon.boxsubFontSize(context),
          ),
        ),
        10.height,

        //!---------retailMarginExclusiveOnSales----------------
        CustomTextFieldLabel(
          keyboardType: TextInputType.number,
          inputFormat: [
            DecimalFormatter(decimalDigits: 2),
            // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          //commentCtrl: retailMarginCommentCtrl,
          messageOnSaved: (String? message) {
            // context.read<StepTwoBloc>().add(
            //     RetailTaxAndMargin(retailMarginOnSalesComment: message));
            //?*---- message on saved
            context.read<StepTwoBloc>().add(
                  SaveComment(
                    commentDescription: message,
                    commentFieldName: StringConst.retailMarginOnSales,
                  ),
                );
          },

          commonValidator: (String? value) {
            // Skip validation if "No" is selected
            if (state.costSimulatorDetails.isTaxIncludedSelection ==
                StringConst.no) {
              return null; // No validation
            }

            // Perform validation when "Yes" is selected
            return fCon.commonValidation(
              inputValue: value ?? "",
              errorMsg: StringConst.enterValueError,
            );
          },
          onChanged: (shelfPriceTax) {
            context.read<StepTwoBloc>().add(RetailTaxAndMargin(
                shelfPriceTax: fCon.removeComma(shelfPriceTax)));
          },

          // menuCtrl: retailMarginMenuCtrl,
          // addbuttonenabled: false,
          //todo  /:comment message box
          message: false,
          // comment: state.commentFields.retailMarginComment,

          controller: sellTaxExclusiveTxtCtrl,
          text: StringConst.shelfPriceTaxExcluded,
          content: true,
          enabled: state.costSimulatorDetails.isTaxIncludedSelection ==
              StringConst.yes, // Disable when "No" is selected
          showToolTip: false,
          width: getValueForScreenType(
            context: context,
            mobile: 80,
            tablet: 65,
            desktop: Constants.width * 0.123,
          ),
          child: KStyles().med(
            text: state.costSimulatorDetails.itemCurrency,
            color: AppColors.maroon,
            size: fontCon.boxsubFontSize(context),
          ),
          //child: _subText(StringConst.percentSalesWithoutTax, context),
        ),
        10.height,
        //!---------taxInclusiveInShelfPrice----------------
        CustomTextFieldLabel(
          readOnly: true,
          keyboardType: TextInputType.number,
          inputFormat: [
            DecimalFormatter(decimalDigits: 2),
            // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          commonValidator: (String? value) {
            // Skip validation if "No" is selected
            if (state.costSimulatorDetails.isTaxIncludedSelection ==
                StringConst.no) {
              return null; // No validation
            }

            // Perform validation when "Yes" is selected
            return fCon.commonValidation(
              inputValue: value ?? "",
              errorMsg: StringConst.enterValueError,
            );
          },
          onChanged: (taxIncludedInShelfPrice) {
            context.read<StepTwoBloc>().add(
                  RetailTaxAndMargin(
                    taxIncludedInShelfPrice:
                        fCon.removeComma(taxIncludedInShelfPrice),
                  ),
                );
          }, // Disable onChanged when "No" is selected
          text: StringConst.shelfPriceTaxIncluded,
          controller: sellTaxInclusiveTxtCtrl,
          // addbuttonenabled: false,
          content: true,
          enabled: state.costSimulatorDetails.isTaxIncludedSelection ==
              StringConst.yes, // Disable when "No" is selected
          showToolTip: false,
          width: getValueForScreenType(
            context: context,
            mobile: 80,
            tablet: 65,
            desktop: 150,
          ),
          child: KStyles().med(
            text: state.costSimulatorDetails.itemCurrency,
            color: AppColors.maroon,
            size: fontCon.boxsubFontSize(context),
          ),
          // child: _subText(StringConst.percentTax, context),
        ),
        10.height,
        //!---------distributorMarginOnSales titile----------------
        // KStyles().bold(
        //   text: StringConst.estDistributorMarginOnSales,
        //   color: AppColors.maroon,
        //   size: getValueForScreenType(
        //     context: context,
        //     mobile: 10,
        //     tablet: 11,
        //     desktop: 13,
        //   ),
        // ),
        10.height,

        //!---------retailer margin Textfield----------------
        CustomTextFieldLabel(
          keyboardType: TextInputType.number,
          inputFormat: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          commonValidator: (String? value) {
            return fCon.commonValidation(
              inputValue: value ?? "",
              errorMsg: StringConst.enterValueError,
            );
          },
          onChanged: (retailerMargin) {
            context.read<StepTwoBloc>().add(
                  DistributorMarginImport(
                    retailerMargin: retailerMargin,
                  ),
                );
          },
          controller: retailerMarginTxtCtrl,
          text: StringConst.retailerMargin,
          content: true,
          message: false,
          child: _subText('%', context),
        ),
        10.height,
        //!---------distributorMarginOnSales Textfield----------------
        // CustomTextFieldLabel(
        //   keyboardType: TextInputType.number,
        //   inputFormat: [
        //     FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        //   ],

        //   //commentCtrl: distCommentCtrl,
        //   // messageOnSaved: (String? message) {
        //   //   context.read<StepTwoBloc>().add(DistributorMarginImport(
        //   //         estDistributorMarginOnComment: message,
        //   //       ));
        //   //   //?*---- message on saved
        //   //   context.read<StepTwoBloc>().add(
        //   //         SaveComment(
        //   //           commentDescription: message,
        //   //           commentFieldName: StringConst.estDistributorMargin,
        //   //         ),
        //   //       );
        //   // },
        //   commonValidator: (String? value) {
        //     return fCon.commonValidation(
        //       inputValue: value ?? "",
        //       errorMsg: StringConst.enterValueError,
        //     );
        //   },
        //   onChanged: (estDistributorMarginOn) {
        //     context.read<StepTwoBloc>().add(DistributorMarginImport(
        //         estDistributorMarginOn: estDistributorMarginOn));
        //   },
        //   controller: distributorTxtCtrl,
        //   // menuCtrl: distributorMenutrl,
        //   // addbuttonenabled: false,
        //   text: StringConst.estDistributorMargin,
        //   content: true,
        //   //todo  /:comment message box
        //   message: false,
        //   // comment: state.commentFields.estDistMarginComment,
        //   child: _subText('%', context),
        // ),
      ],
    );
  }

  Row desktopView({
    required BuildContext context,
    required StepTwoState state,
    required TextEditingController sellTaxInclusiveTxtCtrl,
    required TextEditingController sellTaxExclusiveTxtCtrl,
    required TextEditingController localTaxTxtCtrl,
    required TextEditingController retailerMarginTxtCtrl,
    // required TextEditingController distributorTxtCtrl,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              kDim.kGap10,
              //!---------box left section----------------
              // Row(
              //   children: [
              //     Expanded(
              //       flex: 2,
              //       child: KStyles().reg(
              //         size: fontCon.boxLabelFontSize(context),
              //         overflow: TextOverflow.visible,
              //         text: StringConst.isTaxIncludedInShelfPrice,
              //         color: AppColors.black,
              //       ),
              //     ),
              //     10.width,
              //     Expanded(
              //       flex: 2,
              //       child: CustomSelectionRow(
              //         firstOption: StringConst.yes,
              //         secondOption: StringConst.no,
              //         onTap: (String value) {
              //           if (value == StringConst.no) {
              //             context.read<StepTwoBloc>().add(RetailTaxAndMargin(
              //                 isTaxIncludedSelection: value,
              //                 taxIncludedInShelfPrice: '',
              //                 retailMarginOnSales: ''));
              //           } else {
              //             context.read<StepTwoBloc>().add(RetailTaxAndMargin(
              //                 isTaxIncludedSelection: value));
              //           }
              //         },
              //         selectedOption:
              //             state.costSimulatorDetails.isTaxIncludedSelection,
              //         isMetricEmpty: false,
              //       ),
              //     ),
              //     10.width,
              //     const Expanded(flex: 2, child: SizedBox()),
              //   ],
              // ),
              // 10.height,
              CustomTextFieldLabel<UnitMeasure>(
                shrinkDropDown: true,
                displayText: (UnitMeasure? item) {
                  return item?.unitName ?? "";
                },
                value: (UnitMeasure? item) {
                  return item?.unitCode ?? "";
                },
                dropDownValidator: (UnitMeasure? value) {
                  return fCon.commonValidation(
                    inputValue: value?.unitCode ?? "",
                    errorMsg: StringConst.pleaseSelectAValue,
                  );
                },
                dropDownHintText: StringConst.selectAValue,
                contentPadding: EdgeInsets.only(
                  left: -5,
                  right: 5,
                  top: getValueForScreenType(
                    context: context,
                    mobile: 6,
                    tablet: 4,
                    desktop: 10,
                  ),
                  bottom: getValueForScreenType(
                    context: context,
                    mobile: 10,
                    tablet: 13,
                    desktop: 10,
                  ),
                ),
                dropDownValue: state.costSimulatorDetails.sellUnitOfMeasure,
                text: 'Retail Sell Price (UOM)',
                itemList: state.unitMeasureList,
                dropDown: true,
                onDropDownChanged: (
                  UnitMeasure? sellUnitOfMeasure,
                ) {
                  context.read<StepTwoBloc>().add(RetailTaxAndMargin(
                        sellUnitOfMeasure: sellUnitOfMeasure,
                      ));
                },
              ),
              10.height, //!---------Local Tax or Vat----------------
              CustomTextFieldLabel(
                keyboardType: TextInputType.number,
                inputFormat: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  // DecimalFormatter(decimalDigits: 2),
                ],
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                controller: localTaxTxtCtrl,

                text: StringConst.localTaxOrVat,
                content: true,
                //todo  /:comment message box
                message: false,
                onChanged: (localTaxVat) {
                  context.read<StepTwoBloc>().add(
                        DistributorMarginImport(
                          localTaxVat: fCon.removeComma(localTaxVat),
                        ),
                      );
                },
                child: KStyles().med(
                  text: "%",
                  color: AppColors.black,
                  size: fontCon.boxsubFontSize(context),
                ),
              ),
              //!---------distributorMarginOnSales titile----------------
              // KStyles().bold(
              //   text: StringConst.estDistributorMarginOnSales,
              //   color: AppColors.maroon,
              //   size: fontCon.boxTitleFontSize(context),
              // ),
              10.height,
              //*-----------(retailer margin)
              CustomTextFieldLabel(
                keyboardType: TextInputType.number,
                inputFormat: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  // DecimalFormatter(decimalDigits: 2),
                ],
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                controller: retailerMarginTxtCtrl,

                text: StringConst.retailerMargin,
                content: true,
                //todo  /:comment message box
                message: false,
                onChanged: (retailerMargin) {
                  context.read<StepTwoBloc>().add(
                        DistributorMarginImport(
                          retailerMargin: fCon.removeComma(retailerMargin),
                        ),
                      );
                },
                child: KStyles().med(
                  text: "% ",
                  color: AppColors.black,
                  size: fontCon.boxsubFontSize(context),
                ),
              ),
              10.height,
            ],
          ),
        ),
        90.width,
        //!-----------------box - right section ----------------
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // KStyles().bold(
              //   text: StringConst.estDistributorMarginOnSales,
              //   color: AppColors.maroon,
              //   size: fontCon.boxTitleFontSize(context),
              // ),
              kDim.kGap10,

              //!---------retailMarginExclusiveOnSales----------------
              CustomTextFieldLabel(
                keyboardType: TextInputType.number,
                inputFormat: [
                  DecimalFormatter(decimalDigits: 2),
                  // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                //commentCtrl: retailMarginCommentCtrl,
                messageOnSaved: (String? message) {
                  // context.read<StepTwoBloc>().add(
                  //     RetailTaxAndMargin(retailMarginOnSalesComment: message));
                  //?*---- message on saved
                  context.read<StepTwoBloc>().add(
                        SaveComment(
                          commentDescription: message,
                          commentFieldName: StringConst.retailMarginOnSales,
                        ),
                      );
                },

                commonValidator: (String? value) {
                  // Skip validation if "No" is selected
                  if (state.costSimulatorDetails.isTaxIncludedSelection ==
                      StringConst.no) {
                    return null; // No validation
                  }

                  // Perform validation when "Yes" is selected
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                onChanged: (shelfPriceTax) {
                  context.read<StepTwoBloc>().add(RetailTaxAndMargin(
                      shelfPriceTax: fCon.removeComma(shelfPriceTax)));
                },

                // menuCtrl: retailMarginMenuCtrl,
                // addbuttonenabled: false,
                //todo  /:comment message box
                message: false,
                // comment: state.commentFields.retailMarginComment,

                controller: sellTaxExclusiveTxtCtrl,
                text: StringConst.shelfPriceTaxExcluded,
                content: true,
                enabled: state.costSimulatorDetails.isTaxIncludedSelection ==
                    StringConst.yes, // Disable when "No" is selected
                showToolTip: false,
                width: getValueForScreenType(
                  context: context,
                  mobile: 80,
                  tablet: 65,
                  desktop: Constants.width * 0.123,
                ),
                child: _subRichText(state, context),
                //child: _subText(StringConst.percentSalesWithoutTax, context),
              ),
              10.height, //!---------taxInclusiveInShelfPrice----------------
              CustomTextFieldLabel(
                readOnly: true,
                enabled: false,
                keyboardType: TextInputType.number,
                inputFormat: [
                  DecimalFormatter(decimalDigits: 2),
                  // FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                commonValidator: (String? value) {
                  // Skip validation if "No" is selected
                  if (state.costSimulatorDetails.isTaxIncludedSelection ==
                      StringConst.no) {
                    return null; // No validation
                  }

                  // Perform validation when "Yes" is selected
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                onChanged: (taxIncludedInShelfPrice) {
                  context.read<StepTwoBloc>().add(RetailTaxAndMargin(
                      taxIncludedInShelfPrice:
                          fCon.removeComma(taxIncludedInShelfPrice)));
                }, // Disable onChanged when "No" is selected
                text: StringConst.shelfPriceTaxIncluded,
                controller: sellTaxInclusiveTxtCtrl,
                // addbuttonenabled: false,
                content: true,
                // enabled: state.costSimulatorDetails.isTaxIncludedSelection ==
                //     StringConst.yes, // Disable when "No" is selected
                showToolTip: false,
                width: getValueForScreenType(
                  context: context,
                  mobile: 80,
                  tablet: 65,
                  desktop: 150,
                ),
                child: _subRichText(state, context),
                // child: _subText(StringConst.percentTax, context),
              ),
              10.height,
              //!---------distributorMarginOnSales Textfield----------------
              // CustomTextFieldLabel(
              //   keyboardType: TextInputType.number,
              //   inputFormat: [
              //     FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              //   ],

              //   //commentCtrl: distCommentCtrl,
              //   // messageOnSaved: (String? message) {
              //   //   context.read<StepTwoBloc>().add(DistributorMarginImport(
              //   //         estDistributorMarginOnComment: message,
              //   //       ));
              //   //   //?*---- message on saved
              //   //   context.read<StepTwoBloc>().add(
              //   //         SaveComment(
              //   //           commentDescription: message,
              //   //           commentFieldName: StringConst.estDistributorMargin,
              //   //         ),
              //   //       );
              //   // },
              //   commonValidator: (String? value) {
              //     return fCon.commonValidation(
              //       inputValue: value ?? "",
              //       errorMsg: StringConst.enterValueError,
              //     );
              //   },
              //   onChanged: (estDistributorMarginOn) {
              //     context.read<StepTwoBloc>().add(DistributorMarginImport(
              //         estDistributorMarginOn: estDistributorMarginOn));
              //   },
              //   controller: distributorTxtCtrl,
              //   // menuCtrl: distributorMenutrl,
              //   // addbuttonenabled: false,
              //   text: StringConst.grossMarginTarget,
              //   content: true,
              //   //todo  /:comment message box
              //   message: false,
              //   // comment: state.commentFields.estDistMarginComment,
              //   child: _subText("%", context),
              // ),
            ],
          ),
        ),
        10.height,
      ],
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

  //!---------_subText----------------
  Widget _subText(String subText, BuildContext context) {
    return KStyles().med(
      overflow: TextOverflow.visible,
      text: subText,
      color: AppColors.black,
      size: fontCon.boxsubFontSize(context),
    );
  }
}

class UnitMeasure {
  UnitMeasure({
    this.unitName,
    this.unitCode,
  });
  final String? unitName;
  final String? unitCode;

  @override
  String toString() => 'UnitMeasure(unitName: $unitName, unitCode: $unitCode)';
}

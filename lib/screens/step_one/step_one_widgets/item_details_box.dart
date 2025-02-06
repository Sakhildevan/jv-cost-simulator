import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/utils/enums.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/step_one_bloc/step_one_bloc.dart';
import '../../../config/config.dart';
import '../../../gen/assets.gen.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/global_extensions.dart';
import '../../../utils/string_const.dart';
import '../../../widgets/custom_box_title.dart';
import '../../../widgets/custom_input_formatter.dart';
import '../../../widgets/custom_text_field_label.dart';
import '../../../widgets/post_frame_callback.dart';
import '../../../widgets/shimmer.widget.dart';

class ItemDetailsBox extends StatefulWidget {
  const ItemDetailsBox({
    super.key,
    required this.scrollcontroller,
  });
  final ScrollController scrollcontroller;

  @override
  State<ItemDetailsBox> createState() => _ItemDetailsBoxState();
}

class _ItemDetailsBoxState extends State<ItemDetailsBox> {
  final TextEditingController packSizeCtrl = TextEditingController();
  final TextEditingController linksPerPackCtrl = TextEditingController();
  final TextEditingController packsPerCaseCtrl = TextEditingController();

  @override
  void dispose() {
    packSizeCtrl.dispose();
    linksPerPackCtrl.dispose();
    packsPerCaseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StepOneBloc, StepOneState>(
      listener: (context, state) {},
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final state = context.read<StepOneBloc>().state;

          updateTextController(
              packSizeCtrl,
              formatWithThousandSeparator(
                state.packSize,
              ));
          updateTextController(
              linksPerPackCtrl,
              formatWithThousandSeparator(
                state.linksPerPack,
              ));
          updateTextController(
              packsPerCaseCtrl,
              formatWithThousandSeparator(
                state.packsPerCase,
              ));
        });

        if (state.loadingStatus == LoadingStatus.loading) {
          return const ShimmerLoader(type: ShimmerType.box);
        }

        return CustomBoxTitle(
          title: StringConst.enterItemDetails,
          imagePath: Assets.images.itemDetails.path,
          child: _inputDataSection(
            packSizeCtrl: packSizeCtrl,
            linksPerPackCtrl: linksPerPackCtrl,
            packsPerCaseCtrl: packsPerCaseCtrl,
            context: context,
            state: state,
            scrollCtrl: widget.scrollcontroller,
          ),
        );
      },
    );
  }

  //!-----------------input data section-------------------
  Widget _inputDataSection({
    required TextEditingController packSizeCtrl,
    required TextEditingController linksPerPackCtrl,
    required TextEditingController packsPerCaseCtrl,
    required BuildContext context,
    required ScrollController scrollCtrl,
    required StepOneState state,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //!-----------------matrix selector-------------------
        CustomTextFieldLabel<String>(
          displayText: (String? item) {
            return item;
          },
          value: (String? item) {
            return item;
          },
          dropDownValidator: (String? value) {
            return fCon.commonValidation(
              inputValue: value ?? "",
              errorMsg: StringConst.pleaseSelectYourUnit,
            );
          },
          dropDownHintText: StringConst.selectYourUnit,
          contentPadding: EdgeInsets.only(
            left: -5,
            right: 5,
            top: getValueForScreenType(
              context: context,
              mobile: 6,
              tablet: 9,
              desktop: 10,
            ),
            bottom: getValueForScreenType(
              context: context,
              mobile: 10,
              tablet: 13,
              desktop: 10,
            ),
          ),
          dropDownValue: state.packUom ?? "",
          text: StringConst.unitOfMeasure,
          itemList: const [
            StringConst.ounce,
            StringConst.gms,
          ],
          dropDown: true,
          onDropDownChanged: (
            String? value,
          ) {
            context.read<StepOneBloc>().add(
                  EnterItemDetailUpdate(
                    packUom: value,
                  ),
                );
            scrollCtrl.animateTo(
              getValueForScreenType(
                context: context,
                mobile: 200,
                tablet: 350,
                desktop: 390,
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
            //calling production Location Id update
            // context.read<StepOneBloc>().add(
            //       ItemInfoUpdateValue(
            //         productionLocation: productionCountry,
            //       ),
            //     );
          },
        ),
        // _matrixSelectorWidget(context, state, scrollCtrl),
        10.height,

        //!-----------------Pack size textfield-------------------
        CustomTextFieldLabel(
          controller: packSizeCtrl,
          content: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormat: <TextInputFormatter>[
            DecimalFormatter(decimalDigits: 2),
          ],
          commonValidator: (String? value) {
            return fCon.commonValidation(
              inputValue: value ?? "",
              errorMsg: StringConst.enterValueError,
            );
          },
          hintText: StringConst.hintPackSize,
          onChanged: (String packSize) {
            context.read<StepOneBloc>().add(
                  EnterItemDetailUpdate(packSize: fCon.removeComma(packSize)),
                );
            scrollCtrl.animateTo(
              getValueForScreenType(
                context: context,
                mobile: 200,
                tablet: 350,
                desktop: 390,
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          text: StringConst.packSize,
          child: KStyles().med(
            text: state.packUom ?? "",
            size: fontCon.boxsubFontSize(context),
          ),
        ),
        10.height,
        //!-----------------Links per pack textfield-------------------
        CustomTextFieldLabel(
          content: true,
          controller: linksPerPackCtrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormat: <TextInputFormatter>[
            DecimalFormatter(decimalDigits: 3),
          ],
          commonValidator: (String? value) {
            return fCon.commonValidation(
              inputValue: value ?? "",
              errorMsg: StringConst.enterValueError,
            );
          },
          hintText: StringConst.hintUnitPack,
          onChanged: (String linksPerPack) {
            context.read<StepOneBloc>().add(
                  EnterItemDetailUpdate(
                      linksPerPack: fCon.removeComma(linksPerPack)),
                );
            scrollCtrl.animateTo(
              getValueForScreenType(
                context: context,
                mobile: 200,
                tablet: 350,
                desktop: 390,
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          text: StringConst.unitsPerPkg,
          child: KStyles().med(
            text: StringConst.units.toUpperCase(),
            size: fontCon.boxsubFontSize(context),
          ),
        ),
        10.height,
        //!-----------------Packs per case textfield-------------------
        CustomTextFieldLabel(
          controller: packsPerCaseCtrl,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormat: <TextInputFormatter>[
            DecimalFormatter(decimalDigits: 3),
          ],
          commonValidator: (String? value) {
            return fCon.commonValidation(
              inputValue: value ?? "",
              errorMsg: StringConst.enterValueError,
            );
          },
          hintText: StringConst.hintPackCase,
          onChanged: (String packsPerCase) {
            context.read<StepOneBloc>().add(
                  EnterItemDetailUpdate(
                      packsPerCase: fCon.removeComma(packsPerCase)),
                );
            scrollCtrl.animateTo(
              getValueForScreenType(
                context: context,
                mobile: 200,
                tablet: 350,
                desktop: 390,
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          text: StringConst.packsPerCase,
          content: true,
          child: KStyles().med(
            text: StringConst.packs.toUpperCase(),
            size: fontCon.boxsubFontSize(context),
          ),
        ),
        10.height,
        // // //!-----------------Currency dropdown-------------------
        // CustomTextFieldLabel<Currency>(
        //   displayText: (Currency? item) => item?.currencyName,
        //   value: (Currency? item) => item?.currencyCode,
        //   dropDownValidator: (Currency? value) {
        //     return fCon.commonValidation(
        //       inputValue: value?.currencyCode ?? "",
        //       errorMsg: StringConst.pleaseSelectYourCurrency,
        //     );
        //   },
        //   dropDownHintText: StringConst.selectYourCurrency,
        //   dropDownValue: state.itemCurrency,
        //   onDropDownChanged: (Currency? currency) {
        //     context.read<StepOneBloc>().add(
        //           EnterItemDetailUpdate(currency: currency),
        //         );
        //   },
        //   itemList: state.dropDownCurrencyList,
        //   text: StringConst.currency,
        //   dropDown: true,
        // ),
        // 10.height,
      ],
    );
  }
}

// Column _matrixSelectorWidget(
//   BuildContext context,
//   StepOneState state,
//   ScrollController scrollCtrl,
// ) {
//   return Column(
//     children: [
//       Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: KStyles().reg(
//               size: fontCon.boxLabelFontSize(context),
//               overflow: TextOverflow.visible,
//               text: StringConst.metricsSelector,
//               color: AppColors.black,
//             ),
//           ),
//           5.width,
//           Expanded(
//             flex: 2,
//             child: CustomSelectionRow(
//               firstOption: StringConst.ounce,
//               secondOption: StringConst.gms,
//               onTap: (String packUom) {
//                 context.read<StepOneBloc>().add(
//                       EnterItemDetailUpdate(
//                         packUom: packUom,
//                       ),
//                     );
//                 scrollCtrl.animateTo(
//                   getValueForScreenType(
//                     context: context,
//                     mobile: 200,
//                     tablet: 350,
//                     desktop: 390,
//                   ),
//                   duration: const Duration(milliseconds: 500),
//                   curve: Curves.easeInOut,
//                 );
//               },
//               selectedOption: state.packUom ?? "",
//               isMetricEmpty: state.isMetricsSelected == false &&
//                   (state.packUom ?? '').isEmpty,
//             ),
//           ),
//         ],
//       ),
//       if (state.isMetricsSelected == false && (state.packUom ?? '').isEmpty)
//         Row(
//           children: [
//             const Expanded(
//               flex: 1,
//               child: SizedBox(
//                 width: 10,
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   left: 15,
//                 ),
//                 child: KStyles().reg(
//                   size: getValueForScreenType(
//                     context: context,
//                     mobile: 10,
//                     tablet: 10,
//                     desktop: 12,
//                   ),
//                   overflow: TextOverflow.visible,
//                   text: StringConst.pleaseSelectAMetricUnit,
//                   color: AppColors.maroon,
//                 ),
//               ),
//             ),
//           ],
//         ),
//     ],
//   );
// }

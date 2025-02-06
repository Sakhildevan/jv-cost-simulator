import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../bloc/step_two_bloc/step_two_bloc.dart';
import '../data/model/load_simulator.model.dart';
import '../styles/text_styles.dart';
import '../themes/app_colors.dart';
import '../utils/string_const.dart';
import 'custom_input_formatter.dart';
import 'custom_text_field.widget.dart';
import 'custom_text_tile.widget.dart';

class CustomTextfieldOthers extends StatelessWidget {
  final TextEditingController? labelController;
  final TextEditingController? valueController;

  final bool? showAddIcon;
  final List<Other>? dataList;
  final void Function(int)? onDeleteTap;
  // final void Function(String)? onLabelChanged;
  final void Function(Other)? onValueChanged;
  final int? othersLimit;
  final String? itemCurrency;
  final String? sellUnitOfMeasure;
  final void Function()? onAddTap;
  const CustomTextfieldOthers({
    super.key,
    this.valueController,
    this.labelController,
    this.showAddIcon,
    this.dataList,
    this.onDeleteTap,
    this.onAddTap,
    // this.onLabelChanged,
    this.onValueChanged,
    this.othersLimit,
    this.itemCurrency,
    this.sellUnitOfMeasure,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepTwoBloc, StepTwoState>(
      builder: (context, state) {
        return Column(
          children: [
            textFieldRow(context),
            kDim.kGap05,
            dataListWidget(context),
          ],
        );
      },
    );
  }

  Column dataListWidget(BuildContext context) {
    return Column(
      children: List.generate(
        dataList?.length ?? 0,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextTile(
                  text: dataList?[index].label ?? "",
                ),
              ),
              10.width,
              Expanded(
                child: CustomTextTile(
                  onDeleteTap: () {
                    onDeleteTap!(index);
                  },
                  showDelete: true,
                  text: fCon.formatWithThousandSeparator(
                      dataList?[index].value.toString() ?? ""),
                ),
              ),
              10.width,
              Flexible(
                child: SizedBox(
                  height: 35,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _subRichText(
                      context: context,
                      itemCurrency: itemCurrency,
                      sellUnitOfMeasure: sellUnitOfMeasure,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row textFieldRow(BuildContext context) {
    var limitCheck = (dataList?.length ?? 0) < ((othersLimit ?? 0) - 1);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: CustomTextField(
          validator: (String? value) {
            if (valueController?.text.isNotEmpty ?? false) {
              return fCon.commonValidation(
                inputValue: value ?? "",
                errorMsg: StringConst.enterLabelError,
              );
            }
            return null;
          },
          keyboardType: TextInputType.name,
          inputFormat: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))
          ],
          hintText: StringConst.enterTheLabel,
          onChanged: (p0) {
            onValueChanged!(
              Other(
                label: labelController?.text,
                value: valueController?.text,
              ),
            );
          },
          controller: labelController,
          suffix: InkWell(
            onTap: null,
            child: Icon(
              Icons.add_circle_outline,
              color: AppColors.transparent,
              size: getValueForScreenType(
                context: context,
                mobile: 16,
                tablet: 18,
                desktop: 20,
              ),
            ),
          ),
        )),
        10.width,
        Expanded(
            child: CustomTextField(
          validator: (String? value) {
            if (labelController?.text.isNotEmpty ?? false) {
              return fCon.commonValidation(
                inputValue: value ?? "",
                errorMsg: StringConst.enterValueError,
              );
            }
            return null;
          },
          controller: valueController,
          keyboardType: TextInputType.number,
          inputFormat: <TextInputFormatter>[
            DecimalFormatter(decimalDigits: 2),
          ],
          suffix: InkWell(
            onTap: limitCheck ? onAddTap : null,
            child: Icon(
              Icons.add_circle_outline,
              color: limitCheck ? AppColors.grey : AppColors.transparent,
              size: getValueForScreenType(
                context: context,
                mobile: 16,
                tablet: 18,
                desktop: 20,
              ),
            ),
          ),
          onChanged: (String value) {
            onValueChanged!(
              Other(
                label: labelController?.text,
                value: valueController?.text,
              ),
            );
          },
        )),
        10.width,
        Flexible(
          child: SizedBox(
            height: 35,
            child: Align(
                alignment: Alignment.centerLeft,
                child: _subRichText(
                  context: context,
                  itemCurrency: itemCurrency,
                  sellUnitOfMeasure: sellUnitOfMeasure,
                )),
          ),
        ),
      ],
    );
  }

//!-----------------subRichText----------------
  RichText _subRichText({
    required BuildContext context,
    required String? itemCurrency,
    required String? sellUnitOfMeasure,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: KStyles().med(
              text: itemCurrency ?? "USD",
              color: (itemCurrency?.isNotEmpty ?? false)
                  ? AppColors.maroon
                  : AppColors.black,
              size: fontCon.boxsubFontSize(context),
            ),
          ),
          WidgetSpan(
            child: (sellUnitOfMeasure?.isNotEmpty ?? false)
                ? _subText(
                    "/$sellUnitOfMeasure",
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
  //   return KStyles().reg(
  //     text: subText,
  //     color: AppColors.black,
  //     size: fontCon.boxsubFontSize(context),
  //   );
  // }
}

// class CustomTextfieldOthers extends StatefulWidget {
//   final bool? showAddIcon;
//   final List<Other>? dataList;
//   final void Function(int)? onDeleteTap;
//   final void Function(Other)? onValueChanged;
//   final void Function()? onAddTap;

//   const CustomTextfieldOthers({
//     super.key,
//     this.showAddIcon,
//     this.dataList,
//     this.onDeleteTap,
//     this.onAddTap,
//     this.onValueChanged,
//   });

//   @override
//   CustomTextfieldOthersState createState() => CustomTextfieldOthersState();
// }

// class CustomTextfieldOthersState extends State<CustomTextfieldOthers> {
//   TextEditingController labelController = TextEditingController();
//   TextEditingController valueController = TextEditingController();

//   List<TextEditingController> labelControllers = [];
//   List<TextEditingController> valueControllers = [];

//   @override
//   void initState() {
//     super.initState();
//     _initializeControllers();
//   }

//   void _initializeControllers() {
//     if (widget.dataList != null) {
//       for (var item in widget.dataList!) {
//         labelControllers.add(TextEditingController(text: item.label));
//         valueControllers.add(TextEditingController(text: item.value));
//       }
//     }
//   }

//   void _addNewField() {
//     if (labelController.text.isNotEmpty && valueController.text.isNotEmpty) {
//       setState(() {
//         // Add new controllers for the new row
//         labelControllers.add(TextEditingController(text: labelController.text));
//         valueControllers.add(TextEditingController(text: valueController.text));

//         widget.onValueChanged!(
//           Other(
//             label: labelController.text,
//             value: valueController.text,
//           ),
//         );

//         // Clear input fields for new entries
//         labelController.clear();
//         valueController.clear();
//       });
//     }
//   }

//   void _updateExistingField(int index) {
//     // Update existing field in dataList
//     widget.onValueChanged!(
//       Other(
//         label: labelControllers[index].text,
//         value: valueControllers[index].text,
//       ),
//     );
//   }

//   void _removeField(int index) {
//     setState(() {
//       labelControllers[index].dispose();
//       valueControllers[index].dispose();
//       labelControllers.removeAt(index);
//       valueControllers.removeAt(index);
//     });
//     widget.onDeleteTap?.call(index);
//   }

//   @override
//   void dispose() {
//     labelController.dispose();
//     valueController.dispose();
//     for (var controller in labelControllers) {
//       controller.dispose();
//     }
//     for (var controller in valueControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<StepTwoBloc, StepTwoState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             textFieldRow(context),
//             kDim.kGap05,
//             dataListWidget(context),
//           ],
//         );
//       },
//     );
//   }

//   Column dataListWidget(BuildContext context) {
//     return Column(
//       children: List.generate(
//         labelControllers.length,
//         (index) => Padding(
//           padding: const EdgeInsets.only(bottom: 5.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: CustomTextField(
//                   suffix: const InkWell(
//                     onTap: null,
//                     child: Icon(
//                       Icons.delete,
//                       color: AppColors.transparent,
//                     ),
//                   ),
//                   controller: labelControllers[index],
//                   keyboardType: TextInputType.name,
//                   hintText: StringConst.enterTheLabel,
//                   onChanged: (p0) {
//                     _updateExistingField(index);
//                   },
//                 ),
//               ),
//               10.width,
//               Expanded(
//                 child: CustomTextField(
//                   suffix: InkWell(
//                     onTap: () => _removeField(index),
//                     child: const Icon(Icons.delete),
//                   ),
//                   controller: valueControllers[index],
//                   keyboardType: TextInputType.number,
//                   inputFormat: [
//                     FilteringTextInputFormatter.allow(
//                         RegExp(r'^\d+\.?\d{0,2}')),
//                   ],
//                   hintText: StringConst.enterTheLabel,
//                   onChanged: (p0) {
//                     _updateExistingField(index);
//                   },
//                 ),
//               ),
//               10.width,
//               Flexible(
//                 child: SizedBox(
//                   height: 35,
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: _subText(StringConst.usdMetric, context),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Row textFieldRow(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: CustomTextField(
//             onChanged: (p0) {
//               widget.onValueChanged!(
//                 Other(
//                   label: labelController.text,
//                   value: valueController.text,
//                 ),
//               );
//             },
//             suffix: const InkWell(
//               onTap: null,
//               child: Icon(
//                 Icons.add_circle_outline,
//                 color: AppColors.transparent,
//               ),
//             ),
//             keyboardType: TextInputType.name,
//             inputFormat: [
//               FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
//             ],
//             hintText: StringConst.enterTheLabel,
//             controller: labelController,
//           ),
//         ),
//         10.width,
//         Expanded(
//           child: CustomTextField(
//             onChanged: (p0) {
//               widget.onValueChanged!(
//                 Other(
//                   label: labelController.text,
//                   value: valueController.text,
//                 ),
//               );
//             },
//             suffix: InkWell(
//               onTap: _addNewField,
//               child: const Icon(
//                 Icons.add_circle_outline,
//               ),
//             ),
//             keyboardType: TextInputType.number,
//             inputFormat: [
//               FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
//             ],
//             controller: valueController,
//           ),
//         ),
//         10.width,
//         Flexible(
//           child: SizedBox(
//             height: 35,
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: _subText(StringConst.usdMetric, context),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _subText(String subText, BuildContext context) {
//     return KStyles().reg(
//       text: subText,
//       color: AppColors.black,
//       size: getValueForScreenType(
//         context: context,
//         mobile: 9,
//         tablet: 10,
//         desktop: 12,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';
// import 'package:johnsonville_cost_simulator/config/config.dart';
// import 'package:johnsonville_cost_simulator/utils/constants.dart';
// import 'package:johnsonville_cost_simulator/utils/enums.dart';
// import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
// import 'package:responsive_builder/responsive_builder.dart';

// import '../../../styles/text_styles.dart';
// import '../../../themes/app_colors.dart';
// import '../../../utils/string_const.dart';
// import '../../../widgets/post_frame_callback.dart';
// import 'pricing_slider.widget.dart';

// //!------------------------------------CustomMenuAnchorChildren Page-----------------------------------------
// class PricingMenuChildren extends StatefulWidget {
//   final MenuController? menuCtrl;
//   final bool isAnchorEdit;
//   final String? title;
//   final String? sliderSubTitle;
//   final String? number;

//   final bool? isPercent;
//   final void Function(String)? saveOnPressed;

//   const PricingMenuChildren({
//     required this.isAnchorEdit,
//     required this.menuCtrl,
//     required this.title,
//     required this.number,
//     required this.sliderSubTitle,
//     required this.saveOnPressed,
//     this.isPercent,
//     super.key,
//   });

//   @override
//   State<PricingMenuChildren> createState() => _PricingMenuChildrenState();
// }

// class _PricingMenuChildrenState extends State<PricingMenuChildren> {
//   late TextEditingController textCtrl;

//   @override
//   void initState() {
//     super.initState();
//     textCtrl = TextEditingController();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final state = context.read<PricingBloc>().state;
//       updateTextController(
//         textCtrl,
//         (widget.number?.contains("%") ?? false)
//             ? state.updatedValue!.isNotEmpty
//                 ? state.updatedValue
//                 : widget.number
//             : state.updatedValue!.isNotEmpty
//                 ? fCon.formatWithThousandSeparator(
//                     fCon.removeComma(state.updatedValue ?? ""))
//                 : fCon.formatWithThousandSeparator(
//                     fCon.removeComma(widget.number ?? "")),
//         showPercentage: widget.number?.contains("%") ?? false,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     textCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<PricingBloc, PricingState>(
//       listener: (context, state) {
//         updateTextController(
//           textCtrl,
//           (widget.number?.contains("%") ?? false)
//               ? state.updatedValue
//               : fCon.formatWithThousandSeparator(
//                   fCon.removeComma(state.updatedValue ?? "")),
//           showPercentage: widget.number?.contains("%") ?? false,
//         );
//       },
//       child: BlocBuilder<PricingBloc, PricingState>(
//         builder: (context, state) {
//           return Container(
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(5),
//               border: Border.all(
//                 color: AppColors.maroon,
//                 width: 1,
//               ),
//             ),
//             width: getValueForScreenType(
//               context: context,
//               mobile: Constants.width * .785,
//               tablet: Constants.width * 0.434,
//               desktop: Constants.width * 0.35,
//             ),
//             child: Column(
//               children: [
//                 _titleAndClose(context),
//                 getValueForScreenType(
//                   context: context,
//                   mobile: kDim.kGap10,
//                   tablet: kDim.kGap15,
//                   desktop: kDim.kGap25,
//                 ),
//                 PricingSlider(
//                   textCtrl: textCtrl,
//                   sliderSubtitle: widget.sliderSubTitle,
//                   onSliderChange: (p0) {},
//                   onChanged: (String val) {
//                     context.read<PricingBloc>().add(
//                           UpdateFieldOnChangeEvent(
//                             showCostOfGoods: true,
//                             isDataLoadedAfterChange: false,
//                             updateValue: val,
//                             isSaveError: false,
//                           ),
//                         );
//                   },
//                 ),
//                 getValueForScreenType(
//                   context: context,
//                   mobile: kDim.kGap05,
//                   tablet: kDim.kGap10,
//                   desktop: kDim.kGap20,
//                 ),
//                 uiCon.saveButton(
//                   loaderSize: 15,
//                   isLoading: state.savingStatus == LoadingStatus.loading,
//                   context: context,
//                   fontSize: getValueForScreenType(
//                     context: context,
//                     mobile: 10,
//                     tablet: 10,
//                     desktop: 14,
//                   ),
//                   width: getValueForScreenType(
//                     context: context,
//                     mobile: Constants.width * .25,
//                     tablet: Constants.width * 0.134,
//                     desktop: Constants.width * 0.134,
//                   ),
//                   height: getValueForScreenType(
//                       context: context, mobile: 25, tablet: 25, desktop: 30),
//                   onPressed: () async {
//                     widget.saveOnPressed!(textCtrl.text);
//                   },
//                 ),
//                 15.height,
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Row _titleAndClose(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(),
//         KStyles().bold(
//           text: widget.title ?? "",
//           color: AppColors.maroon,
//           size: getValueForScreenType(
//             context: context,
//             mobile: 12,
//             tablet: 12,
//             desktop: 16,
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             context.read<PricingBloc>().add(const UpdateFieldOnChangeEvent(
//                   showCostOfGoods: false,
//                   updateValue: '',
//                   isDataLoadedAfterChange: true,
//                   isSaveError: false,
//                 ));
//             if (widget.menuCtrl?.isOpen ?? false) {
//               widget.menuCtrl?.close();
//             }
//           },
//           child: Row(
//             children: [
//               KStyles().bold(
//                 text: StringConst.close,
//                 color: AppColors.black,
//                 size: getValueForScreenType(
//                   context: context,
//                   mobile: 12,
//                   tablet: 12,
//                   desktop: 16,
//                 ),
//               ),
//               Icon(
//                 Icons.close_rounded,
//                 color: AppColors.maroon,
//                 size: getValueForScreenType(
//                   context: context,
//                   mobile: 12,
//                   tablet: 20,
//                   desktop: 30,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/utils/constants.dart';
import 'package:johnsonville_cost_simulator/utils/enums.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../styles/text_styles.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/string_const.dart';
import '../../../widgets/custom_input_formatter.dart';
import '../../../widgets/post_frame_callback.dart';
import 'pricing_slider.widget.dart';

//!------------------------------------CustomMenuAnchorChildren Page-----------------------------------------
class PricingMenuChildren extends StatefulWidget {
  final MenuController? menuCtrl;
  final bool isAnchorEdit;
  final String? title;
  final String? sliderSubTitle;
  final String? number;
  final bool? isPercent;
  final void Function(String)? saveOnPressed;

  const PricingMenuChildren({
    required this.isAnchorEdit,
    required this.menuCtrl,
    required this.title,
    required this.number,
    required this.sliderSubTitle,
    required this.saveOnPressed,
    this.isPercent,
    super.key,
  });

  @override
  State<PricingMenuChildren> createState() => _PricingMenuChildrenState();
}

class _PricingMenuChildrenState extends State<PricingMenuChildren> {
  late final TextEditingController textCtrl;
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    textCtrl = TextEditingController();
    focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<PricingBloc>().state;
      updateTextController(
        textCtrl,
        (widget.number?.contains("%") ?? false)
            ? state.updatedValue ?? widget.number
            : fCon.formatWithThousandSeparator(
                fCon.removeComma(state.updatedValue ?? widget.number ?? ""),
              ),
        showPercentage: widget.number?.contains("%") ?? false,
      );
    });
  }

  @override
  void dispose() {
    textCtrl.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: focusNode,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
          int cursorPos = textCtrl.selection.baseOffset;
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft &&
              cursorPos > 0) {
            textCtrl.selection =
                TextSelection.fromPosition(TextPosition(offset: cursorPos - 1));
          } else if (event.logicalKey == LogicalKeyboardKey.arrowRight &&
              cursorPos < textCtrl.text.length) {
            textCtrl.selection =
                TextSelection.fromPosition(TextPosition(offset: cursorPos + 1));
          }
        }
      },
      child: BlocListener<PricingBloc, PricingState>(
        listener: (context, state) {
          updateTextController(
            textCtrl,
            (widget.number?.contains("%") ?? false)
                ? state.updatedValue
                : fCon.formatWithThousandSeparator(
                    fCon.removeComma(state.updatedValue ?? "")),
            showPercentage: widget.number?.contains("%") ?? false,
          );
        },
        child: BlocBuilder<PricingBloc, PricingState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: AppColors.maroon,
                  width: 1,
                ),
              ),
              width: getValueForScreenType(
                context: context,
                mobile: Constants.width * .785,
                tablet: Constants.width * 0.434,
                desktop: Constants.width * 0.35,
              ),
              child: Column(
                children: [
                  _titleAndClose(context),
                  getValueForScreenType(
                    context: context,
                    mobile: kDim.kGap10,
                    tablet: kDim.kGap15,
                    desktop: kDim.kGap25,
                  ),
                  PricingSlider(
                    inputFormat: (widget.number?.contains("%") ?? false)
                        ? <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}'),
                            ),
                          ]
                        : <TextInputFormatter>[
                            DecimalFormatter(decimalDigits: 2),
                          ],
                    textCtrl: textCtrl,
                    sliderSubtitle: widget.sliderSubTitle,
                    onSliderChange: (p0) {},
                    onChanged: (String val) {
                      context.read<PricingBloc>().add(
                            UpdateFieldOnChangeEvent(
                              showCostOfGoods: true,
                              isDataLoadedAfterChange: false,
                              updateValue: val,
                              isSaveError: false,
                            ),
                          );
                    },
                  ),
                  getValueForScreenType(
                    context: context,
                    mobile: kDim.kGap05,
                    tablet: kDim.kGap10,
                    desktop: kDim.kGap20,
                  ),
                  uiCon.saveButton(
                    loaderSize: 15,
                    isLoading: state.savingStatus == LoadingStatus.loading,
                    context: context,
                    fontSize: getValueForScreenType(
                      context: context,
                      mobile: 10,
                      tablet: 10,
                      desktop: 14,
                    ),
                    width: getValueForScreenType(
                      context: context,
                      mobile: Constants.width * .25,
                      tablet: Constants.width * 0.134,
                      desktop: Constants.width * 0.134,
                    ),
                    height: getValueForScreenType(
                        context: context, mobile: 25, tablet: 25, desktop: 30),
                    onPressed: () async {
                      widget.saveOnPressed!(textCtrl.text);
                    },
                  ),
                  15.height,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Row _titleAndClose(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        KStyles().bold(
          text: widget.title ?? "",
          color: AppColors.maroon,
          size: getValueForScreenType(
            context: context,
            mobile: 12,
            tablet: 12,
            desktop: 16,
          ),
        ),
        InkWell(
          onTap: () {
            context.read<PricingBloc>().add(const UpdateFieldOnChangeEvent(
                  showCostOfGoods: false,
                  updateValue: '',
                  isDataLoadedAfterChange: true,
                  isSaveError: false,
                ));
            if (widget.menuCtrl?.isOpen ?? false) {
              widget.menuCtrl?.close();
            }
          },
          child: Row(
            children: [
              KStyles().bold(
                text: StringConst.close,
                color: AppColors.black,
                size: getValueForScreenType(
                  context: context,
                  mobile: 12,
                  tablet: 12,
                  desktop: 16,
                ),
              ),
              Icon(
                Icons.close_rounded,
                color: AppColors.maroon,
                size: getValueForScreenType(
                  context: context,
                  mobile: 12,
                  tablet: 20,
                  desktop: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

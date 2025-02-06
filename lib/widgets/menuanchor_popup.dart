// import 'package:flutter/material.dart';
// import 'package:johnsonville_cost_simulator/config/config.dart';
// import 'package:johnsonville_cost_simulator/utils/constants.dart';
// import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import '../styles/text_styles.dart';
// import '../themes/app_colors.dart';
// import '../utils/string_const.dart';
// import 'slider_content.widget.dart';

// //!------------------------------------CustomMenuAnchorChildren Page-----------------------------------------
// class CustomMenuAnchorChildren extends StatefulWidget {
//   final MenuController menuCtrl;

//   final bool isAnchorEdit;
//   final String title;
//   final String? sliderSubtitle1;
//   final String? sliderSubtitle2;
//   final String? comment;
//   final double? sliderValue1;
//   final double? sliderValue2;
//   final void Function(String)? saveOnPressed;
//   final void Function(double)? onSliderOneChange;
//   final void Function(double)? onSliderTwoChange;
//   final void Function(String)? onChanged;

//   const CustomMenuAnchorChildren({
//     required this.isAnchorEdit,
//     required this.menuCtrl,
//     required this.title,
//     required this.saveOnPressed,
//     this.onSliderOneChange,
//     this.onSliderTwoChange,
//     super.key,
//     this.sliderValue1,
//     this.sliderValue2,
//     this.sliderSubtitle1,
//     this.sliderSubtitle2,
//     this.onChanged,
//     this.comment,
//   });

//   @override
//   State<CustomMenuAnchorChildren> createState() =>
//       _CustomMenuAnchorChildrenState();
// }

// class _CustomMenuAnchorChildrenState extends State<CustomMenuAnchorChildren> {
//   TextEditingController textCtrl = TextEditingController();
//   @override
//   void initState() {
//     textCtrl.text = widget.comment ?? "";
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
// //!-----------------Menu Anchor Container----------------
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(5),
//         border: Border.all(
//           color: AppColors.maroon,
//           width: 1,
//         ),
//       ),
//       width: getValueForScreenType(
//         context: context,
//         mobile: Constants.width * .785,
//         tablet: Constants.width * 0.434,
//         desktop: Constants.width * 0.4,
//       ),
//       child: Column(
//         children: [
//           //!----------Title and close button----------------
//           _titleAndClose(context),
//           5.height,
//           widget.isAnchorEdit
//               ?
//               // !----------padding ----------------
//               Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 10,
//                   ),
//                   //!----------TextField ----------------
//                   child: TextField(
//                     onChanged: widget.onChanged,
//                     //maxLength: 400,
//                     maxLines: 4,
//                     controller: textCtrl,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: AppColors.lightGrey,
//                       hintText: StringConst.markYourAssumption,
//                       hintStyle: TextStyle(
//                         color: AppColors.grey,
//                         fontSize: getValueForScreenType(
//                           context: context,
//                           mobile: 8,
//                           tablet: 8,
//                           desktop: 12,
//                         ),
//                       ),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 )
//               :
//               //!----------Pricing popup with slider ----------------
//               SliderContent(
//                   sliderSubtitle1: widget.sliderSubtitle1 ?? "",
//                   sliderSubtitle2: widget.sliderSubtitle2 ?? "",
//                   sliderValue1: widget.sliderValue1,
//                   sliderValue2: widget.sliderValue2,
//                   onSliderOneChange: widget.onSliderOneChange,
//                   onSliderTwoChange: widget.onSliderTwoChange,
//                 ),

// //!---------save button----------------
//           uiCon.saveButton(
//               context: context,
//               fontSize: getValueForScreenType(
//                 context: context,
//                 mobile: 10,
//                 tablet: 10,
//                 desktop: 14,
//               ),
//               width: getValueForScreenType(
//                 context: context,
//                 mobile: Constants.width * .25,
//                 tablet: Constants.width * 0.134,
//                 desktop: Constants.width * 0.134,
//               ),
//               height: getValueForScreenType(
//                   context: context, mobile: 25, tablet: 25, desktop: 30),
//               onPressed: () {
//                 widget.saveOnPressed!(textCtrl.text);

//                 if (widget.menuCtrl.isOpen) {
//                   widget.menuCtrl.close();
//                 }
//               }),

//           15.height,
//         ],
//       ),
//       //15.height,
//     );
//   }

// //!-----------------Title and close button----------------
//   Row _titleAndClose(content) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(), // Empty container to take up space at the start
//         //!------( title )------!//
//         KStyles().bold(
//           text: widget.title,
//           color: AppColors.maroon,
//           size: getValueForScreenType(
//             context: content,
//             mobile: 12,
//             tablet: 12,
//             desktop: 16,
//           ),
//         ),
//         //!------( close button )------!//
//         Row(
//           children: [
//             KStyles().bold(
//               text: StringConst.close,
//               color: AppColors.black,
//               size: getValueForScreenType(
//                 context: content,
//                 mobile: 12,
//                 tablet: 12,
//                 desktop: 16,
//               ),
//             ),
//             //!---icon button---!
//             IconButton(
//               onPressed: () {
//                 if (widget.menuCtrl.isOpen) {
//                   widget.menuCtrl.close();
//                 }
//               },
//               icon: const Icon(Icons.close_rounded),
//               iconSize: 30,
//               color: AppColors.maroon,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/utils/constants.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../styles/text_styles.dart';
import '../themes/app_colors.dart';
import '../utils/string_const.dart';
import 'slider_content.widget.dart';

//!------------------------------------CustomMenuAnchorChildren Page-----------------------------------------
class CustomMenuAnchorChildren extends StatefulWidget {
  final MenuController menuCtrl;
  final bool isAnchorEdit;
  final String title;
  final String? sliderSubtitle1;
  final String? sliderSubtitle2;
  final String? comment;
  final double? sliderValue1;
  final double? sliderValue2;
  final void Function(String)? saveOnPressed;
  final void Function(double)? onSliderOneChange;
  final void Function(double)? onSliderTwoChange;
  final void Function(String)? onChanged;

  const CustomMenuAnchorChildren({
    required this.isAnchorEdit,
    required this.menuCtrl,
    required this.title,
    required this.saveOnPressed,
    this.onSliderOneChange,
    this.onSliderTwoChange,
    super.key,
    this.sliderValue1,
    this.sliderValue2,
    this.sliderSubtitle1,
    this.sliderSubtitle2,
    this.onChanged,
    this.comment,
  });

  @override
  State<CustomMenuAnchorChildren> createState() =>
      _CustomMenuAnchorChildrenState();
}

class _CustomMenuAnchorChildrenState extends State<CustomMenuAnchorChildren> {
  late TextEditingController textCtrl;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    textCtrl = TextEditingController(text: widget.comment ?? "");
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    textCtrl.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //!-----------------Menu Anchor Container----------------
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
        desktop: Constants.width * 0.4,
      ),
      child: Column(
        children: [
          //!----------Title and close button----------------
          _titleAndClose(context),
          5.height,
          widget.isAnchorEdit
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  //!----------KeyboardListener to handle TextField cursor movement with arrow keys ----------------
                  child: KeyboardListener(
                    focusNode: focusNode,
                    onKeyEvent: (KeyEvent event) {
                      if (event is KeyDownEvent) {
                        int cursorPos = textCtrl.selection.baseOffset;
                        if (event.logicalKey == LogicalKeyboardKey.arrowLeft &&
                            cursorPos > 0) {
                          textCtrl.selection = TextSelection.fromPosition(
                              TextPosition(offset: cursorPos - 1));
                        } else if (event.logicalKey ==
                                LogicalKeyboardKey.arrowRight &&
                            cursorPos < textCtrl.text.length) {
                          textCtrl.selection = TextSelection.fromPosition(
                              TextPosition(offset: cursorPos + 1));
                        }
                      }
                    },
                    child: TextField(
                      onChanged: widget.onChanged,
                      maxLines: 4,
                      controller: textCtrl,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.lightGrey,
                        hintText: StringConst.markYourAssumption,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                          fontSize: getValueForScreenType(
                            context: context,
                            mobile: 8,
                            tablet: 8,
                            desktop: 12,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                )
              : SliderContent(
                  sliderSubtitle1: widget.sliderSubtitle1 ?? "",
                  sliderSubtitle2: widget.sliderSubtitle2 ?? "",
                  sliderValue1: widget.sliderValue1,
                  sliderValue2: widget.sliderValue2,
                  onSliderOneChange: widget.onSliderOneChange,
                  onSliderTwoChange: widget.onSliderTwoChange,
                ),

          //!---------Save Button----------------
          uiCon.saveButton(
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
            onPressed: () {
              if (widget.saveOnPressed != null) {
                widget.saveOnPressed!(textCtrl.text);
              }
              if (widget.menuCtrl.isOpen) {
                widget.menuCtrl.close();
              }
            },
          ),
          15.height,
        ],
      ),
    );
  }

  //!-----------------Title and close button----------------
  Row _titleAndClose(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(), // Empty container to take up space at the start
        //!------( title )------!//
        KStyles().bold(
          text: widget.title,
          color: AppColors.maroon,
          size: getValueForScreenType(
            context: context,
            mobile: 12,
            tablet: 12,
            desktop: 16,
          ),
        ),
        //!------( close button )------!//
        Row(
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
            //!---icon button---!
            IconButton(
              onPressed: () {
                if (widget.menuCtrl.isOpen) {
                  widget.menuCtrl.close();
                }
              },
              icon: const Icon(Icons.close_rounded),
              iconSize: 30,
              color: AppColors.maroon,
            ),
          ],
        ),
      ],
    );
  }
}

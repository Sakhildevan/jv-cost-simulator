import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../styles/text_styles.dart';
import '../themes/app_colors.dart';
import 'custom-tool-tip/custom_tool_tip_widget.dart';
import 'custom_chip.widget.dart';
import 'custom_drop_down.widget.dart';
import 'custom_text_field.widget.dart';

//!------------------------------------CustomTextFieldLabel Page-----------------------------------------
class CustomTextFieldLabel<T> extends StatelessWidget {
  const CustomTextFieldLabel({
    required this.text,
    super.key,
    this.message = false,
    this.dropDown = false,
    this.content = false,
    this.showToolTip = false,
    this.width,
    this.controller,
    this.child,
    this.menuCtrl,
    this.onChanged,
    this.textFieldInitialValue,
    this.onDropDownChanged,
    this.itemList,
    this.dropDownValue,
    this.dropDownHintText,
    this.isDropDownTapped,
    this.commonValidator,
    this.dropDownValidator,
    this.displayText,
    this.messageOnSaved,
    this.comment,
    this.value,
    this.keyboardType,
    this.inputFormat,
    this.commentCtrl,
    this.suffixStyle,
    this.suffixText,
    this.hintText,
    this.enabled = true,
    this.showAddIcon,
    this.contentPadding,
    this.onSuffixIconPressed,
    this.dataList,
    this.onDeleteTap,
    this.showPrefixToolTip,
    this.prefixToolTipText,
    this.shrinkDropDown,
    this.readOnly,
    this.focusNode,
    // this.addbuttonenabled = true,
  });

  final MenuController? menuCtrl;
  final TextEditingController? commentCtrl;
  final TextEditingController? controller;
  final bool message;
  final bool dropDown;
  final bool content;
  final bool showToolTip;
  final bool? showAddIcon;
  final double? width;
  final String text;
  final bool enabled;
  final FocusNode? focusNode;
  // final bool addbuttonenabled;
  final EdgeInsetsGeometry? contentPadding;
  final String? dropDownHintText;
  final String? comment;
  final Widget? child;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormat;
  final void Function(String)? onChanged;
  final void Function()? onSuffixIconPressed;
  final String? textFieldInitialValue;
  final void Function(T?)? onDropDownChanged;
  final List<T>? itemList;
  final T? dropDownValue;
  final bool? isDropDownTapped;
  final String? Function(String?)? commonValidator;
  final void Function(String?)? messageOnSaved;
  final void Function(int?)? onDeleteTap;
  final String? Function(T?)? dropDownValidator;
  final String? Function(T?)? displayText;
  final String? Function(T?)? value;
  final String? suffixText;
  final String? hintText;
  final String? prefixToolTipText;
  final TextStyle? suffixStyle;
  final bool? showPrefixToolTip;
  final bool? shrinkDropDown;
  final bool? readOnly;
  final List<String>? dataList;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // message
        //     ? _labelWithMessage(context)
        //     :
        (showPrefixToolTip ?? false)
            ? _labelWithToolTip(context)
            : _label(context),
        10.width,
        Expanded(
          flex: 2,
          child: dropDown
              //!---dropDown---!
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: CustomDropDown<T>(
                        itemList: itemList ?? [],
                        onDropDownChanged: onDropDownChanged,
                        dropDownValue: dropDownValue,
                        dropDownHintText: dropDownHintText,
                        isTapped: isDropDownTapped,
                        validator: dropDownValidator,
                        displayText: displayText,
                        value: value,
                        contentPadding: contentPadding,
                      ),
                    ),
                    if (shrinkDropDown ?? false)
                      Flexible(
                        child: SizedBox(
                          height: 35,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: child ?? const SizedBox(),
                          ),
                        ),
                      ),
                    if (shrinkDropDown ?? false) 10.width,
                  ],
                )
              : content
                  //!---textFieldWith content---!
                  ? _textFieldWithContentSelection(
                      context,
                    )
                  //!---textFieldInput---!
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          focusNode: focusNode,
                          readOnly: readOnly,
                          suffix: InkWell(
                            onTap: (showAddIcon ?? false)
                                ? onSuffixIconPressed
                                : null,
                            child: Icon(
                              Icons.add_circle_outline,
                              color: (showAddIcon ?? false)
                                  ? AppColors.grey
                                  : AppColors.transparent,
                              size: getValueForScreenType(
                                context: context,
                                mobile: 16,
                                tablet: 18,
                                desktop: 20,
                              ),
                            ),
                          ),
                          // suffixText: suffixText,
                          suffixStyle: suffixStyle,
                          keyboardType: keyboardType,
                          inputFormat: inputFormat,
                          validator: commonValidator,
                          controller: controller,
                          onChanged: onChanged,
                          enabled: enabled,
                          hintText: hintText,
                        ),
                        (showAddIcon ?? false)
                            ? Wrap(
                                children: List.generate(
                                  dataList?.length ?? 0,
                                  (index) => CustomChip(
                                    label: dataList?[index] ?? "",
                                    textColor: AppColors.white,
                                    color: AppColors.maroon,
                                    borderColor: AppColors.boxBackGroundBlue,
                                    onDeleteTap: () {
                                      onDeleteTap!(index);
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
        ),

        // Icon(Icons.add),
      ],
    );
  }

//!----------------textFieldWithContentSelection----------------
  Widget _textFieldWithContentSelection(
    BuildContext context,
  ) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First item in Row: CustomTextField
            Expanded(
              flex: 1,
              child: CustomTextField(
                readOnly: readOnly,
                // suffixText: suffixText,
                suffix: InkWell(
                  onTap: (showAddIcon ?? false) ? onSuffixIconPressed : null,
                  child: Icon(
                    Icons.add_circle_outline,
                    color: (showAddIcon ?? false)
                        ? AppColors.grey
                        : AppColors.transparent,
                    size: getValueForScreenType(
                      context: context,
                      mobile: 16,
                      tablet: 18,
                      desktop: 20,
                    ),
                  ),
                ),
                suffixStyle: suffixStyle,
                inputFormat: inputFormat,
                keyboardType: keyboardType,
                validator: commonValidator,
                controller: controller,
                onChanged: onChanged,
                enabled: enabled,
                hintText: hintText,
              ),
            ),
            10.width,
            // Tooltip or SizedBox logic
            // if (showToolTip)
            //   Flexible(
            //     // Wrapping the entire Row in Flexible to prevent space conflicts
            //     child: SizedBox(
            //       height: 35, // Fixed height for the Tooltip
            //       child: AnimatedTooltip(
            //         content: SizedBox(
            //           width: getValueForScreenType(
            //             context: context,
            //             mobile: 120,
            //             tablet: 120,
            //             desktop: 200,
            //           ),
            //           child: KStyles().reg(
            //             size: getValueForScreenType(
            //               context: context,
            //               mobile: 11,
            //               tablet: 12,
            //               desktop: 14,
            //             ),
            //             overflow: TextOverflow.visible,
            //             text: StringConst.taxRefersToVatReferenceBottom,
            //             color: AppColors.black,
            //           ),
            //         ),
            //         child: Align(
            //           alignment: Alignment.centerLeft,
            //           child: child ?? const SizedBox(),
            //         ),
            //       ),
            //     ),
            //   )
            // else
            Flexible(
              child: SizedBox(
                height: 35,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: child ?? const SizedBox(),
                ),
              ),
            ),
          ],
        ),
        // (showAddIcon ?? false)
        //     ? Wrap(
        //         children: List.generate(
        //           dataList?.length ?? 0,
        //           (index) => Padding(
        //             padding: const EdgeInsets.only(top: 5.0),
        //             child: Row(
        //               children: [
        //                 const Expanded(
        //                   child: CustomChip(
        //                     label: '',
        //                     textColor: AppColors.boxBackGroundBlue,
        //                     color: AppColors.kTextBlue,
        //                     borderColor: AppColors.boxBackGroundBlue,
        //                   ),
        //                   // CustomTextTile(
        //                   //   onDeleteTap: () {
        //                   //     onDeleteTap!(index);
        //                   //   },
        //                   //   text: dataList?[index] ?? "",
        //                   // ),
        //                 ),
        //                 getValueForScreenType(
        //                   context: context,
        //                   mobile: kDim.kGap02,
        //                   tablet: kDim.kGap02,
        //                   desktop: kDim.kGap05,
        //                 ),
        //                 Flexible(
        //                   child: SizedBox(
        //                     height: 35,
        //                     child: Align(
        //                       alignment: Alignment.centerLeft,
        //                       child: Row(
        //                         children: [
        //                           child ?? const SizedBox(),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       )
        //     : const SizedBox.shrink(),

        // ? Wrap(
        //     children: List.generate(
        //       dataList?.length ?? 0,
        //       (index) => Padding(
        //           padding: const EdgeInsets.only(top: 5.0),
        //           child: Row(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Expanded(
        //                 child: Container(
        //                   alignment: Alignment.centerLeft,
        //                   padding: const EdgeInsets.only(
        //                     left: 10,
        //                     top: 5,
        //                     bottom: 5,
        //                   ),
        //                   decoration: BoxDecoration(
        //                     borderRadius: kDim.kRadius04,
        //                     color: AppColors.boxBackGround,
        //                   ),
        //                   width: double.infinity,
        //                   child: Row(
        //                     children: [
        //                       Expanded(
        //                         child: KStyles().reg(
        //                           overflow: TextOverflow.visible,
        //                           text: dataList?[index] ?? "",
        //                           size: getValueForScreenType(
        //                             context: context,
        //                             mobile: 10,
        //                             tablet: 12,
        //                             desktop: 14,
        //                           ),
        //                           color: AppColors.black,
        //                         ),
        //                       ),
        //                       InkWell(
        //                         borderRadius: kDim.kRadius100,
        //                         onTap: () {
        //                           onDeleteTap!(index);
        //                         },
        //                         child: Icon(
        //                           Icons.delete_forever,
        //                           color: AppColors.grey,
        //                           size: getValueForScreenType(
        //                             context: context,
        //                             mobile: 16,
        //                             tablet: 18,
        //                             desktop: 20,
        //                           ),
        //                         ),
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               ),
        // getValueForScreenType(
        //   context: context,
        //   mobile: kDim.kGap02,
        //   tablet: kDim.kGap02,
        //   desktop: kDim.kGap05,
        // ),
        //           Flexible(
        //             child: SizedBox(
        //               height: 35,
        //               child: Align(
        //                 alignment: Alignment.centerLeft,
        //                 child: Row(
        //                   children: [
        //                     child ?? const SizedBox(),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       )),
        // ),
        //   )
        // : const SizedBox.shrink(),
      ],
    );
  }

// !----------------label----------------
  Expanded _label(context) {
    return Expanded(
      flex: 1,
      child: KStyles().med(
        size: fontCon.boxLabelFontSize(context),
        overflow: TextOverflow.visible,
        text: text,
        color: AppColors.black,
      ),
    );
  }

  Widget _labelWithToolTip(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 35, // Fixed height for the Tooltip
        width: double.infinity, // Adjust this as necessary
        child: AnimatedTooltip(
          content: SizedBox(
            width: getValueForScreenType(
              context: context,
              mobile: 120,
              tablet: 120,
              desktop: 200,
            ),
            child: KStyles().reg(
              size: getValueForScreenType(
                context: context,
                mobile: 11,
                tablet: 12,
                desktop: 14,
              ),
              overflow: TextOverflow.visible,
              text: prefixToolTipText ?? "",
              color: AppColors.black,
            ),
          ),
          child: KStyles().reg(
            size: fontCon.boxLabelFontSize(context),
            overflow: TextOverflow.visible,
            text: text, // Main label text
            color: AppColors.black,
          ),
        ),
      ),
    );
  }

//!----------------labelWithMessage----------------
  // Expanded _labelWithMessage(context) {
  //   return Expanded(
  //     flex: 1,
  //     child: Row(
  //       children: [
  //         Flexible(
  //           child: RichText(
  //             text: TextSpan(
  //               style: KStyles()
  //                   .reg(
  //                     overflow: TextOverflow.visible,
  //                     text: '',
  //                     size: getValueForScreenType(
  //                       context: context,
  //                       mobile: 11,
  //                       tablet: 12,
  //                       desktop: 14,
  //                     ),
  //                     color: AppColors.black,
  //                   )
  //                   .style,
  //               children: [
  //                 TextSpan(text: text),
  //                 WidgetSpan(
  //                   child: 3.width,
  //                 ),
  //                 WidgetSpan(
  //                   //!----------------MenuAnchor----------------
  //                   child: MenuAnchor(
  //                     controller: menuCtrl,
  //                     alignmentOffset: Offset(
  //                         getValueForScreenType(
  //                           context: context,
  //                           mobile: -126,
  //                           tablet: -52,
  //                           desktop: -126,
  //                         ),
  //                         0),
  //                     menuChildren: [
  //                       //!----------------CustomMenuAnchorChildren----------------
  //                       CustomMenuAnchorChildren(
  //                         textCtrl: commentCtrl,
  //                         menuCtrl: menuCtrl ?? MenuController(),
  //                         title: text,
  //                         isAnchorEdit: true,
  //                         saveOnPressed: messageOnSaved,
  //                       ),
  //                     ],
  //                     //!---icon button---!
  //                     child: InkWell(
  //                       onTap: () {
  //                         if (menuCtrl != null) {
  //                           if (menuCtrl!.isOpen) {
  //                             menuCtrl!.close();
  //                           } else {
  //                             menuCtrl!.open();
  //                           }
  //                         }
  //                       },
  //                       //!---icon ---!
  //                       child:
  //                           // uiCon.pngImage(
  //                           //   assetImage: Assets.images.notSelected.path,
  //                           //   ht: 15,
  //                           //   wd: 15,
  //                           // ),

  //                           ((comment ?? '').isNotEmpty)
  //                               ? uiCon.pngImage(
  //                                   assetImage: '',
  //                                   ht: 15,
  //                                   wd: 15,
  //                                 )
  //                               : uiCon.pngImage(
  //                                   assetImage: Assets.images.notSelected.path,
  //                                   ht: 15,
  //                                   wd: 15,
  //                                 ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

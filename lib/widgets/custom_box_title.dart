import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../gen/assets.gen.dart';
import '../themes/app_colors.dart';
import 'menuanchor_popup.dart';

class CustomBoxTitle extends StatelessWidget {
  const CustomBoxTitle({
    required this.child,
    super.key,
    required this.title,
    this.imagePath,
    this.color,
    this.subTitle = false,
    this.cmntBox = false,
    this.subTitleText,
    this.showIcon,
    this.menuCtrl,
    this.commentCtrl,
    this.messageOnSaved,
    this.comment,
    this.onChanged,
  });
  final Widget child;
  final String title;
  final String? imagePath;
  final String? subTitleText;
  final String? comment;
  final Color? color;
  final bool subTitle;
  final bool cmntBox;
  final bool? showIcon;
  final MenuController? menuCtrl;
  final TextEditingController? commentCtrl;
  final Function(String)? messageOnSaved;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color ?? AppColors.boxBackGroundOrange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: _boxIconWithTitle(context),
    );
  }

  Row _boxIconWithTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //!--------- icon-------
        (showIcon ?? true) ? _buildIcon() : const SizedBox.shrink(),
        4.width,
        //!--------- heading-------
        Expanded(
          child: _textTitle(context),
        ),
        //  //!---------comment box-----

        // MenuAnchor(
        //   controller: menuCtrl,
        //   alignmentOffset: Offset(
        //     getValueForScreenType(
        //       context: context,
        //       mobile: -126,
        //       tablet: -52,
        //       desktop: -500,
        //     ),
        //     0,
        //   ),
        //   menuChildren: [
        //     //!----------------CustomMenuAnchorChildren----------------
        //     CustomMenuAnchorChildren(
        //       comment: comment,
        //       onChanged: onChanged,
        //       // textCtrl: commentCtrl,
        //       menuCtrl: menuCtrl ?? MenuController(),
        //       title: title,
        //       isAnchorEdit: true,
        //       saveOnPressed: messageOnSaved,
        //     ),
        //   ],
        //   //!---icon button---!
        //   child: InkWell(
        //     onTap: () {
        //       if (menuCtrl != null) {
        //         if (menuCtrl!.isOpen) {
        //           menuCtrl!.close();
        //         } else {
        //           menuCtrl!.open();
        //         }
        //       }
        //     },
        //     //!---icon ---!
        //     child: (cmntBox != false)
        //         ? GestureDetector(
        //             child: ((comment ?? '').isNotEmpty)
        //                 ? uiCon.svgIcon(
        //                     ht: getValueForScreenType(
        //                       context: context,
        //                       mobile: 8,
        //                       tablet: 11,
        //                       desktop: 20,
        //                     ),
        //                     wd: getValueForScreenType(
        //                       context: context,
        //                       mobile: 8,
        //                       tablet: 11,
        //                       desktop: 20,
        //                     ),
        //                     assetImage: Assets.icons.withComment,
        //                     color: AppColors.maroon,
        //                   )
        //                 : uiCon.svgIcon(
        //                     ht: getValueForScreenType(
        //                       context: context,
        //                       mobile: 8,
        //                       tablet: 11,
        //                       desktop: 20,
        //                     ),
        //                     wd: getValueForScreenType(
        //                       context: context,
        //                       mobile: 8,
        //                       tablet: 11,
        //                       desktop: 20,
        //                     ),
        //                     assetImage: Assets.icons.withoutComment,
        //                     color: AppColors.maroon,
        //                   ),
        //           )
        //         : const SizedBox.shrink(),

        //   ),
        // ),
      ],
    );
  }

// ---------icon----------
  SizedBox _buildIcon() {
    return uiCon.pngImage(ht: 35, wd: 35, assetImage: imagePath ?? '');
  }

// ---------heading----------
  Column _textTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        subTitle
            ? _textWithSubTitle(context)
            // ---------heading without subheading----------
            : Row(
                children: [
                  KStyles().bold(
                    text: title,
                    size: fontCon.boxTitleFontSize(context),
                    color: AppColors.maroon,
                  ),
                  10.width,
                  // //!---------comment box-----

                  MenuAnchor(
                    controller: menuCtrl,
                    alignmentOffset: Offset(
                      getValueForScreenType(
                        context: context,
                        mobile: -126,
                        tablet: -52,
                        desktop: -500,
                      ),
                      0,
                    ),
                    menuChildren: [
                      //!----------------CustomMenuAnchorChildren----------------
                      CustomMenuAnchorChildren(
                        comment: comment,
                        onChanged: onChanged,
                        // textCtrl: commentCtrl,
                        menuCtrl: menuCtrl ?? MenuController(),
                        title: title,
                        isAnchorEdit: true,
                        saveOnPressed: messageOnSaved,
                      ),
                    ],
                    //!---icon button---!
                    child: InkWell(
                      onTap: () {
                        if (menuCtrl != null) {
                          if (menuCtrl!.isOpen) {
                            menuCtrl!.close();
                          } else {
                            menuCtrl!.open();
                          }
                        }
                      },
                      //!---icon ---!
                      child: (cmntBox != false)
                          ? GestureDetector(
                              child: ((comment ?? '').isNotEmpty)
                                  ? uiCon.svgIcon(
                                      ht: getValueForScreenType(
                                        context: context,
                                        mobile: 8,
                                        tablet: 11,
                                        desktop: 20,
                                      ),
                                      wd: getValueForScreenType(
                                        context: context,
                                        mobile: 8,
                                        tablet: 11,
                                        desktop: 20,
                                      ),
                                      assetImage: Assets.icons.withComment,
                                      color: AppColors.maroon,
                                    )
                                  : uiCon.svgIcon(
                                      ht: getValueForScreenType(
                                        context: context,
                                        mobile: 8,
                                        tablet: 11,
                                        desktop: 20,
                                      ),
                                      wd: getValueForScreenType(
                                        context: context,
                                        mobile: 8,
                                        tablet: 11,
                                        desktop: 20,
                                      ),
                                      assetImage: Assets.icons.withoutComment,
                                      color: AppColors.maroon,
                                    ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
        5.height,
        child,
      ],
    );
  }

// ---------heading with subheading----------
  Row _textWithSubTitle(BuildContext context) {
    return Row(
      children: [
        Flexible(
          // ---------heading----------
          child: KStyles().bold(
            overflow: TextOverflow.visible,
            text: title,
            size: 14,
            color: AppColors.maroon,
          ),
        ),
        5.width,
        Flexible(
          // ---------subheading----------
          child: KStyles().reg(
            text: subTitleText ?? '',
            color: AppColors.black,
            overflow: TextOverflow.visible,
            size: getValueForScreenType(
              context: context,
              mobile: 10,
              tablet: 10,
              desktop: 13,
            ),
          ),
        ),
      ],
    );
  }
}

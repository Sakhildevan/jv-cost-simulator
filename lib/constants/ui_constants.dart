import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:neopop/neopop.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../config/config.dart';
import '../gen/assets.gen.dart';
import '../themes/app_colors.dart';
import '../utils/constants.dart';
import '../utils/enums.dart';
import '../utils/string_const.dart';
import '../widgets/loader.widget.dart';
import '../widgets/page_header.widget.dart';
import '../widgets/shimmer.widget.dart';
import '../widgets/slider_indicator_title.widget.dart';

class UiConstants {
  //*------ table header cell
  Widget tableHeaderCell(
    String text,
    double width,
    BuildContext context, {
    TextAlign? textAlign,
  }) {
    return Container(
      width: width,
      height: getValueForScreenType(
        context: context,
        mobile: 25,
        tablet: 40,
        desktop: 40,
      ),
      decoration: const BoxDecoration(
        color: AppColors.kTextBlue,
      ),
      // alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),

      child: KStyles().semiBold(
        overflow: TextOverflow.visible,
        text: text,
        size: getValueForScreenType(
          context: context,
          mobile: 10,
          tablet: 14,
          desktop: 17,
        ),
        color: AppColors.white,
        textAlign: textAlign,
      ),
    );
  }
  //*-------------(table value cell)

  Widget tableValueCell(
    String text,
    double width,
    BuildContext context, {
    TextAlign? textAlign,
    Color? textColor,
    //Widget? child,
  }) {
    return Container(
      width: width,
      //TODO : commented for future use
      // height: getValueForScreenType(
      //   context: context,
      //   mobile: 25,
      //   tablet: 42,
      //   desktop: 40,
      // ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child:
          //child ??
          KStyles().reg(
        overflow: TextOverflow.visible,
        text: text,
        color: textColor ?? AppColors.black,
        size: getValueForScreenType(
          context: context,
          mobile: 9,
          tablet: 13,
          desktop: 16,
        ),
        textAlign: textAlign,
      ),
    );
  }
  //*----------(status cell)

  // Widget statusCell(String status, BuildContext context,
  //     {double? width, AlignmentGeometry? alignment}) {
  //   return Container(
  //     width: width,
  //     alignment: alignment,
  //     padding: const EdgeInsets.all(3),
  //     // decoration: BoxDecoration(
  //     //   color: status == StringConst.completed.toUpperCase() ||
  //     //           status == StringConst.completed
  //     //       ? AppColors.kTextBlue
  //     //       : AppColors.pendingYellow,
  //     //   borderRadius: BorderRadius.circular(100.0),
  //     // ),
  //     child: KStyles().bold(
  //       text: status,
  //       size: getValueForScreenType(
  //         context: context,
  //         mobile: 7,
  //         tablet: 12,
  //         desktop: 15,
  //       ),
  //       color: status == StringConst.completed.toUpperCase() ||
  //               status == StringConst.completed
  //           ? AppColors.kTextBlue
  //           : AppColors.pendingYellow,
  //       // color: status == StringConst.completed.toUpperCase() ||
  //       //         status == StringConst.completed
  //       //     ? Colors.white
  //       //     : Colors.black,
  //       textAlign: TextAlign.center,
  //     ),
  //   );
  // }
  //*----------------(red button)

  Container commonButton(
      {double? width,
      required double height,
      double? loaderSize,
      required Widget child,
      required Color color,
      required void Function()? onPressed,
      BorderRadiusGeometry? borderRadius,
      bool? isLoading,
      WidgetStateProperty<EdgeInsetsGeometry?>? padding}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
            padding: padding ?? const WidgetStatePropertyAll(EdgeInsets.zero),
            backgroundColor: WidgetStatePropertyAll(
              color,
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.zero,
            ))),
        onPressed: onPressed,
        child: (isLoading ?? false)
            ? bounceLoader(
                loaderSize: loaderSize,
              )
            : child,
        // child: child,
      ),
    );
  }

//*-------(bounce loader)
  Widget bounceLoader({
    double? loaderSize,
    Color? color,
  }) {
    return SpinKitThreeBounce(
      size: loaderSize ?? 20,
      color: color ?? AppColors.white,
    );
  }

//*-------(bounce loader)
  Widget circleLoader({
    double? loaderSize,
    Color? color,
  }) {
    return SpinKitFadingCircle(
      size: loaderSize ?? 20,
      color: color ?? AppColors.white,
    );
  }

  //*----------(radio button)
  Widget radioButton({
    required dynamic value,
    required dynamic groupValue,
    required void Function(dynamic)? onChanged,
    required double? scale,
  }) {
    return Transform.scale(
      scale: scale,
      child: Radio(
        activeColor: AppColors.kTextBlue,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }

  //*--------(save button)
  Widget saveButton({
    required void Function()? onPressed,
    required BuildContext context,
    double? height,
    double? width,
    double? horizontalPadding,
    double? fontSize,
    double? iconHt,
    double? iconWd,
    Color? color,
    bool? isLoading,
    double? loaderSize,
    String? text,
    String? assetImage,
    bool? isSvg,
  }) {
    return commonButton(
      loaderSize: loaderSize,
      isLoading: isLoading,
      height: height ??
          getValueForScreenType(
            context: context,
            mobile: 25,
            desktop: 40,
            tablet: 30,
          ),
      width: width ??
          getValueForScreenType(
            context: context,
            mobile: 100,
            desktop: 140,
            tablet: 120,
          ),
      borderRadius: kDim.kRadius20,
      color: color ?? AppColors.maroon,
      onPressed: onPressed,
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 20,
          vertical: 0,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: KStyles().semiBold(
                  overflow: TextOverflow.visible,
                  text: text ?? StringConst.save,
                  size: fontSize ??
                      getValueForScreenType(
                        context: context,
                        mobile: 10,
                        tablet: 12,
                        desktop: 14,
                      ),
                  color: AppColors.white),
            ),
          ),
          (isSvg ?? false)
              ? uiCon.svgIcon(
                  ht: iconHt ??
                      getValueForScreenType(
                        context: context,
                        mobile: 15,
                        tablet: 16,
                        desktop: 18,
                      ),
                  wd: iconWd ??
                      getValueForScreenType(
                        context: context,
                        mobile: 15,
                        tablet: 16,
                        desktop: 18,
                      ),
                  assetImage: assetImage ?? Assets.images.saveButton.path,
                  color: AppColors.white,
                )
              : uiCon.pngImage(
                  ht: iconHt ??
                      getValueForScreenType(
                        context: context,
                        mobile: 15,
                        tablet: 16,
                        desktop: 18,
                      ),
                  wd: iconWd ??
                      getValueForScreenType(
                        context: context,
                        mobile: 15,
                        tablet: 16,
                        desktop: 18,
                      ),
                  assetImage: assetImage ?? Assets.images.saveButton.path,
                ),
        ],
      ),
    );
  }

  //*--------(save button)
  Widget simButton({
    required void Function()? onPressed,
    double? height,
    double? width,
    double? horizontalPadding,
    double? fontSize,
    required Widget child,
    required String text,
    bool? isLoading,
    Color? color,
  }) {
    return commonButton(
      isLoading: isLoading,
      height: height ?? 30,
      width: width,
      borderRadius: kDim.kRadius20,
      color: color ?? AppColors.maroon,
      onPressed: onPressed,
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 15,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: KStyles().semiBold(
                  text: text, size: fontSize ?? 14, color: AppColors.white),
            ),
          ),
          child,
        ],
      ),
    );
  }

  // *---------------(global button )------------
  Widget globalButton({
    required void Function()? onPressed,
    double? height,
    double? width,
    double? horizontalPadding,
    Color? color,
    Color? iconColor,
    IconData? icon,
    String? text,
    double? iconHt,
    double? iconWd,
    bool? isPng,
    bool? isIconFirst,
    bool? isIcon,
    String? assetImage,
    double? fontSize,
    TextAlign? textAlign,
    TextOverflow? overflow,
    bool? isLoading,
    required BuildContext context,
  }) {
    return commonButton(
      isLoading: isLoading,
      height: height ??
          getValueForScreenType(
            context: context,
            mobile: 25,
            desktop: 40,
            tablet: 30,
          ),
      width: width ??
          getValueForScreenType(
            context: context,
            mobile: 100,
            desktop: 140,
            tablet: 120,
          ),
      borderRadius: kDim.kRadius20,
      color: color ?? AppColors.buttonColor,
      onPressed: onPressed,
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 20,
        ),
      ),
      child: (isIconFirst ?? true)
          ? Row(
              children: [
                (isIcon ?? false)
                    ? Icon(
                        icon,
                        size: iconHt,
                        color: iconColor,
                      )
                    : (isPng ?? true)
                        ? uiCon.pngImage(
                            ht: iconHt ??
                                getValueForScreenType(
                                  context: context,
                                  mobile: 15,
                                  tablet: 16,
                                  desktop: 18,
                                ),
                            wd: iconWd ??
                                getValueForScreenType(
                                  context: context,
                                  mobile: 15,
                                  tablet: 16,
                                  desktop: 18,
                                ),
                            assetImage: assetImage ?? Assets.images.back.path,
                            //color: AppColors.white,
                          )
                        : uiCon.svgIcon(
                            ht: iconHt ??
                                getValueForScreenType(
                                  context: context,
                                  mobile: 15,
                                  tablet: 16,
                                  desktop: 18,
                                ),
                            wd: iconWd ??
                                getValueForScreenType(
                                  context: context,
                                  mobile: 15,
                                  tablet: 16,
                                  desktop: 18,
                                ),
                            assetImage: assetImage ?? Assets.icons.edit,
                            color: iconColor,
                          ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: KStyles().semiBold(
                      textAlign: textAlign,
                      text: text ?? StringConst.edit,
                      size: fontSize ??
                          getValueForScreenType(
                            context: context,
                            mobile: 11,
                            tablet: 12,
                            desktop: 14,
                          ),
                      color: AppColors.white,
                      overflow: overflow ?? TextOverflow.visible,
                    ),
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: KStyles().semiBold(
                      textAlign: textAlign,
                      text: text ?? StringConst.edit,
                      size: fontSize ?? 14,
                      color: AppColors.white,
                      overflow: overflow ?? TextOverflow.visible,
                    ),
                  ),
                ),
                (isIcon ?? false)
                    ? Icon(
                        icon,
                        size: iconHt,
                        color: iconColor,
                      )
                    : (isPng = true)
                        ? uiCon.pngImage(
                            ht: iconHt ?? 10,
                            wd: iconWd ?? 10,
                            assetImage: assetImage ?? Assets.images.back.path,
                            //color: AppColors.white,
                          )
                        : uiCon.svgIcon(
                            ht: iconHt ?? 10,
                            wd: iconWd ?? 10,
                            assetImage: assetImage ?? Assets.icons.edit,
                            //color: AppColors.white,
                          ),
              ],
            ),
    );
  }

//*---------------------------------------------------------------- (Svg_Icon)
  SizedBox svgIcon(
      {required double ht,
      required double wd,
      required String assetImage,
      BoxFit? fit,
      Color? color}) {
    return SizedBox(
      height: ht,
      width: wd,
      child: SvgPicture.asset(
          fit: fit ?? BoxFit.contain,
          assetImage,
          colorFilter: color != null
              ? ColorFilter.mode(
                  color,
                  BlendMode.srcIn,
                )
              : null
          // color: color,
          ),
    );
  }

//*---------------------------------------------------------------- (Png image)
  SizedBox pngImage(
      {required double ht,
      required double wd,
      required String assetImage,
      BoxFit? fit,
      Color? color}) {
    return SizedBox(
      height: ht,
      width: wd,
      child: Image.asset(
        fit: fit,
        assetImage,
        color: color,
      ),
    );
  }

  //*-----------------------------(ShimmerLoader)
  ShimmerLoader shimmerLoader({int? listCount, required ShimmerType type}) {
    return ShimmerLoader(
      listCount: listCount,
      type: type,
    );
  }

  //*-----------------------------(slider indicator title)
  SliderIndicatorTitle sliderIndicatorTitle() {
    return const SliderIndicatorTitle();
  }

  Container bgImage({
    required Widget child,
  }) {
    return Container(
      width: Constants.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.images.loginBg.provider(),
          fit: BoxFit.fill,
        ),
      ),
      child: child,
    );
  }

  //*----------(page Header)
  PageHeader pageHeader({
    required String userName,
    bool? isUserVisible,
  }) {
    return PageHeader(
      userName: userName,
      isUserVisible: isUserVisible,
    );
  }
  //*---------(dialog builder)

//*-----------(dialog builder)
  Future<void> dialogBuilder({
    required BuildContext context,
    required Widget child,
    AlignmentGeometry? alignment,
    Color? backgroundColor,
    double? elevation,
    Clip clipBehavior = Clip.none,
    EdgeInsets? insetPadding,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        alignment: alignment,
        backgroundColor: backgroundColor,
        elevation: elevation,
        clipBehavior: clipBehavior,
        insetPadding: insetPadding,
        child: child,
      ),
    );
  }

  //*-------------(empty data)
  Widget emptyData(BuildContext context) {
    return SizedBox(
      height: Constants.height * .15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: KStyles().bold(
              size: getValueForScreenType(
                context: context,
                mobile: 15,
                tablet: 18,
                desktop: 20,
              ),
              text: StringConst.noData,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
  //*------------(logo)

//!--------(logo card)
  Widget logo(
    BuildContext context, {
    double? wd,
    double? ht,
  }) {
    return uiCon.svgIcon(
      assetImage: Assets.icons.logo,
      wd: wd ??
          getValueForScreenType(
            context: context,
            mobile: 100,
            tablet: 150,
            desktop: 200,
          ),
      ht: ht ??
          getValueForScreenType(
            context: context,
            mobile: 40,
            tablet: 60,
            desktop: 80,
          ),
    );
  }

  Future<void> popupLoading(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: Loader(),
        );
      },
    );
  }

  void showLoadingDialog(BuildContext context, Stream<int> progressStream) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Generating PDF'),
          content: StreamBuilder<int>(
            stream: progressStream,
            initialData: 0,
            builder: (context, snapshot) {
              final progress = snapshot.data ?? 0;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(value: progress / 100),
                  kDim.kGap10,
                  KStyles().reg(
                    text: '$progress% completed',
                    size: 15,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void errorToast(BuildContext context) {
    return MotionToast.warning(
      title: const Text(
        'Warning Motion Toast',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: const Text('This is a Warning'),
      animationCurve: Curves.bounceIn,
      borderRadius: 0,
      animationDuration: const Duration(milliseconds: 1000),
      opacity: .9,
    ).show(context);
  }

  Widget animatedFlipCounter({
    required String? number,
    required BuildContext context,
    required TextStyle? textStyle,
    bool? isPercent,
  }) {
    return AnimatedFlipCounter(
      thousandSeparator: (isPercent ?? false) ? null : ',',
      fractionDigits: 3,
      duration: const Duration(milliseconds: 500),
      value: fCon.parseStringToNum(number ?? "") ?? 0,
      textStyle: textStyle,
      suffix: (isPercent ?? false) ? '%' : null,
    );
  }

  Widget neoPopButton({
    required void Function()? onTap,
    required Widget child,
  }) {
    return NeoPopTiltedButton(
      decoration: const NeoPopTiltedButtonDecoration(
        color: AppColors.maroon,
        plunkColor: AppColors.maroon,
        shadowColor: Color.fromRGBO(36, 36, 36, 1),
        showShimmer: true,
      ),
      onTapDown: onTap,
      child: child,
    );
  }

  Widget customStatusPop({
    required String title,
    String? subTitle,
    required DialogType type,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardCream,
        borderRadius: kDim.kRadius15,
      ),
      height: 300,
      width: 300,
      child: Dialog(
        backgroundColor: AppColors.cardCream,
        shape: RoundedRectangleBorder(
          borderRadius: kDim.kRadius15,
        ),
        elevation: 16,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: uiCon.pngImage(
                assetImage: type == DialogType.failure
                    ? Assets.images.cross.path
                    : Assets.images.check.path,
                ht: 100,
                wd: 100,
              ),
            ),
            KStyles().bold(
              text: title,
              size: 30,
            ),
            KStyles().reg(
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              text: subTitle ?? "",
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget statusBar(
    BuildContext context, {
    required String status,
    double? size,
    String? createdOn,
    bool showCreatedOn = false,
    // bool showDropdown = false,
  }) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            KStyles().bold(
              color: AppColors.maroon,
              text: '${StringConst.status.toUpperCase()} :',
              size: size ??
                  getValueForScreenType(
                    context: context,
                    mobile: 8,
                    tablet: 10,
                    desktop: Constants.width >= 1040 ? 18 : 12,
                  ),
              textAlign: TextAlign.center,
            ),
            (showCreatedOn)
                ? KStyles().bold(
                    color: AppColors.maroon,
                    text: '${StringConst.createdOn.toUpperCase()} :',
                    size: size ??
                        getValueForScreenType(
                          context: context,
                          mobile: 8,
                          tablet: 8,
                          desktop: Constants.width <= 1050 ? 11 : 13,
                        ),
                    textAlign: TextAlign.center,
                  )
                : const SizedBox.shrink(),
          ],
        ),
        5.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KStyles().bold(
              text: status,
              size: size ??
                  getValueForScreenType(
                    context: context,
                    mobile: 8,
                    tablet: 10,
                    desktop: Constants.width >= 1040 ? 18 : 12,
                  ),
              color: status == StringConst.completed.toUpperCase() ||
                      status == StringConst.completed
                  ? AppColors.textgreen
                  : status == StringConst.approval.toUpperCase()
                      ? AppColors.approvaltext
                      : AppColors.pendingtext,
              // color: AppColors.kTextBlue,
              textAlign: TextAlign.center,
            ),
            (showCreatedOn)
                ? KStyles().bold(
                    text: (createdOn?.isNotEmpty ?? false) ? '$createdOn' : '',
                    color: AppColors.headingTextBlue,
                    size: size ??
                        getValueForScreenType(
                          context: context,
                          mobile: 8,
                          tablet: 8,
                          desktop: Constants.width <= 1050 ? 11 : 13,
                        ),
                    textAlign: TextAlign.center,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}

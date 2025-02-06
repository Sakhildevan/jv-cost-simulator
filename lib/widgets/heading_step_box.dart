import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:johnsonville_cost_simulator/utils/constants.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../bloc/step_two_bloc/step_two_bloc.dart';
import '../themes/app_colors.dart';
import '../utils/enums.dart';
import '../utils/string_const.dart';

class HeadingForStepBox extends StatelessWidget {
  final String stepNo;
  const HeadingForStepBox({
    required this.stepNo,
    this.onPressed,
    this.color,
    super.key,
    required this.createdBy,
    required this.createdOn,
    required this.approvedBy,
    required this.approvedOn,
    required this.status,
  });
  final void Function()? onPressed;
  final Color? color;
  final String? createdBy;
  final String? createdOn;
  final String? approvedBy;
  final String? approvedOn;
  final String? status;

  @override
  Widget build(BuildContext context) {
    if (getDeviceType(MediaQuery.of(context).size) == DeviceScreenType.mobile) {
      return _mobileView(context);
    } else {
      return _desktopView(context);
    }
  }

  // !------------------------------------Mobile View-----------------------------------------!
  Row _mobileView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentBody(context),
        //---------------createdBy, approvedBy, saveButton, stepNo
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //------createdBy, approvedBy
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    KStyles().bold(
                      size: commonSize(context),
                      text: '${StringConst.createdBy} : ',
                      color: AppColors.maroon,
                      textAlign: TextAlign.start,
                    ),
                    KStyles().bold(
                      size: commonSize(context),
                      text: '${StringConst.approvedBy} : ',
                      color: AppColors.maroon,
                    ),
                  ],
                ),
                //------createdOn, approvedOn
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    KStyles().bold(
                      size: commonSize(context),
                      text: (createdBy?.isNotEmpty ?? false) &&
                              (createdOn?.isNotEmpty ?? false)
                          ? '$createdBy,$createdOn'
                          : '',
                      color: AppColors.headingTextBlue,
                    ),
                    KStyles().bold(
                      size: commonSize(context),
                      text: (approvedBy?.isNotEmpty ?? false) &&
                              (approvedOn?.isNotEmpty ?? false)
                          ? '$approvedBy, $approvedOn'
                          : "",
                      color: AppColors.headingTextBlue,
                    ),
                    20.width,
                    (status?.isNotEmpty ?? false)
                        //*statusBar
                        ? uiCon.statusBar(context,
                            //showDropdown: true,
                            status: status ?? "")
                        : const SizedBox.shrink(),
                  ],
                ),
                kDim.kGap10,
                //------saveButton, stepNo
                Column(
                  children: [
                    KStyles().bold(
                      text: stepNo,
                      size: 9,
                      color: AppColors.maroon,
                    ),
                    (stepNo == StringConst.step2)
                        ? uiCon.saveButton(
                            context: context,
                            color: color ?? AppColors.buttonColor,
                            onPressed: onPressed,
                            horizontalPadding: 5,
                            fontSize: 7,
                            width: 40,
                            iconHt: 10,
                            iconWd: 10,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

// !------------------------------------Desktop and Tablet View-----------------------------------------!
  Row _desktopView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _contentBody(context),
              // (status?.isNotEmpty ?? false)
              //     //*statusBar
              //     ?
              uiCon.statusBar(
                context,
                size: commonSize(context),
                status: status ?? "",
                createdOn: createdOn ?? "",
                showCreatedOn: true,
              ),
              // ? _statusBar(context)
              //: const SizedBox.shrink(),
            ],
          ),
        ),
        //---------------createdBy, approvedBy, saveButton, stepNo
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //------createdBy, approvedBy
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      KStyles().bold(
                        size: commonSize(context),
                        text: '${StringConst.createdBy.toUpperCase()} : ',
                        color: AppColors.maroon,
                      ),
                      KStyles().bold(
                        size: commonSize(context),
                        text: '${StringConst.approvedBy.toUpperCase()} : ',
                        color: AppColors.maroon,
                      ),
                    ],
                  ),
                  //------createdOn, approvedOn
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KStyles().bold(
                        size: commonSize(context),
                        text: (createdBy?.isNotEmpty ?? false) &&
                                (createdOn?.isNotEmpty ?? false)
                            ? '$createdBy'
                            : '',
                        color: AppColors.headingTextBlue,
                      ),
                      KStyles().bold(
                        size: commonSize(context),
                        text: (approvedBy?.isNotEmpty ?? false) &&
                                (approvedOn?.isNotEmpty ?? false)
                            ? '$approvedBy, $approvedOn'
                            : "",
                        color: AppColors.headingTextBlue,
                      ),
                    ],
                  ),
                  kDim.kGap10,
                  //------saveButton, stepNo
                  (BlocBuilder<StepTwoBloc, StepTwoState>(
                    builder: (context, state) {
                      return (stepNo == StringConst.step2)
                          ? (state.stepTwoSaveLoadingStatus ==
                                  LoadingStatus.loading
                              ? const Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.maroon),
                                    ),
                                  ),
                                )
                              : uiCon.saveButton(
                                  context: context,
                                  color: color ?? AppColors.buttonColor,
                                  onPressed: onPressed,
                                  horizontalPadding: getValueForScreenType(
                                    context: context,
                                    mobile: 8,
                                    tablet: 8,
                                    desktop: Constants.width <= 1050 ? 10 : 14,
                                  ),
                                  fontSize: getValueForScreenType(
                                    context: context,
                                    mobile: 8,
                                    tablet: 9,
                                    desktop: Constants.width <= 1050 ? 12 : 14,
                                  ),
                                  // height: getValueForScreenType(
                                  //   context: context,
                                  //   mobile: 20,
                                  //   tablet: 27,
                                  //   desktop: 40,
                                  // ),
                                  width: getValueForScreenType(
                                    context: context,
                                    mobile: 60,
                                    tablet: 60,
                                    desktop: Constants.width * 0.06,
                                  ),
                                  iconHt: getValueForScreenType(
                                    context: context,
                                    mobile: 10,
                                    tablet: 10,
                                    desktop: Constants.width <= 1050 ? 10 : 15,
                                  ),
                                  iconWd: getValueForScreenType(
                                    context: context,
                                    mobile: 10,
                                    tablet: 10,
                                    desktop: Constants.width <= 1050 ? 10 : 15,
                                  ),
                                ))
                          : const SizedBox.shrink();
                    },
                  )),

                  kDim.kGap10,
                  KStyles().bold(
                    text: stepNo,
                    size: getValueForScreenType(
                      context: context,
                      mobile: 12,
                      tablet: 11,
                      desktop: Constants.width * 0.015,
                    ),
                    color: AppColors.maroon,
                  ),
                ],
              ),
            ],
          ),
        ),
        getValueForScreenType(
          context: context,
          mobile: kDim.kGap10,
          tablet: kDim.kGap10,
          desktop: kDim.kGap15,
        ),
      ],
    );
  }

// ------------------commonSize------------------

  double commonSize(BuildContext context) {
    return getValueForScreenType(
      context: context,
      mobile: 8,
      tablet: 8,
      desktop: Constants.width <= 1050 ? 11 : 13,
    );
  }

//-----------------contentBody-------------------
  Row _contentBody(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        KStyles().bold(
          text: StringConst.costSimulator,
          size: getValueForScreenType(
            context: context,
            mobile: 10,
            tablet: 20,
            desktop: 25,
          ),
          color: AppColors.headingTextBlue,
        ),
      ],
    );
  }
}

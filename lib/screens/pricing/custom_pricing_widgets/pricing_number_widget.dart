import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../gen/assets.gen.dart';
import '../../../routes/routes_constants.dart';
import '../../../styles/text_styles.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/row_width.dart';
import 'pricing_menu_children.widget.dart';

class PricingNumberWidget extends StatelessWidget {
  ///PricingNumberWidget: is the values of each row data in pricing sheet
  PricingNumberWidget({
    this.number,
    this.isReviewList,
    this.componentName,
    this.heading,
    this.subTitle,
    this.isPercent,
    super.key,
    this.blueEditNumber = false,
    this.textColor,
    this.editTextColor,
    required this.total,
    required this.totalPercent,
  });
  final bool blueEditNumber;
  final String? componentName;
  final bool total;
  final bool? totalPercent;
  final bool? isReviewList;
  final String? number;
  final String? heading;
  final String? subTitle;
  final Color? textColor;
  final bool? isPercent;
  final Color? editTextColor;
  final MenuController? menuCtrl = MenuController();

  @override
  Widget build(BuildContext context) {
    return blueEditNumber
        ? Expanded(
            child: RowWidth(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: KStyles().semiBold(
                      overflow: TextOverflow.visible,
                      text: number ?? '',
                      size: getValueForScreenType(
                        context: context,
                        mobile: 8,
                        tablet: 11,
                        desktop: 13,
                      ),
                      color: editTextColor ?? AppColors.headingTextBlue,
                    ),
                  ),
                  getValueForScreenType(
                    context: context,
                    mobile: 1.width,
                    tablet: 3.width,
                    desktop: 3.width,
                  ),
                  BlocConsumer<PricingBloc, PricingState>(
                    listener: (context, state) {
                      if (state.isDataLoadedAfterChange ?? false) {
                        if (menuCtrl?.isOpen ?? false) {
                          // menuCtrl?.close();
                        }
                      }
                    },
                    builder: (BuildContext context, PricingState state) {
                      return MenuAnchor(
                        onClose: () {
                          context.read<PricingBloc>().add(
                              const ShowCostOfGoods(showCostOfGoods: false));
                        },
                        controller: menuCtrl,
                        alignmentOffset: Offset(
                          getValueForScreenType(
                            context: context,
                            mobile: -100,
                            tablet: -52,
                            desktop: -126,
                          ),
                          0,
                        ),
                        menuChildren: [
                          PricingMenuChildren(
                            isPercent: isPercent,
                            sliderSubTitle: subTitle,
                            menuCtrl: menuCtrl,
                            title: heading,
                            isAnchorEdit: false,
                            saveOnPressed: (String value) async {
                              context.read<PricingBloc>().add(
                                    UpdateFieldEvent(
                                      updateValue: fCon.removeComma(value),
                                      updateFieldName: componentName,
                                    ),
                                  );
                            },
                            number: number,
                          ),
                        ],
                        child: InkWell(
                          onTap: () {
                            context.goNamed(RouteConstants.name.stepTwo,
                                queryParameters: {
                                  "id": state.simId,
                                });
                            //TODO: commented for future use
                            //?note: this method is used for updating value
                            // if (menuCtrl?.isOpen ?? false) {
                            //   context.read<PricingBloc>().add(
                            //         const UpdateFieldOnChangeEvent(
                            //           showCostOfGoods: false,
                            //           isSaveError: false,
                            //           updateValue: '',
                            //           isDataLoadedAfterChange: true,
                            //         ),
                            //       );

                            //   menuCtrl?.close();
                            // } else {
                            //   menuCtrl?.open();
                            //   context.read<PricingBloc>().add(
                            //         UpdateFieldOnChangeEvent(
                            //           isSaveError: false,
                            //           showCostOfGoods: true,
                            //           updateValue: number,
                            //           isDataLoadedAfterChange: false,
                            //         ),
                            //       );
                            // }
                          },
                          child: uiCon.svgIcon(
                            ht: getValueForScreenType(
                              context: context,
                              mobile: 8,
                              tablet: 11,
                              desktop: 12,
                            ),
                            wd: getValueForScreenType(
                              context: context,
                              mobile: 8,
                              tablet: 11,
                              desktop: 12,
                            ),
                            assetImage: Assets.icons.edit,
                            color: AppColors.headingTextBlue,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        : total
            ? totalPercent == true
                ? Expanded(
                    child: RowWidth(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          (isReviewList ?? false)
                              ? KStyles().semiBold(
                                  overflow: TextOverflow.visible,
                                  text: '$number%',
                                  color: textColor ?? AppColors.maroon,
                                  size: getValueForScreenType(
                                    context: context,
                                    mobile: 8,
                                    tablet: 11,
                                    desktop: 13,
                                  ),
                                )
                              : KStyles().reg(
                                  overflow: TextOverflow.visible,
                                  text: '$number%',
                                  color: textColor ?? AppColors.maroon,
                                  size: getValueForScreenType(
                                    context: context,
                                    mobile: 8,
                                    tablet: 11,
                                    desktop: 13,
                                  ),
                                ),
                          getValueForScreenType(
                            context: context,
                            mobile: 8.width,
                            tablet: 13.width,
                            desktop: 13.width,
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: RowWidth(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: (isReviewList ?? false)
                                ? KStyles().semiBold(
                                    overflow: TextOverflow.visible,
                                    text: number ?? '',
                                    color: textColor ?? AppColors.maroon,
                                    size: getValueForScreenType(
                                      context: context,
                                      mobile: 8,
                                      tablet: 11,
                                      desktop: 13,
                                    ),
                                  )
                                : KStyles().reg(
                                    overflow: TextOverflow.visible,
                                    text: number ?? '',
                                    color: textColor ?? AppColors.maroon,
                                    size: getValueForScreenType(
                                      context: context,
                                      mobile: 8,
                                      tablet: 11,
                                      desktop: 13,
                                    ),
                                  ),
                          ),
                          getValueForScreenType(
                            context: context,
                            mobile: 8.width,
                            tablet: 13.width,
                            desktop: 13.width,
                          ),
                        ],
                      ),
                    ),
                  )
            : Expanded(
                child: RowWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: (isReviewList ?? false)
                            ? KStyles().semiBold(
                                overflow: TextOverflow.visible,
                                text: number ?? '',
                                color: textColor ?? AppColors.black,
                                size: getValueForScreenType(
                                  context: context,
                                  mobile: 8,
                                  tablet: 11,
                                  desktop: 13,
                                ),
                              )
                            : KStyles().med(
                                overflow: TextOverflow.visible,
                                text: number ?? '',
                                color: textColor ?? AppColors.black,
                                size: getValueForScreenType(
                                  context: context,
                                  mobile: 8,
                                  tablet: 11,
                                  desktop: 13,
                                ),
                              ),
                      ),
                      getValueForScreenType(
                        context: context,
                        mobile: 8.width,
                        tablet: 13.width,
                        desktop: 13.width,
                      ),
                    ],
                  ),
                ),
              );
  }
}

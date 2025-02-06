import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/step_one_bloc/step_one_bloc.dart';
import '../../../config/config.dart';
import '../../../data/model/currency_list.model.dart';
import '../../../gen/assets.gen.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/enums.dart';
import '../../../utils/global_extensions.dart';
import '../../../utils/string_const.dart';
import '../../../widgets/custom_box_title.dart';
import '../../../widgets/custom_input_formatter.dart';
import '../../../widgets/custom_text_field_label.dart';
import '../../../widgets/line_chart.dart';
import '../../../widgets/post_frame_callback.dart';
import '../../../widgets/shimmer.widget.dart';

class ProvideDeliveryInformationBox extends StatelessWidget {
  const ProvideDeliveryInformationBox({super.key});

  @override
  Widget build(BuildContext context) {
    MenuController deliverymenuCtrl = MenuController();
    final TextEditingController plannedExchangeRateCtrl =
        TextEditingController();
    final TextEditingController deliveryCommentCtrl = TextEditingController();
    void addPostFrameCallback() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final state = context.read<StepOneBloc>().state;
        updateTextController(
          plannedExchangeRateCtrl,
          formatWithThousandSeparator(
            state.plannedExchangeRate,
          ),
        );
        updateTextController(
          deliveryCommentCtrl,
          state.plannedExchangeRateComment,
        );
      });
    }

    return BlocConsumer<StepOneBloc, StepOneState>(
      listener: (context, state) {
        // addPostFrameCallback();
      },
      builder: (context, state) {
        addPostFrameCallback();
        if (state.loadingStatus == LoadingStatus.loading) {
          return const ShimmerLoader(type: ShimmerType.box);
        }
        return CustomBoxTitle(
          cmntBox: true,
          commentCtrl: deliveryCommentCtrl,
          menuCtrl: deliverymenuCtrl,
          comment: state.plannedExchangeRateComment ?? '',
          messageOnSaved: (String? value) {
            context.read<StepOneBloc>().add(
                  ProvideDeliveryInfoUpdate(
                    plannedExchangeRateComment: value,
                  ),
                );
          },
          color: AppColors.boxBackGroundOrange,
          title: StringConst.provideDeliveryInfo,
          imagePath: Assets.images.deliveryInfo.path,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //!-----------------entity Sell US Currency Dropdown-------------------
              CustomTextFieldLabel<Currency>(
                displayText: (Currency? item) {
                  return item?.currencyCode;
                },
                value: (Currency? item) {
                  return item?.currencyCode;
                },
                dropDownValidator: (Currency? value) {
                  return fCon.commonValidation(
                    inputValue: value?.currencyCode ?? "",
                    errorMsg: StringConst.pleaseSelectYourJvlSell,
                  );
                },
                dropDownHintText: StringConst.selectTheCurrency,
                dropDownValue: state.sellCurrency,
                onDropDownChanged: (
                  Currency? sellCurrency,
                ) {
                  context.read<StepOneBloc>().add(
                        ProvideDeliveryInfoUpdate(
                          sellCurrency: sellCurrency,
                        ),
                      );
                },
                itemList: state.dropDownJvlCurrencyList,
                text: StringConst.entitySellCurrency,
                dropDown: true,
              ),

              10.height,
              // //!-----------------Retail Sell Currency to Consumer Dropdown-------------------
              CustomTextFieldLabel<Currency>(
                displayText: (Currency? item) {
                  return item?.currencyCode;
                },
                value: (Currency? item) {
                  return item?.currencyCode;
                },
                dropDownValidator: (Currency? value) {
                  return fCon.commonValidation(
                    inputValue: value?.currencyCode ?? "",
                    errorMsg: StringConst.pleaseSelectYourSellCurrency,
                  );
                },
                dropDownHintText: StringConst.selectTheCurrency,
                dropDownValue: state.consumerCurrency,
                onDropDownChanged: (
                  Currency? consumerCurrency,
                ) {
                  context.read<StepOneBloc>().add(
                        ProvideDeliveryInfoUpdate(
                          consumerCurrency: consumerCurrency,
                        ),
                      );
                },
                itemList: state.dropDownSellCurrencyToConsumerList,
                text: StringConst.retailSellCurrency,
                dropDown: true,
              ),
              10.height,
              //!-----------------Planned Exchange Rate-------------------
              CustomTextFieldLabel(
                //commentCtrl: plannedExchangeCommentCtrl,
                comment: state.plannedExchangeRateComment ?? '',
                // messageOnSaved: (String? value) {
                //   context.read<StepOneBloc>().add(
                //         ProvideDeliveryInfoUpdate(
                //           plannedExchangeRateComment: value,
                //         ),
                //       );
                // },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                  // FilteringTextInputFormatter.allow(
                  //   RegExp(r'^\d*\.?\d{0,2}'),
                  // ),
                ],
                controller: plannedExchangeRateCtrl,
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                hintText: StringConst.hintExchRate,
                onChanged: (String plannedExchangeRate) {
                  context.read<StepOneBloc>().add(
                        ProvideDeliveryInfoUpdate(
                          plannedExchangeRate:
                              fCon.removeComma(plannedExchangeRate),
                        ),
                      );
                },
                // menuCtrl: pExRateCtrl,
                //TODO  /:comment message box
                message: false,
                text:
                    '${StringConst.plannedExchangeRate}${state.consumerCurrency?.currencyCode ?? 'Foreign Curr'})',
              ),
              10.height,
              //TODO: commented for future use
              // _boxWithLineChart(context),
              // 10.height,
            ],
          ),
        );
      },
    );
  }

  BlocBuilder<StepOneBloc, StepOneState> _boxWithLineChart(context) {
    return BlocBuilder<StepOneBloc, StepOneState>(
      builder: (context, state) {
        return (state.fxLineResp?.data?.first.current?.isNotEmpty ?? false)
            ? Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                  right: 20,
                  top: 20,
                  bottom: 20,
                  left: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: kDim.kRadius02,
                  color: AppColors.boxBackGround,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _pastMonthsSubTitle(context, state),
                    Expanded(
                      // flex: 2,
                      //!----------LineChartSection----------------
                      child: LineChartSection(
                        bottomData: fCon.getLastSixValues<String>(
                          //?note: list is sub listed to length of 6
                          fCon.extractMonths(
                              state.fxLineResp?.overviews?.first.xAxis?.label ??
                                  []),
                        ),
                        data: fCon.getLastSixValues<double>(
                          //?note: list is sub listed to length of 6
                          state.fxLineResp?.data?.first.current ?? [],
                        ),
                      ),
                    ),
                    kDim.kGap05,
                  ],
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }

//!----------------pastMonthsSubTitle----------------
  Expanded _pastMonthsSubTitle(BuildContext context, StepOneState state) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KStyles().bold(
            overflow: TextOverflow.visible,
            text: state.fxLineResp?.overviews?.firstOrNull?.title ?? "",
            size: getValueForScreenType(
              context: context,
              mobile: 7,
              tablet: 9,
              desktop: 13,
            ),
            color: AppColors.headingTextBlue,
          ),
          KStyles().bold(
            text:
                '${StringConst.usdForeignStepOneText}${state.consumerCurrency?.currencyCode ?? 'Foreign Curr'})',
            color: AppColors.maroon,
            size: getValueForScreenType(
              context: context,
              mobile: 7,
              tablet: 9,
              desktop: 11,
            ),
          ),
        ],
      ),
    );
  }
}

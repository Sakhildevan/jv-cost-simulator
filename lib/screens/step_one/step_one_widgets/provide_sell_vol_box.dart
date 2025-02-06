import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/screens/step_one/step_one_widgets/custom_selection_box.widget.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:johnsonville_cost_simulator/themes/app_colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/step_one_bloc/step_one_bloc.dart';
import '../../../config/config.dart';
import '../../../data/model/delivery_to_resp.model.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/enums.dart';
import '../../../utils/global_extensions.dart';
import '../../../utils/string_const.dart';
import '../../../widgets/custom_box_title.dart';
import '../../../widgets/custom_input_formatter.dart';
import '../../../widgets/custom_text_field_label.dart';
import '../../../widgets/post_frame_callback.dart';

class ProvideSellVolBox extends StatelessWidget {
  const ProvideSellVolBox({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController sellVolCtrl = TextEditingController();
    final TextEditingController sellVolCommentCtrl = TextEditingController();
    void addPostFrameCallback() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final state = context.read<StepOneBloc>().state;

        updateTextController(
            sellVolCtrl, formatWithThousandSeparator(state.sellVolume));
        updateTextController(sellVolCommentCtrl, state.estSellVolComment);
      });
    }

    MenuController sellMenuCtrl = MenuController();

    //*-------------BlocBuilder for provide sell vol box----------------
    return BlocConsumer<StepOneBloc, StepOneState>(
      listener: (context, state) {},
      builder: (context, state) {
        addPostFrameCallback();
        if (state.loadingStatus == LoadingStatus.loading) {
          return uiCon.shimmerLoader(
            type: ShimmerType.box,
          );
        }

        return CustomBoxTitle(
          cmntBox: true,
          commentCtrl: sellVolCommentCtrl,
          menuCtrl: sellMenuCtrl,
          comment: state.estSellVolComment ?? '',
          messageOnSaved: (String? message) {
            context.read<StepOneBloc>().add(
                  ProvideSellVolumeUpdateValue(
                    estSellVolComment: message,
                  ),
                );
          },
          title: StringConst.provideSellVol,
          imagePath: Assets.images.provideSellVol.path,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //*-----------------metric selector-------------------
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
                dropDownValue: state.sellVolumeUnit ?? "",
                text: StringConst.unitOfMeasure,
                itemList: state.unitMeasureList,
                dropDown: true,
                onDropDownChanged: (
                  String? sellVolumeUnit,
                ) {
                  context.read<StepOneBloc>().add(
                        ProvideSellVolumeUpdateValue(
                          sellVolumeUnit: sellVolumeUnit,
                        ),
                      );
                },
              ),
              // _metricSelectorWidget(
              //   context,
              //   state,
              // ),
              10.height,
              //*-----------------estimated sell volume textfield-------------------
              CustomTextFieldLabel(
                // menuCtrl: estSellCtrl,
                //commentCtrl: sellVolCommentCtrl,
                // messageOnSaved: (String? message) {
                //   context.read<StepOneBloc>().add(
                //         ProvideSellVolumeUpdateValue(
                //           estSellVolComment: message,
                //         ),
                //       );
                // },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormat: <TextInputFormatter>[
                  DecimalFormatter(decimalDigits: 2),
                ],
                controller: sellVolCtrl,
                commonValidator: (String? value) {
                  return fCon.commonValidation(
                    inputValue: value ?? "",
                    errorMsg: StringConst.enterValueError,
                  );
                },
                hintText: StringConst.hintSellVol,
                onChanged: (String sellVolume) {
                  context.read<StepOneBloc>().add(
                        ProvideSellVolumeUpdateValue(
                          sellVolume: fCon.removeComma(sellVolume),
                        ),
                      );
                },
                //TODO  /:comment message box
                message: false,
                comment: state.estSellVolComment ?? '',
                text: StringConst.estimatedSellVol,
              ),
              10.height,
              //*-----------------delivered to dropdown-------------------
              CustomTextFieldLabel<DeliveryCountry>(
                // showPrefixToolTip: true,
                // prefixToolTipText: StringConst.eachlocation,
                displayText: (DeliveryCountry? item) {
                  return item?.deliveryCountryName;
                },
                value: (DeliveryCountry? item) {
                  return item?.deliveryCountryId;
                },
                dropDownValidator: (DeliveryCountry? value) {
                  return fCon.commonValidation(
                    inputValue: value?.deliveryCountryId ?? "",
                    errorMsg: StringConst.pleaseSelectYourDelivery,
                  );
                },
                dropDownHintText: StringConst.selectLocation,
                dropDownValue: state.deliveredTo,
                itemList: state.dropDownDeliverToList,
                onDropDownChanged: (DeliveryCountry? deliveredTo) {
                  context.read<StepOneBloc>().add(
                        ProvideSellVolumeUpdateValue(
                          deliveredTo: deliveredTo,
                        ),
                      );
                },
                text: StringConst.deliveredToText,
                dropDown: true,
              ),
              10.height,
            ],
          ),
        );
      },
    );
  }

  Column _metricSelectorWidget(
    BuildContext context,
    StepOneState state,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: KStyles().reg(
                size: fontCon.boxLabelFontSize(context),
                overflow: TextOverflow.visible,
                text: StringConst.metricsSelector,
                color: AppColors.black,
              ),
            ),
            5.width,
            Expanded(
              flex: 2,
              child: CustomSelectionRow(
                isMetricEmpty: state.isMetricsSelected == false &&
                    (state.packUom ?? '').isEmpty,
                firstOption: StringConst.kg,
                secondOption: StringConst.lb,
                onTap: (String sellVolumeUnit) {
                  context.read<StepOneBloc>().add(
                        ProvideSellVolumeUpdateValue(
                          sellVolumeUnit: sellVolumeUnit,
                        ),
                      );
                },
                selectedOption: state.sellVolumeUnit ?? "",
              ),
            ),
          ],
        ),
        if (state.isMetricsSelected == false &&
            (state.sellVolumeUnit ?? '').isEmpty)
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(
                  width: 1,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: KStyles().reg(
                    size: getValueForScreenType(
                      context: context,
                      mobile: 10,
                      tablet: 10,
                      desktop: 12,
                    ),
                    overflow: TextOverflow.visible,
                    text: StringConst.pleaseSelectAMetricUnit,
                    color: AppColors.maroon,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

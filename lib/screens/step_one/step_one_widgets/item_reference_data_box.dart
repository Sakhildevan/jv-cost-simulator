import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/step_one_bloc/step_one_bloc.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:johnsonville_cost_simulator/utils/enums.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../constants/unit_convertor.dart';
import '../../../data/model/converted_value.model.dart';
import '../../../gen/assets.gen.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/global_extensions.dart';
import '../../../utils/string_const.dart';
import '../../../widgets/custom_box_title.dart';
import '../../../widgets/shimmer.widget.dart';

class ItemReferenceDataBox extends StatelessWidget {
  const ItemReferenceDataBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StepOneBloc, StepOneState>(
      builder: (context, state) {
        if (state.loadingStatus == LoadingStatus.loading) {
          return const ShimmerLoader(type: ShimmerType.box);
        }
        return CustomBoxTitle(
          color: AppColors.boxBackGroundBlue,
          title: StringConst.itemReferenceData,
          subTitle: true,
          subTitleText: StringConst.computedBasedOnYourInput,
          imagePath: Assets.images.referenceData.path,
          child: _contentBody(context),
        );
      },
    );
  }

  Widget _contentBody(BuildContext context) {
    return BlocBuilder<StepOneBloc, StepOneState>(
      builder: (context, state) {
        //pack size
        double packSize = double.tryParse(
              state.packSize ?? "0",
            ) ??
            0;
        MetricType type = state.packUom == StringConst.ounce
            ? MetricType.ounces
            : state.packUom == StringConst.gms
                ? MetricType.grams
                : MetricType.none;
        //link per kg
        double linksPerPkg = double.tryParse(
              state.linksPerPack ?? "0",
            ) ??
            0;
        // pack per case
        double packsPerCase = double.tryParse(
              state.packsPerCase ?? "0",
            ) ??
            0;

        ConvertedValues packSizeValues = UnitConverter.convertPackSize(
          packSize,
          type,
        );
        ConvertedValues linksValues = UnitConverter.convertLinks(
          packSize / linksPerPkg,
          type,
        );
        ConvertedValues caseValues = UnitConverter.convertPackPerCase(
          packSize * packsPerCase,
          type,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            _headersInBlue(context),
            5.height,
            _dataRow(
              context,
              label: StringConst.forEveryPack,
              gms: (state.packSize?.isNotEmpty ?? false)
                  ? ((fCon
                          .formatWithThousandSeparator(
                              packSizeValues.grams?.toStringAsFixed(3) ?? "")
                          .isNotEmpty)
                      ? fCon.formatWithThousandSeparator(
                          packSizeValues.grams?.toStringAsFixed(3) ?? "")
                      : "-")
                  : "-",
              kg: (state.packSize?.isNotEmpty ?? false)
                  ? ((fCon
                          .formatWithThousandSeparator(
                              packSizeValues.kilograms?.toStringAsFixed(3) ??
                                  "")
                          .isNotEmpty)
                      ? fCon.formatWithThousandSeparator(
                          packSizeValues.kilograms?.toStringAsFixed(3) ?? "")
                      : "-")
                  : "-",
              ounces: (state.packSize?.isNotEmpty ?? false)
                  ? ((fCon
                          .formatWithThousandSeparator(
                              packSizeValues.ounces?.toStringAsFixed(3) ?? "")
                          .isNotEmpty)
                      ? (fCon.formatWithThousandSeparator(
                          packSizeValues.ounces?.toStringAsFixed(3) ?? ""))
                      : "-")
                  : "-",
              lbs: (state.packSize?.isNotEmpty ?? false)
                  ? (fCon
                          .formatWithThousandSeparator(
                              packSizeValues.pounds?.toStringAsFixed(3) ?? "")
                          .isNotEmpty)
                      ? (fCon.formatWithThousandSeparator(
                          packSizeValues.pounds?.toStringAsFixed(3) ?? ""))
                      : "-"
                  : '-',
            ),
            5.height,
            _dataRow(
              context,
              label: StringConst.forEveryUnit,
              gms: (state.linksPerPack?.isNotEmpty ?? false)
                  ? (fCon.formatWithThousandSeparator(
                      linksValues.grams?.toStringAsFixed(3) ?? ""))
                  : "-",
              kg: (state.linksPerPack?.isNotEmpty ?? false)
                  ? (fCon.formatWithThousandSeparator(
                      linksValues.kilograms?.toStringAsFixed(3) ?? ""))
                  : '-',
              ounces: (state.linksPerPack?.isNotEmpty ?? false)
                  ? (fCon.formatWithThousandSeparator(
                      linksValues.ounces?.toStringAsFixed(3) ?? ""))
                  : '-',
              lbs: (state.linksPerPack?.isNotEmpty ?? false)
                  ? (fCon.formatWithThousandSeparator(
                      linksValues.pounds?.toStringAsFixed(3) ?? ""))
                  : '-',
            ),
            5.height,
            _dataRow(
              context,
              label: StringConst.forEveryCase,
              gms: (state.packsPerCase?.isNotEmpty ?? false)
                  ? (fCon.formatWithThousandSeparator(
                      caseValues.grams?.toStringAsFixed(3) ?? ""))
                  : '-',
              kg: (state.packsPerCase?.isNotEmpty ?? false)
                  ? (fCon.formatWithThousandSeparator(
                      caseValues.kilograms?.toStringAsFixed(3) ?? ""))
                  : '-',
              ounces: (state.packsPerCase?.isNotEmpty ?? false)
                  ? (fCon.formatWithThousandSeparator(
                      caseValues.ounces?.toStringAsFixed(3) ?? ""))
                  : '-',
              lbs: (state.packsPerCase?.isNotEmpty ?? false)
                  ? (fCon.formatWithThousandSeparator(
                      caseValues.pounds?.toStringAsFixed(3) ?? ""))
                  : '-',
            ),
            5.height,
          ],
        );
      },
    );
  }

  Widget _headersInBlue(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: _labelText(
            context,
            text: StringConst.unitOfMeasure,
            textColor: AppColors.headingTextBlue,
            fontWeight: FontWeight.w600,
            size: getValueForScreenType(
              context: context,
              mobile: 10,
              tablet: 12,
              desktop: 14,
            ),
          ),
        ),
        15.width,
        _metricData(context),
        15.width,
        _usData(context),
      ],
    );
  }

  Expanded _usData(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          _labelText(
            context,
            text: StringConst.us,
            textColor: AppColors.headingTextBlue,
            fontWeight: FontWeight.w800,
          ),
          Row(
            children: [
              Expanded(
                  child: _headerText(
                context,
                text: StringConst.oz.toUpperCase(),
              )),
              3.width,
              Expanded(
                  child: _headerText(
                context,
                text: StringConst.lbs,
              )),
            ],
          ),
        ],
      ),
    );
  }

  Expanded _metricData(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          _labelText(
            context,
            text: StringConst.metric,
            textColor: AppColors.headingTextBlue,
            fontWeight: FontWeight.w800,
          ),
          Row(
            children: [
              Expanded(child: _headerText(context, text: StringConst.gms)),
              3.width,
              Expanded(child: _headerText(context, text: StringConst.kg)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dataRow(
    BuildContext context, {
    required String label,
    required String gms,
    required String kg,
    required String ounces,
    required String lbs,
  }) {
    return Row(
      children: [
        Expanded(child: _labelText(context, text: label)),
        15.width,
        Expanded(child: _dataCell(context, gms)),
        3.width,
        Expanded(child: _dataCell(context, kg)),
        15.width,
        Expanded(child: _dataCell(context, ounces)),
        3.width,
        Expanded(child: _dataCell(context, lbs)),
      ],
    );
  }

  Widget _headerText(
    BuildContext context, {
    String? text,
  }) {
    return Container(
      height: 25,
      color: AppColors.headingTextBlue,
      child: Center(
        child: KStyles().reg(
          text: text ?? '',
          size: getValueForScreenType(
              context: context, mobile: 8, tablet: 10, desktop: 12),
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _labelText(
    BuildContext context, {
    required String text,
    Color? textColor,
    FontWeight? fontWeight,
    double? size,
  }) {
    return KStyles().reg(
      text: text,
      size: size ??
          getValueForScreenType(
            context: context,
            mobile: 10,
            tablet: 12,
            desktop: 14,
          ),
      color: textColor ?? AppColors.black,
      overflow: TextOverflow.visible,
    );
  }

  Widget _dataCell(
    BuildContext context,
    String text,
  ) {
    return Container(
      alignment: Alignment.center,
      height: 25,
      color: AppColors.boxBackGround,
      child: KStyles().med(
        text: text,
        size: getValueForScreenType(
          context: context,
          mobile: 10,
          tablet: 11,
          desktop: 12,
        ),
      ),
    );
  }
}

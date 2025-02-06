import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../themes/app_colors.dart';

class LineChartSection extends StatelessWidget {
  const LineChartSection({
    super.key,
    required this.data,
    required this.bottomData,
  });
  final List<num>? data;
  final List<String> bottomData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 150,
        height: 60,
        child: LineChart(
          LineChartData(
            lineBarsData: [
              _mainData(),
            ],
            titlesData: buildTitleData(context),
            borderData: _buildBorderData(),
            gridData: _buildGridData(),
            lineTouchData: _buildLineTouchData(context),
          ),
        ));
  }

  LineTouchData _buildLineTouchData(
    BuildContext context,
  ) {
    return LineTouchData(
      touchCallback: (
        FlTouchEvent val,
        LineTouchResponse? touchResponse,
      ) {},
      mouseCursorResolver: (
        FlTouchEvent event,
        LineTouchResponse? response,
      ) {
        if (response == null || response.lineBarSpots == null) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      },
      handleBuiltInTouches: true,
      getTouchedSpotIndicator: (
        LineChartBarData barData,
        List<int> spotIndexes,
      ) {
        return spotIndexes.map((
          int spotIndex,
        ) {
          //? note: dot color will provide the color for flDotCirclePainter
          Color dotColor = barData.gradient?.colors[0] ?? AppColors.maroon;
          return TouchedSpotIndicatorData(
            const FlLine(
              color: AppColors.transparent,
              strokeWidth: 10,
            ),
            FlDotData(
              getDotPainter: (
                FlSpot p0,
                double p1,
                LineChartBarData p2,
                int p3,
              ) {
                return FlDotCirclePainter(
                  strokeColor: dotColor.withOpacity(0.2),
                  strokeWidth: 3.5,
                  radius: 6,
                  color: dotColor,
                );
              },
              show: true,
            ),
          );
        }).toList();
      },
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipRoundedRadius: 0,
        tooltipHorizontalOffset: 15,
        getTooltipColor: (
          LineBarSpot touchedSpot,
        ) =>
            AppColors.white.withOpacity(0.8),
        tooltipPadding: const EdgeInsets.all(5),
        tooltipMargin: 10,
        getTooltipItems: (
          List<LineBarSpot> touchedBarSpots,
        ) {
          return touchedBarSpots.map((
            LineBarSpot barSpot,
          ) {
            final LineBarSpot flSpot = barSpot;
            String formattedValue = flSpot.y.toStringAsFixed(3);
            return buildLineTooltipItem(
              formattedValue,
              flSpot,
              context,
            );
          }).toList();
        },
      ),
      // minX: 0,
      // maxX: 4,
      // minY: 1.31,
      // maxY: 1.35,
    );
  }

  FlGridData _buildGridData() {
    return const FlGridData(
      show: false,
    );
  }

  FlBorderData _buildBorderData() {
    return FlBorderData(
      show: false,
    );
  }

  //bottom title widget
  Widget _bottomTitle(
    TitleMeta meta,
    Widget text,
    double angle,
  ) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: angle,
      space: 10,
      child: text,
    );
  }

  FlTitlesData buildTitleData(BuildContext context) {
    return FlTitlesData(
      leftTitles: commonAxisTitle(),
      bottomTitles: getBottomTile(context),
      rightTitles: commonAxisTitle(),
      topTitles: commonAxisTitle(),
    );
  }

  AxisTitles commonAxisTitle() {
    return const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    );
  }

  AxisTitles getBottomTile(BuildContext context) {
    return AxisTitles(
        sideTitles: SideTitles(
      reservedSize: getValueForScreenType(
        context: context,
        mobile: 30,
        tablet: 30,
        desktop: 30,
      ),
      showTitles: true,
      getTitlesWidget: (value, meta) {
        return ResponsiveBuilder(builder: (
          context,
          size,
        ) {
          return _bottomTitle(
              meta,
              KStyles().semiBold(
                size: getValueForScreenType(
                  context: context,
                  mobile: 8,
                  tablet: 10,
                  desktop: 12,
                ),
                color: AppColors.black,
                text: (bottomData.isNotEmpty &&
                        (data?.isNotEmpty ?? false) &&
                        value % 1 == 0)
                    ? bottomData[value.toInt()].toUpperCase()
                    : '',
              ),
              dynamicAngle(size.deviceScreenType));
        });
      },
    ));
  }

  double dynamicAngle(DeviceScreenType type) {
    switch (type) {
      case DeviceScreenType.desktop:
        return 0;
      case DeviceScreenType.tablet:
        return 112;
      case DeviceScreenType.mobile:
        return 112;
      default:
        return 0;
    }
  }

  LineTooltipItem buildLineTooltipItem(
    String formattedValue,
    LineBarSpot flSpot,
    BuildContext context,
  ) {
    return LineTooltipItem(
      data?[flSpot.spotIndex].toStringAsFixed(
            3,
          ) ??
          "0",
      TextStyle(
        fontSize: getValueForScreenType(
          context: context,
          mobile: 11,
          tablet: 12,
          desktop: 11,
        ),
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  LineChartBarData _mainData() {
    return LineChartBarData(
      shadow: Shadow(
        offset: const Offset(0, 2),
        blurRadius: 3,
        color: AppColors.maroon.withOpacity(0.4),
      ),
      color: AppColors.maroon,
      spots: [
        ...List<FlSpot>.generate(
          data?.length ?? 0,
          (int index) => FlSpot(
            index.toDouble(),
            double.tryParse(
                  data?[index].toStringAsFixed(3) ?? "0",
                ) ??
                0,
          ),
        ),
      ],
      isCurved: true,
      dotData: const FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(show: false),
    );
  }
}

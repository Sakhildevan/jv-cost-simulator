import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../bloc/pricing_bloc/pricing_bloc.dart';
import '../themes/app_colors.dart';

//!-----------------CustomSlider----------------
class CustomSlider extends StatelessWidget {
  final double min;
  final double max;
  final int divisions;
  final void Function(double)? onChanged;
  // final String label;
  final double sliderValue;

  const CustomSlider({
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
    // required this.label,
    required this.sliderValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        //!-----------------Slider Theme----------------
        return SliderTheme(
          data: SliderTheme.of(context).copyWith(
            showValueIndicator: ShowValueIndicator.never,
            activeTrackColor: AppColors.maroon,
            inactiveTrackColor: AppColors.grey,
            //!----------thumb shape------------
            thumbShape: CustomSliderThumbCircle(
              thumbRadius: getValueForScreenType(
                context: context,
                mobile: 10,
                tablet: 12,
                desktop: 15,
              ),
              min: min.toInt(),
              max: max.toInt(),
            ),
          ),
          //!-----------------Slider----------------
          child: Slider(
            value: sliderValue,
            onChanged: onChanged,
            min: min,
            max: max,
            divisions: divisions,
            // label: label,
          ),
        );
      },
    );
  }
}

//!-----------------CustomSliderThumbCircle----------------
class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;

  const CustomSliderThumbCircle({
    required this.thumbRadius,
    this.min = 0,
    this.max = 10,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..color = AppColors.maroon
      ..style = PaintingStyle.fill;

    TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: thumbRadius * .6,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      ),
      text: getValue(value),
    );

    TextPainter tp = TextPainter(
        text: span, textAlign: TextAlign.center, textDirection: textDirection);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius * .9, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).toStringAsFixed(2).toString();
  }
}

import 'package:flutter/material.dart';

import '../utils/constants.dart';

class RowWidth extends StatelessWidget {
  /// Add full width to the row and edit the alignment and background color for the child
  const RowWidth({
    super.key,
    this.alignment,
    this.padding,
    this.color,
    this.child,
  });

  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.center,
      padding: padding,
      width: Constants.width,
      color: color,
      child: child,
    );
  }
}

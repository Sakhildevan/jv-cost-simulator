import 'package:flutter/material.dart';

class CustomArrow extends StatelessWidget {
  const CustomArrow(
      {super.key, required this.arrowSize, this.color, this.quarterTurns});
  final double arrowSize;
  final Color? color;
  final int? quarterTurns;
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: quarterTurns ?? 90,
      child: ClipPath(
        clipper: _ArrowClipper(),
        child: Container(
          width: arrowSize,
          height: arrowSize,
          color: color,
        ),
      ),
    );
  }
}

class _ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, size.height / 2);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

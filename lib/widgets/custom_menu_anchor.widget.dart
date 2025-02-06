import 'package:flutter/material.dart';

class CustomMenuAnchor extends StatelessWidget {
  const CustomMenuAnchor({
    super.key,
    required this.menuChildren,
    required this.controller,
    required this.child,
    this.alignmentOffset,
  });
  final List<Widget> menuChildren;
  final MenuController controller;
  final Widget? child;
  final Offset? alignmentOffset;
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: const MenuStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
        backgroundColor: WidgetStateColor.transparent,
        shadowColor: WidgetStateColor.transparent,
      ),
      alignmentOffset: alignmentOffset,
      controller: controller,
      menuChildren: menuChildren,
      child: InkWell(
        onTap: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        child: child,
      ),
    );
  }
}

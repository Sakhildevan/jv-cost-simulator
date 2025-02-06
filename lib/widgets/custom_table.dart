import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'mouse_scroll_behaviour.dart';

class CustomTable extends StatelessWidget {
  const CustomTable({
    super.key,
    required this.tableHeader,
    required this.tableContent,
    required this.scrollController,
  });

  /// The header row of the table.
  final Widget tableHeader;
  final ScrollController scrollController;

  final Widget tableContent;
  @override
  Widget build(BuildContext context) {
    final ScrollController horScrollCtrl = ScrollController();
    return ResponsiveBuilder(builder: (
      BuildContext context,
      SizingInformation size,
    ) {
      return Scrollbar(
        controller: horScrollCtrl,
        thumbVisibility: true,
        child: ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: SingleChildScrollView(
            controller: horScrollCtrl,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 25.0,
              ),
              child: Column(
                children: [
                  IntrinsicHeight(
                    child: Column(
                      children: [
                        tableHeader,
                      ],
                    ),
                  ),
                  Expanded(
                    // height: 100,
                    // color: Colors.red,
                    child: Scrollbar(
                      controller: scrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: tableContent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

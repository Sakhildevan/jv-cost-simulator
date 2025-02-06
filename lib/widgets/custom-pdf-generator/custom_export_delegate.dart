import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomExportDelegate extends ExportDelegate {
  final GlobalKey contentKey;
  // final double scaleFactor;
  // final double cropFactor; // New crop factor to show more content per page

  CustomExportDelegate(
    this.contentKey,
  );

  @override
  // ignore: override_on_non_overriding_member
  Future<Uint8List> captureImages(
      String frameId, SizingInformation sizingInformation,
      {double? pixelRatio,
      double maxWidth = 595,
      double maxHeight = 842}) async {
    // Get the boundary of the widget we want to capture
    RenderRepaintBoundary boundary =
        contentKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    Uint8List pages = Uint8List(0);

    // Capture the image from the widget at a given pixel ratio
    final ui.Image image = await boundary.toImage(pixelRatio: 2);
    final ByteData? fullImageData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    pages = fullImageData!.buffer.asUint8List();

    return pages;
  }
}

// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:johnsonville_cost_simulator/utils/logger_extension';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import 'package:pdf/widgets.dart' as pw;

// // ignore: avoid_web_libraries_in_flutter
// import 'package:universal_html/html.dart' as html;
// import '../gen/assets.gen.dart';
// import '../utils/string_const.dart';
// import '../widgets/custom-pdf-generator/custom_export_delegate.dart';

// class PdfFunctionalConstant {
//   // note: you can call the method as pdfCon.generatePdf()
//   // note: you can call the method as pdfCon.savePdfFile()
//   //*---(generate pdf)

//   Future<void> generatePdf(
//     BuildContext context,
//     CustomExportDelegate exportDelegate,
//     SizingInformation sizingInformation,
//     String itemName,
//     // String simId,
//   ) async {
//     try {
//       // Ensure the widget tree is fully rendered
//       await Future.delayed(const Duration(milliseconds: 100));

//       // Capture multiple images
//       Uint8List pageImages = await exportDelegate.captureImages(
//         StringConst.captureFrameId,
//         sizingInformation,
//         maxHeight: 842, // A4 height in points
//       );
//       if (pageImages.isNotEmpty) {
//         final logo = await rootBundle.load(Assets.images.logo.path);
//         final logoImageBytes = logo.buffer.asUint8List();
//         // Create an image from the asset bytes
//         final logoImage = pw.MemoryImage(logoImageBytes);
//         // Create a PDF document
//         final pdf = pw.Document();

//         // Add each image as a separate page
//         // for (int i = 0; i < pageImages.length; i++) {
//         final image = pw.MemoryImage(pageImages);
//         pdf.addPage(
//           pw.Page(
//             pageFormat: PdfPageFormat.a4.landscape,
//             margin: pw.EdgeInsets.zero,
//             build: (pw.Context context) {
//               return pw.Container(
//                 width: PdfPageFormat.a4.landscape.width,
//                 height: PdfPageFormat.a4.landscape.height,
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   children: [
//                     pw.Container(
//                       width: PdfPageFormat.a4.landscape.width,
//                       margin: const pw.EdgeInsets.only(bottom: 10),
//                       padding: const pw.EdgeInsets.symmetric(
//                         horizontal: 15,
//                         vertical: 8,
//                       ),
//                       child: pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         children: [
//                           pw.Image(
//                             logoImage,
//                             height: 40,
//                           ),
//                         ],
//                       ),
//                     ),
//                     pw.Expanded(
//                       child: pw.Align(
//                         alignment: pw.Alignment.topCenter,
//                         child: pw.Image(
//                           image,
//                           width: PdfPageFormat.a4.landscape.width,
//                           fit: pw.BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//         // }

//         // Get the PDF as bytes
//         final Uint8List pdfBytes = await pdf.save();

//         // Save or download the file
//         await savePdfFile(
//           pdfBytes,
//           '${itemName}_PricingSheet.pdf',
//           sizingInformation,
//         );
//       } else {
//         throw StringConst.somethingWentWrong;
//       }
//     } catch (e) {
//       'Error generating PDF: $e'.logError();
//       throw e.toString();
//     }
//   }

//   //*---(Save pdf)

//   Future<void> savePdfFile(Uint8List pdfBytes, String name,
//       SizingInformation sizingInformation) async {
//     if (kIsWeb) {
//       // Web platform
//       final blob = html.Blob([pdfBytes]);
//       final url = html.Url.createObjectUrlFromBlob(blob);
//       // final anchor =
//       html.AnchorElement(href: url)
//         ..setAttribute("download", name)
//         ..click();

//       // Clean up
//       html.Url.revokeObjectUrl(url);
//     } else {
//       // Mobile or desktop platforms
//       final Directory dir = await getTemporaryDirectory();
//       final String savePath = '${dir.path}/$name';
//       final File file = File('${dir.path}/$name');
//       await file
//           .writeAsBytes(pdfBytes); // Optionally, open the file after download
//       savePath.logInfo();
//       OpenFile.open(savePath);
//       debugPrint('Saved exported PDF at: ${file.path}');
//     }
//   }
// }

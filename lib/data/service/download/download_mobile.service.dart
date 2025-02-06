// download_service_mobile.dart
import 'package:dio/dio.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';
import 'package:path_provider/path_provider.dart'; // For mobile file path
import 'package:open_file/open_file.dart'; // For opening the file after download

class DownloadService {
  final Dio _dio = Dio();

  Future<void> downloadFile({
    required String worksheetUrl,
  }) async {
    try {
      // Get the temporary directory to save the file
      final dir = await getTemporaryDirectory();
      final String savePath = '${dir.path}/pricing_worksheet.xlsx';

      // Download the file using Dio
      await _dio.download(worksheetUrl, savePath);

      // Optionally, open the file after download
      OpenFile.open(savePath);
    } catch (e) {
      "Download failed: $e".logError();
    }
  }
}

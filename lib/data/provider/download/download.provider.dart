import 'package:johnsonville_cost_simulator/data/service/download/download.service.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';

class DownloadProvider {
  final DownloadService service = autoInjector.get<DownloadService>();
  Future<void> downloadFile({
    required String worksheetUrl,
    required bool isPdf,
  }) async {
    try {
      await service.downloadFile(
        worksheetUrl: worksheetUrl,
        isPdf: isPdf,
      );
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

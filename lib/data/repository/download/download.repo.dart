import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../provider/download/download.provider.dart';

class DownloadRepo {
  final DownloadProvider service = autoInjector.get<DownloadProvider>();
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

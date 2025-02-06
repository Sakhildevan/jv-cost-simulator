// download_service_web.dart
import 'dart:html' as html; // Import web-specific library

class DownloadService {
  Future<void> downloadFile({
    required String worksheetUrl,
    required bool isPdf,
  }) async {
    // Web: Use AnchorElement to trigger the download
    html.AnchorElement anchorElement = html.AnchorElement(href: worksheetUrl);
    if (isPdf) {
      anchorElement.target = '_blank';
    }
    anchorElement.download = worksheetUrl;
    anchorElement.click();
  }
}

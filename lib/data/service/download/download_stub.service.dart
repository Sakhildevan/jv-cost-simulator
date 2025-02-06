class DownloadService {
  Future<void> downloadFile({
    required String worksheetUrl,
    required bool isPdf,
  }) async {
    throw UnsupportedError('Download is not supported on this platform.');
  }
}

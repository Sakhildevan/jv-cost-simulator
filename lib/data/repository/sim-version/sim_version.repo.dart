import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/new_version_resp.model.dart';
import '../../model/version_excel_resp.model.dart';
import '../../model/version_list.model.dart';
import '../../provider/sim-version/sim_version.provider.dart';

class SimVersionRepo {
  //*--------(provider instance)
  final SimVersionProvider simProvider = autoInjector.get<SimVersionProvider>();
  Future<NewVersionRespModel> createNewVersion({
    required String simId,
    required String userId,
  }) async {
    try {
      final NewVersionRespModel response = await simProvider.createNewVersion(
        simId: simId,
        userId: userId,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }

  Future<VersionExcelRespModel> generateVersionExcel({
    required String simId,
    required String userId,
    required String versionNo,
  }) async {
    try {
      final VersionExcelRespModel response =
          await simProvider.generateVersionExcel(
        simId: simId,
        userId: userId,
        versionNo: versionNo,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }

  Future<VersionListModel> fetchVersionList({
    required String simId,
    required String userId,
  }) async {
    try {
      final VersionListModel response = await simProvider.fetchVersionList(
        simId: simId,
        userId: userId,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }

  Future<VersionListModel> deleteVersion({
    required String simId,
    required String versionNo,
  }) async {
    try {
      final VersionListModel response = await simProvider.deleteVersion(
        simId: simId,
        versionNo: versionNo,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

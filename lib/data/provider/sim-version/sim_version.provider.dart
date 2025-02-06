import 'package:johnsonville_cost_simulator/data/service/sim-version/sim_version.service.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/new_version_resp.model.dart';
import '../../model/version_excel_resp.model.dart';
import '../../model/version_list.model.dart';

class SimVersionProvider {
  //*--------(service instance)
  final SimVersionService simService = autoInjector.get<SimVersionService>();
  Future<NewVersionRespModel> createNewVersion({
    required String simId,
    required String userId,
  }) async {
    try {
      final response = await simService.createNewVersion(
        simId: simId,
        userId: userId,
      );

      final NewVersionRespModel model = NewVersionRespModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
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
      final response = await simService.generateVersionExcel(
        simId: simId,
        userId: userId,
        versionNo: versionNo,
      );

      final VersionExcelRespModel model = VersionExcelRespModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
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
      final response = await simService.deleteVersion(
        simId: simId,
        versionNo: versionNo,
      );

      final VersionListModel model = VersionListModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
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
      final response = await simService.fetchVersionList(
        simId: simId,
        userId: userId,
      );

      final VersionListModel model = VersionListModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/copy_sim_resp.model.dart';
import '../../service/replicate/replicate.service.dart';

class ReplicateProvider {
  final ReplicateService service = autoInjector.get<ReplicateService>();
  Future<ReplicateSheetRespModel> replicateWorkSheet({
    required String costSimulatorId,
    required String userId,
  }) async {
    try {
      final response = await service.replicateWorkSheet(
        costSimulatorId: costSimulatorId,
        userId: userId,
      );
      final ReplicateSheetRespModel model = ReplicateSheetRespModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

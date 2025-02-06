import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/copy_sim_resp.model.dart';
import '../../provider/replicate/replicate.provider.dart';

class ReplicateRepo {
  final ReplicateProvider provider = autoInjector.get<ReplicateProvider>();
  Future<ReplicateSheetRespModel?> replicateWorkSheet({
    required String costSimulatorId,
    required String userId,
  }) async {
    try {
      final ReplicateSheetRespModel response =
          await provider.replicateWorkSheet(
        costSimulatorId: costSimulatorId,
        userId: userId,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

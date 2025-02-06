import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/load_simulator.model.dart';
import '../../service/load-simulator/load_simulator.service.dart';

class LoadCostSimulatorProvider {
  final LoadCostSimulatorService loadCostSimulatorService =
      autoInjector.get<LoadCostSimulatorService>();
  Future<LoadCostSimulatorModel> getLoadCostSimulatorList({
    required String costSimulatorId,
  }) async {
    try {
      final response = await loadCostSimulatorService.getCostLoadSimulatorList(
        costSimulatorId: costSimulatorId,
      );
      final LoadCostSimulatorModel model = LoadCostSimulatorModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

import 'package:johnsonville_cost_simulator/data/model/load_simulator.model.dart';
import 'package:johnsonville_cost_simulator/data/provider/load-simulator/load_simulator.provider.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';
import '../../../main.dart';

class LoadCostSimulatorRepo {
  final LoadCostSimulatorProvider loadCostSimulatorProvider =
      autoInjector.get<LoadCostSimulatorProvider>();

  Future<LoadCostSimulatorModel?> getLoadCostSimulatorList({
    required String costSimulatorId,
  }) async {
    try {
      final LoadCostSimulatorModel response =
          await loadCostSimulatorProvider.getLoadCostSimulatorList(
        costSimulatorId: costSimulatorId,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

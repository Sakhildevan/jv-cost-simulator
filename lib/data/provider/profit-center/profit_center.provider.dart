import 'package:johnsonville_cost_simulator/data/service/profit-center/profit_center.service.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/profit_center.model.dart';

class ProfitCenterProvider {
  //*--------(service instance)
  final ProfitCenterService simService =
      autoInjector.get<ProfitCenterService>();
  Future<ProfitCenterModel> fetchProductionLocation() async {
    try {
      final response = await simService.fetchProductionLocation();

      final ProfitCenterModel model = ProfitCenterModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

import 'package:johnsonville_cost_simulator/data/model/profit_center.model.dart';
import 'package:johnsonville_cost_simulator/data/provider/profit-center/profit_center.provider.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';

class ProfitCenterRepo {
  //*--------(provider instance)
  final ProfitCenterProvider profitProvider =
      autoInjector.get<ProfitCenterProvider>();
  Future<ProfitCenterModel> fetchProductionLocation() async {
    try {
      final ProfitCenterModel response =
          await profitProvider.fetchProductionLocation();
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

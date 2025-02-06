import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/fx_trending_line.model.dart';
import '../../service/fx-trending/fx_trending.service.dart';

class FxTrendingProvider {
  final FxTrendingService fxService = autoInjector.get<FxTrendingService>();
  Future<FxLineModel> getFxLineGraphList() async {
    try {
      final response = await fxService.getFxLineGraphList();
      final FxLineModel model = FxLineModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

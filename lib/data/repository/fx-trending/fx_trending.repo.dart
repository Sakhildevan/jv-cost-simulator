import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/fx_trending_line.model.dart';
import '../../provider/fx-trending/fx_trending_provider.dart';

class FxTrendingRepo {
  final FxTrendingProvider fxProvider = autoInjector.get<FxTrendingProvider>();

  Future<FxLineModel?> getFxLineGraphList() async {
    try {
      final FxLineModel response = await fxProvider.getFxLineGraphList();
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

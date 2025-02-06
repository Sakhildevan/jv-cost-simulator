import 'package:johnsonville_cost_simulator/data/provider/entity/entity.provider.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/entity.model.dart';

class EntityDataRepo {
  //*--------(Provider instance)
  final EntityProvider simProvider = autoInjector.get<EntityProvider>();
  Future<EntityModel> fetchEntityData({
    required String geoLocationId,
  }) async {
    try {
      final EntityModel response = await simProvider.fetchEntityData(
        geoLocationId: geoLocationId,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

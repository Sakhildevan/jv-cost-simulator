import 'package:johnsonville_cost_simulator/data/service/entity/entity.service.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/entity.model.dart';

class EntityProvider {
  //*--------(service instance)
  final EntityService simService = autoInjector.get<EntityService>();
  Future<EntityModel> fetchEntityData({
    required String geoLocationId,
  }) async {
    try {
      final response = await simService.fetchEntityData(
        geoLocationId: geoLocationId,
      );

      final EntityModel model = EntityModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

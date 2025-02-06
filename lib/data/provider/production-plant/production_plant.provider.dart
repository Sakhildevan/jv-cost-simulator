import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/production_country_resp.model.dart';
import '../../model/production_plant_resp.model.dart';
import '../../service/production-plant/production_plant.service.dart';

class ProductionPlantProvider {
  final ProductionPlantService _service =
      autoInjector.get<ProductionPlantService>();
  Future<ProductionCountryRespModel> fetchProductionCountry() async {
    try {
      final response = await _service.fetchProductionCountry();
      final ProductionCountryRespModel model =
          ProductionCountryRespModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }

  Future<ProductionPlantRespModel> fetchProductionPlant({
    required String countryID,
  }) async {
    try {
      final response = await _service.fetchProductionPlant(
        countryID: countryID,
      );
      final ProductionPlantRespModel model = ProductionPlantRespModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

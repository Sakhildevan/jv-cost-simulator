import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/production_country_resp.model.dart';
import '../../model/production_plant_resp.model.dart';
import '../../provider/production-plant/production_plant.provider.dart';

class ProductionPlantRepo {
  final ProductionPlantProvider _provider =
      autoInjector.get<ProductionPlantProvider>();
//*---------fetch production country
  Future<ProductionCountryRespModel?> fetchProductionCountry() async {
    try {
      final ProductionCountryRespModel response =
          await _provider.fetchProductionCountry();
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }

//*---------fetch production plant
  Future<ProductionPlantRespModel?> fetchProductionPlant(
      {required String countryID}) async {
    try {
      final ProductionPlantRespModel response =
          await _provider.fetchProductionPlant(
        countryID: countryID,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

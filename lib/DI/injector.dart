import 'package:johnsonville_cost_simulator/data/provider/comments/comments.provider.dart';
import 'package:johnsonville_cost_simulator/data/provider/currency/currency_list.provider.dart';
import 'package:johnsonville_cost_simulator/data/provider/download/download.provider.dart';
import 'package:johnsonville_cost_simulator/data/provider/profit-center/profit_center.provider.dart';
import 'package:johnsonville_cost_simulator/data/provider/sim-version/sim_version.provider.dart';
import 'package:johnsonville_cost_simulator/data/provider/update-field/update_field.provider.dart';
import 'package:johnsonville_cost_simulator/data/repository/comments/comments.repo.dart';
import 'package:johnsonville_cost_simulator/data/repository/download/download.repo.dart';
import 'package:johnsonville_cost_simulator/data/repository/load-simulator/load_simulator.repo.dart';
import 'package:johnsonville_cost_simulator/data/repository/profit-center/profit_center.repo.dart';
import 'package:johnsonville_cost_simulator/data/repository/update-field/update_field.repo.dart';
import 'package:johnsonville_cost_simulator/data/service/comments/comments.service.dart';
import 'package:johnsonville_cost_simulator/data/service/currency/currency_list.service.dart';
import 'package:johnsonville_cost_simulator/data/service/download/download.service.dart';
import 'package:johnsonville_cost_simulator/data/service/load-simulator/load_simulator.service.dart';
import 'package:johnsonville_cost_simulator/data/service/profit-center/profit_center.service.dart';
import 'package:johnsonville_cost_simulator/data/service/sim-version/sim_version.service.dart';
import 'package:johnsonville_cost_simulator/data/service/update-field/update_fields.service.dart';

import '../data/provider/auth/login.provider.dart';
import '../data/provider/business-unit/business_unit.provider.dart';
import '../data/provider/create_step_two/create_step_two.provider.dart';
import '../data/provider/delivery-to/delivery_to.provider.dart';
import '../data/provider/entity/entity.provider.dart';
import '../data/provider/fx-trending/fx_trending_provider.dart';
import '../data/provider/load-simulator/load_simulator.provider.dart';
import '../data/provider/master-list/master_list.provider.dart';
import '../data/provider/pricing-worksheet/pricing_worksheet.provider.dart';
import '../data/provider/production-plant/production_plant.provider.dart';
import '../data/provider/replicate/replicate.provider.dart';
import '../data/provider/simulator-list/simulator_list.provider.dart';
import '../data/provider/step_one/step_one.provider.dart';
import '../data/provider/subsidiary/subsidiary.provider.dart';
import '../data/repository/auth/login.repo.dart';
import '../data/repository/business-unit/business_unit.repo.dart';
import '../data/repository/create_step_two/create_step_two.repo.dart';
import '../data/repository/currency/currency_list.repo.dart';
import '../data/repository/delivery-to/delivery_to.repo.dart';
import '../data/repository/entity/entity.repo.dart';
import '../data/repository/fx-trending/fx_trending.repo.dart';
import '../data/repository/master-list/master_list.repo.dart';
import '../data/repository/pricing-worksheet/pricing_worksheet.repo.dart';
import '../data/repository/production-plant/production_plant.repo.dart';
import '../data/repository/replicate/replicate.repo.dart';
import '../data/repository/sim-version/sim_version.repo.dart';
import '../data/repository/simulator-list/simulator_list.repo.dart';
import '../data/repository/step_one/step_one.repo.dart';
import '../data/repository/subsidiary/subsidiary.repo.dart';
import '../data/service/auth/login.service.dart';
import '../data/service/business-unit/business_unit.service.dart';
import '../data/service/create_step_two/create_step_two.service.dart';
import '../data/service/delivery-to/delivery_to.service.dart';
import '../data/service/entity/entity.service.dart';
import '../data/service/fx-trending/fx_trending.service.dart';
import '../data/service/master-list/master_list.service.dart';
import '../data/service/pricing-worksheet/pricing_worksheet.service.dart';
import '../data/service/production-plant/production_plant.service.dart';
import '../data/service/replicate/replicate.service.dart';
import '../data/service/simulator-list/cost_simulator.service.dart';
import '../data/service/step_one/step_one.service.dart';
import '../data/service/subsidiary/subsidiary.service.dart';
import '../main.dart';

autoInjectInitializer() {
  //*------- (login)
  //service
  autoInjector.add(LoginServices.new);
  //provider
  autoInjector.add(LoginProvider.new);
  //repo
  autoInjector.add(LoginRepo.new);
  //*------- (create simulator)
  //service
  autoInjector.add(CreateSimulatorService.new);
  //provider
  autoInjector.add(CreateSimulatorProvider.new);
  //repo
  autoInjector.add(CreateSimulatorRepo.new);
  //*------- (simulator list)
  //service
  autoInjector.add(CostSimulatorService.new);
  //provider
  autoInjector.add(SimulatorListProvider.new);
  //repo
  autoInjector.add(SimulatorListRepo.new);

  //*------- (currency list)
  //service
  autoInjector.add(CurrencyListService.new);
  //provider
  autoInjector.add(CurrencyListProvider.new);
  //repo
  autoInjector.add(CurrencyListRepo.new);
  //*------- (profit center )
  //service
  autoInjector.add(ProfitCenterService.new);
  //provider
  autoInjector.add(ProfitCenterProvider.new);
  //repo
  autoInjector.add(ProfitCenterRepo.new);
  //*------- (Entity)
  //service
  autoInjector.add(EntityService.new);
  //provider
  autoInjector.add(EntityProvider.new);
  //repo
  autoInjector.add(EntityDataRepo.new);
  //*------- (Load)
  //service
  autoInjector.add(LoadCostSimulatorService.new);
  //provider
  autoInjector.add(LoadCostSimulatorProvider.new);
  //repo
  autoInjector.add(LoadCostSimulatorRepo.new);
  //*------- (Pricing-worksheet)
  //service
  autoInjector.add(PricingWorkSheetService.new);
  //provider
  autoInjector.add(PricingWorkSheetProvider.new);
  //repo
  autoInjector.add(PricingWorkSheetRepo.new);
  //*------- (Comments)
  //service
  autoInjector.add(CommentsService.new);
  //provider
  autoInjector.add(CommentsProvider.new);
  //repo
  autoInjector.add(CommentsRepo.new);
  //*------- (fx-trending)
  //service
  autoInjector.add(FxTrendingService.new);
  //provider
  autoInjector.add(FxTrendingProvider.new);
  //repo
  autoInjector.add(FxTrendingRepo.new);
  //commit
  //*------- (Create Step Two )
  //service
  autoInjector.add(CreateStepTwoService.new);
  //provider
  autoInjector.add(CreateStepTwoProvider.new);
  //repo
  autoInjector.add(CreateStepTwoRepo.new);
  //*------- (Master list)
  //service
  autoInjector.add(MasterListService.new);
  //provider
  autoInjector.add(MasterListProvider.new);
  //repo
  autoInjector.add(MasterListRepo.new);
  //*------- (update field data )
  //service
  autoInjector.add(UpdateFieldsService.new);
  //provider
  autoInjector.add(UpdateFieldProvider.new);
  //repo
  autoInjector.add(UpdateFieldRepo.new);
  //*------- (download )
  //service
  autoInjector.add(DownloadService.new);
  //provider
  autoInjector.add(DownloadProvider.new);
  //repo
  autoInjector.add(DownloadRepo.new);
  //*------- (replicate )
  //service
  autoInjector.add(ReplicateService.new);
  //provider
  autoInjector.add(ReplicateProvider.new);
  //repo
  autoInjector.add(ReplicateRepo.new);
  //*------- (sim version )
  //service
  autoInjector.add(SimVersionService.new);
  //provider
  autoInjector.add(SimVersionProvider.new);
  //repo
  autoInjector.add(SimVersionRepo.new);
  //*------- (production plant )
  //service
  autoInjector.add(ProductionPlantService.new);
  //provider
  autoInjector.add(ProductionPlantProvider.new);
  //repo
  autoInjector.add(ProductionPlantRepo.new);
  //*------- (Business unit )
  //service
  autoInjector.add(BusinessUnitService.new);
  //provider
  autoInjector.add(BusinessUnitProvider.new);
  //repo
  autoInjector.add(BusinessUnitRepo.new);
  //*------- (Subsidiary )
  //service
  autoInjector.add(SubsidiaryService.new);
  //provider
  autoInjector.add(SubsidiaryProvider.new);
  //repo
  autoInjector.add(SubsidiaryRepo.new);
  //*------- (Delivery To )
  //service
  autoInjector.add(DeliveryToService.new);
  //provider
  autoInjector.add(DeliveryToProvider.new);
  //repo
  autoInjector.add(DeliveryToRepo.new);
//!Warning: add classes above commit
  //commit
  autoInjector.commit();
}

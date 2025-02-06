import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:johnsonville_cost_simulator/data/model/currency_list.model.dart';
import 'package:johnsonville_cost_simulator/data/model/fx_trending_line.model.dart';
import 'package:johnsonville_cost_simulator/data/repository/entity/entity.repo.dart';
import 'package:johnsonville_cost_simulator/data/repository/fx-trending/fx_trending.repo.dart';
import 'package:johnsonville_cost_simulator/data/repository/profit-center/profit_center.repo.dart';
import 'package:johnsonville_cost_simulator/data/repository/step_one/step_one.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';
import '../../data/model/business_unit_resp.model.dart';
import '../../data/model/create_simulator.model.dart';
import '../../data/model/delivery_to_resp.model.dart';
import '../../data/model/load_simulator.model.dart';
import '../../data/model/production_country_resp.model.dart';
import '../../data/model/production_plant_resp.model.dart';
import '../../data/model/profit_center.model.dart';
import '../../data/model/step_one_request.model.dart';
import '../../data/model/subsidiary_resp.model.dart';
import '../../data/repository/business-unit/business_unit.repo.dart';
import '../../data/repository/currency/currency_list.repo.dart';
import '../../data/repository/delivery-to/delivery_to.repo.dart';
import '../../data/repository/load-simulator/load_simulator.repo.dart';
import '../../data/repository/production-plant/production_plant.repo.dart';
import '../../data/repository/subsidiary/subsidiary.repo.dart';
import '../../main.dart';
import '../../utils/enums.dart';
import '../../utils/string_const.dart';

part 'step_one_event.dart';
part 'step_one_state.dart';

List<String> unitOzMeasureList = <String>[StringConst.lb];
List<String> unitGmsMeasureList = <String>[StringConst.kg];

List<String> unitMeasureList = [];

class StepOneBloc extends Bloc<StepOneEvent, StepOneState>
    with
        RepoHandler,
        ItemInfoUpdateHandler,
        SellDetailUpdateHandler,
        SellVolumeUpdateHandler,
        ItemDetailUpdateHandler,
        DeliveryInfoUpdateHandler,
        ProdPlantUpdateHandler {
  StepOneBloc() : super(const StepOneState()) {
    on<StepOneInitial>(_onInitial);
    on<ItemInfoUpdateValue>(handleItemInfoUpdate);
    on<ProdPlantUpdate>(handleProdPlantUpdate);
    on<ProvideSellVolumeUpdateValue>(handleSellVolumeUpdate);
    on<EnterItemDetailUpdate>(handleEnterItemDetailUpdate);
    on<ProvideSellDetailUpdate>(handleSellDetailUpdate);
    on<ProvideDeliveryInfoUpdate>(handleProvideDeliveryInfoUpdate);
    on<OnNextTap>(_onNextTap);
    on<CheckMetrics>(_onCheckMetrics);
    on<CustomerNameAdd>(_onCustomerNameAdd);
    on<CustomerNameRemove>(_onCustomerNameRemove);
  }

  FutureOr<void> _onInitial(
    StepOneInitial event,
    Emitter<StepOneState> emit,
  ) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();

    String userName = prefs.getString(
          StringConst.userFirstNameValue,
        ) ??
        '';

    emit(
      StepOneState(
        isStepOneCompleted: false,
        loadingStatus: LoadingStatus.loading,
        costSimulatorId: event.simId,
        userName: userName,
      ),
    );
    try {
      final currencyResp = await currencyListRepo.fetchCurrencyList();
      final fxLineResp = await fxTrendingRepo.getFxLineGraphList();
      final productionLocationResp = await profitRepo.fetchProductionLocation();
      final productionCountryResp =
          await productionPlantRepo.fetchProductionCountry();
      final businessUnitResp = await businessUnitRepo.fetchBusinessUnit();
      final subsidiaryResp = await subsidiaryRepo.fetchSubsidiary();
      final deliveryToResp = await deliveryToRepo.fetchDeliveryTo();
      // final entityResp = await entityRepo.fetchEntityData(geoLocationId: '0');

      emit(state.copyWith(
        fxLineResp: fxLineResp,
        dropDownCurrencyList: currencyResp.currencies,
        dropDownProdLocList: productionLocationResp.profitCenters,
        dropDownProdCountryList:
            productionCountryResp?.productionCountries ?? <ProductionCountry>[],
        dropDownBusinessUnitList: businessUnitResp?.businessUnits ?? [],
        dropDownDeliverToList: deliveryToResp?.deliveryCountries ?? [],
        dropDownSubsidiaryList: subsidiaryResp?.subsidiaries ?? [],
        dropDownJvlCurrencyList: currencyResp.currencies,
        dropDownSellCurrencyToConsumerList: currencyResp.currencies,
      ));
      if (event.simId != "0" && (event.simId?.isNotEmpty ?? false)) {
        final loadSimResp =
            await loadCostSimulatorRepo.getLoadCostSimulatorList(
          costSimulatorId: event.simId ?? "0",
        );
        //TODO: need to change commented static data

        final productionPlantResp =
            (loadSimResp?.productionCountryId?.isNotEmpty ?? false)
                ? await productionPlantRepo.fetchProductionPlant(
                    countryID: loadSimResp?.productionCountryId ?? "")
                : null;

        final productionLocation = loadSimResp?.productionLocationId != null
            ? productionLocationResp.profitCenters?.firstWhere(
                (element) =>
                    element.profitCenterCode ==
                    loadSimResp?.productionLocationId,
                orElse: () => ProfitCenter(),
              )
            : null;
        final businessUnit = loadSimResp?.businessUnit != null
            ? businessUnitResp?.businessUnits?.firstWhere(
                (element) =>
                    element.businessUnitId == loadSimResp?.businessUnit,
                orElse: () => BusinessUnit(),
              )
            : null;

        final deliveredTo = loadSimResp?.deliveredTo != null
            ? deliveryToResp?.deliveryCountries?.firstWhere(
                (element) =>
                    element.deliveryCountryId == loadSimResp?.deliveredTo,
                orElse: () => DeliveryCountry(),
              )
            : null;
        final itemCurrency = loadSimResp?.itemCurrencyId != null
            ? currencyResp.currencies?.firstWhere(
                (element) =>
                    element.currencyCode == loadSimResp?.itemCurrencyId,
                orElse: () => Currency(),
              )
            : null;
        //TODO: need to set subsidiaryId
        final subsidiaryId = loadSimResp?.subsidiaryId != null
            ? subsidiaryResp?.subsidiaries?.firstWhere(
                (element) => element.subsidiaryId == loadSimResp?.subsidiaryId,
                orElse: () => Subsidiary(),
              )
            : null;

        final sellCurrency = loadSimResp?.sellCurrencyId != null
            ? currencyResp.currencies?.firstWhere(
                (element) =>
                    element.currencyCode == loadSimResp?.sellCurrencyId,
                orElse: () => Currency(),
              )
            : null;

        final consumerCurrency = loadSimResp?.consumerCurrencyId != null
            ? currencyResp.currencies?.firstWhere(
                (element) =>
                    element.currencyCode == loadSimResp?.consumerCurrencyId,
                orElse: () => Currency(),
              )
            : null;
        final prodCountry = loadSimResp?.productionCountryId != null
            ? productionCountryResp?.productionCountries?.firstWhere(
                (element) {
                  return element.countryId == loadSimResp?.productionCountryId;
                },
                orElse: () => ProductionCountry(),
              )
            : null;
        final prodPlant = loadSimResp?.productionPlantId != null
            ? productionPlantResp?.productionPlants?.firstWhere(
                (element) {
                  return element.productionPlantId ==
                      loadSimResp?.productionPlantId;
                },
                orElse: () => ProductionPlant(),
              )
            : null;
        if (loadSimResp?.packUom?.toUpperCase() ==
            StringConst.oz.toUpperCase()) {
          unitMeasureList = List.from(unitOzMeasureList);
        } else {
          unitMeasureList = List.from(unitGmsMeasureList);
        }
        final sellVolumeUnit =
            loadSimResp?.packUom?.toUpperCase() == StringConst.oz.toUpperCase()
                ? StringConst.lb
                : StringConst.kg;
        emit(state.copyWith(
          itemName: loadSimResp?.itemName,
          unitMeasureList: unitMeasureList,
          itemDescription: loadSimResp?.itemDescription,
          productionLocation: productionLocation,
          sellVolume: loadSimResp?.sellVolume,
          deliveredTo: deliveredTo,
          subsidiaryId: subsidiaryId,
          productionCountry: prodCountry,
          businessUnit: businessUnit,
          dropDownProdPlantList: productionPlantResp?.productionPlants ?? [],
          simStatus: loadSimResp?.status ?? "",
          packSize: loadSimResp?.packSize,
          packUom: loadSimResp?.packUom,
          sellVolumeUnit: sellVolumeUnit,
          linksPerPack: loadSimResp?.linksPerPack,
          packsPerCase: loadSimResp?.packsPerCase,
          itemCurrency: itemCurrency,
          customerName:
              fCon.splitString(loadSimResp?.customerName ?? "").length == 1
                  ? fCon.splitString(loadSimResp?.customerName ?? "").last
                  : "",
          customerNameList: (loadSimResp?.customerName?.isNotEmpty ?? false) &&
                  (loadSimResp?.customerName != "null")
              ? fCon.splitString(loadSimResp?.customerName ?? "").length != 1
                  ? fCon.splitString(loadSimResp?.customerName ?? "")
                  : []
              : [],
          // customerName: loadSimResp?.customerName,
          // jvlSubsidiarySale: jvlSubsidiarySale,
          //TODO: need to set subsidiaryId
          // subsidiaryId:,
          productionPlant: prodPlant,
          sellCurrency: sellCurrency,
          consumerCurrency: consumerCurrency,
          plannedExchangeRate: loadSimResp?.plannedExchangeRate,
          plannedExchangeRateComment:
              loadSimResp?.plannedExchangeRateCmmnt ?? "",
          estSellVolComment: loadSimResp?.estimatedCellVolumeCmmnt ?? "",
          createdBy: loadSimResp?.createdBy,
          createdOn: loadSimResp?.createdOn,
          approvedBy: loadSimResp?.approvedBy,
          approvedOn: loadSimResp?.approvedOn,

          loadingStatus: LoadingStatus.success,
        ));
      } else {
        emit(state.copyWith(
          simStatus: StringConst.newValue,
          loadingStatus: LoadingStatus.success,
        ));
      }
    } catch (error) {
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onNextTap(
    OnNextTap event,
    Emitter<StepOneState> emit,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final createdBy = prefs.getString(
        StringConst.userFirstNameValue,
      );

      emit(
        state.copyWith(
          createSimLoadingStatus: LoadingStatus.loading,
        ),
      );

      final response = await createSimulatorRepo.createNewSimulator(
        requestBody: CreateSimRequestModel(
          itemName: state.itemName,
          itemDescription: state.itemDescription,
          sellVolume: state.sellVolume,
          productionLocationId: state.productionPlant?.productionPlantId,
          deliveredTo: state.deliveredTo?.deliveryCountryId,
          packSize: state.packSize,
          packUom: state.packUom,
          sellVolumeUnit: state.sellVolumeUnit,
          linksPerPack: state.linksPerPack,
          packsPerCase: state.packsPerCase,
          itemCurrencyId: state.itemCurrency?.currencyCode ?? "",
          sellCurrencyId: state.sellCurrency?.currencyCode,
          //TODO: need to change static data
          // consumerCurrencyId: "USD",
          consumerCurrencyId: state.consumerCurrency?.currencyCode,
          plannedExchangeRate: state.plannedExchangeRate,
          productionCountryId: state.productionCountry?.countryId,
          productionPlantId: state.productionPlant?.productionPlantId,
          subsidiaryId: state.subsidiaryId?.subsidiaryId ?? "",
          jvlSubsidiarySale: "",
          customerName: (state.customerNameList?.isNotEmpty ?? false) &&
                  (state.customerName?.isNotEmpty ?? false)
              ? "${fCon.removeSquareBrackets(
                  state.customerNameList.toString(),
                )},${state.customerName}"
              : (state.customerNameList?.isNotEmpty ?? false) &&
                      (state.customerName?.isEmpty ?? false)
                  ? fCon.removeSquareBrackets(
                      state.customerNameList.toString(),
                    )
                  : state.customerName,
          // customerName: state.customerName ?? "",
          estSellVolComment: state.estSellVolComment ?? "",
          plannedExchangeRateComment: state.plannedExchangeRateComment ?? "",
          businessUnit: state.businessUnit?.businessUnitId ?? "",
          createdBy: createdBy,
          costSimulatorId: state.costSimulatorId,
        ).toJson(),
      );

      if (response.isSuccess ?? false) {
        emit(state.copyWith(
          isStepOneCompleted: true,
          createSimLoadingStatus: LoadingStatus.success,
          costSimulatorId: response.costSimulatorId.toString(),
        ));
      } else {
        emit(
          state.copyWith(
            createSimLoadingStatus: LoadingStatus.failure,
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          createSimLoadingStatus: LoadingStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onCheckMetrics(
    CheckMetrics event,
    Emitter<StepOneState> emit,
  ) async {
    if ((event.sellVolumeUnit ?? '').isNotEmpty &&
        (event.packUom ?? '').isNotEmpty) {
      emit(
        state.copyWith(
          isMetricsSelected: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isMetricsSelected: false,
        ),
      );
    }
  }

  FutureOr<void> _onCustomerNameAdd(
    CustomerNameAdd event,
    Emitter<StepOneState> emit,
  ) {
    List<String> data = List.from(state.customerNameList ?? []);
    if (state.customerName?.isNotEmpty ?? false) {
      data.add(state.customerName?.trim() ?? "");
      emit(state.copyWith(
        customerNameList: data,
        customerName: '',
      ));
    }
  }

  FutureOr<void> _onCustomerNameRemove(
    CustomerNameRemove event,
    Emitter<StepOneState> emit,
  ) {
    List<String> data = List.from(state.customerNameList ?? []);
    data.removeAt(event.index);
    emit(state.copyWith(customerNameList: data));
  }

  @override
  void onTransition(Transition<StepOneEvent, StepOneState> transition) {
    super.onTransition(transition);
  }
}

// Mixin to handle repository instances and dependencies
mixin RepoHandler on Bloc<StepOneEvent, StepOneState> {
  final CreateSimulatorRepo createSimulatorRepo =
      autoInjector.get<CreateSimulatorRepo>();
  final CurrencyListRepo currencyListRepo =
      autoInjector.get<CurrencyListRepo>();
  final ProfitCenterRepo profitRepo = autoInjector.get<ProfitCenterRepo>();
  final EntityDataRepo simService = autoInjector.get<EntityDataRepo>();
  final EntityDataRepo entityRepo = autoInjector.get<EntityDataRepo>();
  final FxTrendingRepo fxTrendingRepo = autoInjector.get<FxTrendingRepo>();
  final LoadCostSimulatorRepo loadCostSimulatorRepo =
      autoInjector.get<LoadCostSimulatorRepo>();
  final ProductionPlantRepo productionPlantRepo =
      autoInjector.get<ProductionPlantRepo>();
  final BusinessUnitRepo businessUnitRepo =
      autoInjector.get<BusinessUnitRepo>();
  final SubsidiaryRepo subsidiaryRepo = autoInjector.get<SubsidiaryRepo>();
  final DeliveryToRepo deliveryToRepo = autoInjector.get<DeliveryToRepo>();
}

// Mixin to handle item info update events
mixin ItemInfoUpdateHandler on Bloc<StepOneEvent, StepOneState> {
  FutureOr<void> handleItemInfoUpdate(
    ItemInfoUpdateValue event,
    Emitter<StepOneState> emit,
  ) {
    emit(state.copyWith(
      itemName: event.itemName,
      itemDescription: event.itemDescription,
      productionLocation: event.productionLocation,
      productionCountry: event.productionCountry,
      productionPlant: event.productionPlant,
      businessUnit: event.businessUnit,
    ));
  }
}
mixin ProdPlantUpdateHandler on Bloc<StepOneEvent, StepOneState>, RepoHandler {
  FutureOr<void> handleProdPlantUpdate(
    ProdPlantUpdate event,
    Emitter<StepOneState> emit,
  ) async {
    final productionCountryResp =
        await productionPlantRepo.fetchProductionPlant(
            countryID: event.productionCountry?.countryId ?? "");
    emit(
      state.copyWith(
        dropDownProdPlantList: productionCountryResp?.productionPlants ?? [],
      ),
    );
  }
}

// Mixin to handle sell detail update events
mixin SellDetailUpdateHandler on Bloc<StepOneEvent, StepOneState> {
  FutureOr<void> handleSellDetailUpdate(
    ProvideSellDetailUpdate event,
    Emitter<StepOneState> emit,
  ) {
    emit(state.copyWith(
      customerName: event.customerName,
      subsidiaryId: event.subsidiaryId,
      // jvlSubsidiarySale: event.jvlSubsidiarySale,
    ));
  }
}

// Mixin to handle sell volume update events
mixin SellVolumeUpdateHandler on Bloc<StepOneEvent, StepOneState> {
  FutureOr<void> handleSellVolumeUpdate(
    ProvideSellVolumeUpdateValue event,
    Emitter<StepOneState> emit,
  ) {
    emit(state.copyWith(
      sellVolume: event.sellVolume,
      deliveredTo: event.deliveredTo,
      estSellVolComment: event.estSellVolComment,
      sellVolumeUnit: event.sellVolumeUnit,
    ));
  }
}

// Mixin to handle item detail update events
mixin ItemDetailUpdateHandler on Bloc<StepOneEvent, StepOneState> {
  FutureOr<void> handleEnterItemDetailUpdate(
    EnterItemDetailUpdate event,
    Emitter<StepOneState> emit,
  ) {
    final sellVolumeUnit =
        event.packUom?.toUpperCase() == StringConst.oz.toUpperCase()
            ? StringConst.lb
            : StringConst.kg;
    if (event.packUom?.toUpperCase() == StringConst.oz.toUpperCase()) {
      unitMeasureList = List.from(unitOzMeasureList);
    } else {
      unitMeasureList = List.from(unitGmsMeasureList);
    }
    emit(state.copyWith(
      packSize: event.packSize,
      packUom: event.packUom,
      sellVolumeUnit: sellVolumeUnit,
      unitMeasureList: unitMeasureList,
      linksPerPack: event.linksPerPack,
      packsPerCase: event.packsPerCase,
      // itemCurrency: event.currency,
    ));
  }
}

// Mixin to handle delivery info update events
mixin DeliveryInfoUpdateHandler on Bloc<StepOneEvent, StepOneState> {
  FutureOr<void> handleProvideDeliveryInfoUpdate(
    ProvideDeliveryInfoUpdate event,
    Emitter<StepOneState> emit,
  ) {
    emit(state.copyWith(
      sellCurrency: event.sellCurrency,
      consumerCurrency: event.consumerCurrency,
      plannedExchangeRate: event.plannedExchangeRate,
      plannedExchangeRateComment: event.plannedExchangeRateComment,
    ));
  }
}

part of 'step_one_bloc.dart';

class StepOneState extends Equatable {
  const StepOneState({
    this.userName,
    this.itemName,
    this.businessUnit,
    this.productionCountry,
    this.productionPlant,
    this.isStepOneCompleted,
    this.isMetricsSelected,
    this.createSimResp,
    this.loadingStatus,
    this.simStatus,
    this.createSimLoadingStatus,
    this.fxLineResp,
    this.itemDescription,
    this.sellVolume,
    this.productionLocation,
    this.deliveredTo,
    this.packSize,
    this.packUom,
    this.sellVolumeUnit,
    this.linksPerPack,
    this.packsPerCase,
    this.itemCurrency,
    this.itemCurrencyValue,
    this.sellCurrency,
    this.sellCurrencyValue,
    this.consumerCurrency,
    this.consumerCurrencyValue,
    this.plannedExchangeRate,
    // this.jvlSubsidiarySale,
    this.subsidiaryId,
    this.customerName,
    this.customerNameList,
    this.costSimulatorId,
    this.dropDownCurrencyList,
    this.dropDownProdLocList,
    this.dropDownProdCountryList,
    this.dropDownBusinessUnitList,
    this.dropDownProdPlantList,
    this.dropDownDeliverToList,
    this.dropDownSubsidiaryList,
    this.dropDownJvlCurrencyList,
    this.dropDownSellCurrencyToConsumerList,
    this.unitMeasureList,
    this.loadCostSimulatorResp,
    this.estSellVolComment,
    this.plannedExchangeRateComment,
    this.createdBy,
    this.createdOn,
    this.approvedBy,
    this.approvedOn,
  });
  final bool? isStepOneCompleted;
  final bool? isMetricsSelected;
  final String? simStatus;
  final LoadingStatus? loadingStatus;
  final LoadingStatus? createSimLoadingStatus;
  final FxLineModel? fxLineResp;
  final CreateSimulatorModel? createSimResp;
  final String? itemName;
  final BusinessUnit? businessUnit;
  final String? userName;
  final List<String>? customerNameList;
  final String? itemDescription;
  final ProfitCenter? productionLocation;
  final ProductionCountry? productionCountry;
  final ProductionPlant? productionPlant;
  final String? sellVolume;
  final DeliveryCountry? deliveredTo;
  final String? packSize;
  final String? packUom;
  final String? sellVolumeUnit;
  final String? linksPerPack;
  final String? packsPerCase;
  final Currency? itemCurrency;
  final String? itemCurrencyValue;
  final Currency? sellCurrency;
  final String? sellCurrencyValue;
  final Currency? consumerCurrency;
  final String? consumerCurrencyValue;
  final String? plannedExchangeRate;
  // final Subsidiary? jvlSubsidiarySale;
  final Subsidiary? subsidiaryId;
  final String? customerName;
  final String? costSimulatorId;
  final List<Currency>? dropDownCurrencyList;
  final List<ProfitCenter>? dropDownProdLocList;
  final List<ProductionCountry>? dropDownProdCountryList;
  final List<BusinessUnit>? dropDownBusinessUnitList;
  final List<ProductionPlant>? dropDownProdPlantList;
  final List<DeliveryCountry>? dropDownDeliverToList;
  final List<Subsidiary>? dropDownSubsidiaryList;
  final List<Currency>? dropDownJvlCurrencyList;
  final List<Currency>? dropDownSellCurrencyToConsumerList;
  final List<String>? unitMeasureList;
  final LoadCostSimulatorModel? loadCostSimulatorResp;
  final String? estSellVolComment;
  final String? plannedExchangeRateComment;
  final String? createdBy;
  final String? createdOn;
  final String? approvedBy;
  final String? approvedOn;
  @override
  List<Object> get props => [
        productionCountry ?? "",
        productionPlant ?? "",
        isStepOneCompleted ?? false,
        simStatus ?? "",
        createdBy ?? "",
        createdOn ?? "",
        approvedBy ?? "",
        approvedOn ?? "",
        isMetricsSelected ?? true,
        customerNameList ?? [],
        loadingStatus ?? LoadingStatus.initial,
        createSimLoadingStatus ?? LoadingStatus.initial,
        businessUnit ?? "",
        userName ?? "",
        itemName ?? "",
        fxLineResp ?? FxLineModel(),
        createSimResp ?? CreateSimulatorModel(),
        itemDescription ?? "",
        productionLocation ?? "",
        sellVolume ?? "",
        deliveredTo ?? "",
        packSize ?? "",
        packUom ?? "",
        sellVolumeUnit ?? "",
        linksPerPack ?? "",
        packsPerCase ?? "",
        itemCurrency ?? "",
        itemCurrencyValue ?? "",
        sellCurrency ?? "",
        sellCurrencyValue ?? "",
        consumerCurrency ?? "",
        consumerCurrencyValue ?? "",
        plannedExchangeRate ?? "",
        // jvlSubsidiarySale ?? "",
        subsidiaryId ?? "",
        customerName ?? "",
        costSimulatorId ?? "",
        dropDownCurrencyList ?? [],
        dropDownProdLocList ?? [],
        dropDownProdCountryList ?? [],
        dropDownBusinessUnitList ?? [],
        dropDownProdPlantList ?? [],
        dropDownDeliverToList ?? [],
        dropDownSubsidiaryList ?? [],
        dropDownJvlCurrencyList ?? [],
        dropDownSellCurrencyToConsumerList ?? [],
        unitMeasureList ?? [],
        loadCostSimulatorResp ?? LoadCostSimulatorModel(),
        estSellVolComment ?? "",
        plannedExchangeRateComment ?? "",
      ];
  StepOneState copyWith({
    bool? isStepOneCompleted,
    bool? isMetricsSelected,
    CreateSimulatorModel? createSimResp,
    LoadingStatus? loadingStatus,
    LoadingStatus? createSimLoadingStatus,
    FxLineModel? fxLineResp,
    String? userName,
    BusinessUnit? businessUnit,
    ProductionCountry? productionCountry,
    ProductionPlant? productionPlant,
    String? itemName,
    String? itemDescription,
    String? simStatus,
    String? createdBy,
    String? createdOn,
    String? approvedBy,
    String? approvedOn,
    ProfitCenter? productionLocation,
    String? sellVolume,
    DeliveryCountry? deliveredTo,
    String? packSize,
    String? packUom,
    String? sellVolumeUnit,
    String? linksPerPack,
    String? packsPerCase,
    Currency? itemCurrency,
    String? itemCurrencyValue,
    Currency? sellCurrency,
    String? sellCurrencyValue,
    Currency? consumerCurrency,
    String? consumerCurrencyValue,
    String? plannedExchangeRate,
    // Subsidiary? jvlSubsidiarySale,
    Subsidiary? subsidiaryId,
    String? customerName,
    String? costSimulatorId,
    List<String>? customerNameList,
    List<Currency>? dropDownCurrencyList,
    List<ProfitCenter>? dropDownProdLocList,
    List<ProductionCountry>? dropDownProdCountryList,
    List<BusinessUnit>? dropDownBusinessUnitList,
    List<ProductionPlant>? dropDownProdPlantList,
    List<DeliveryCountry>? dropDownDeliverToList,
    List<Subsidiary>? dropDownSubsidiaryList,
    List<Currency>? dropDownJvlCurrencyList,
    List<Currency>? dropDownSellCurrencyToConsumerList,
    List<String>? unitMeasureList,
    LoadCostSimulatorModel? loadCostSimulatorResp,
    String? estSellVolComment,
    String? plannedExchangeRateComment,
  }) {
    return StepOneState(
      customerNameList: customerNameList ?? this.customerNameList,
      createdBy: createdBy ?? this.createdBy,
      businessUnit: businessUnit ?? this.businessUnit,
      productionCountry: productionCountry ?? this.productionCountry,
      productionPlant: productionPlant ?? this.productionPlant,
      createdOn: createdOn ?? this.createdOn,
      approvedBy: approvedBy ?? this.approvedBy,
      approvedOn: approvedOn ?? this.approvedOn,
      isStepOneCompleted: isStepOneCompleted ?? this.isStepOneCompleted,
      isMetricsSelected: isMetricsSelected ?? this.isMetricsSelected,
      userName: userName ?? this.userName,
      createSimResp: createSimResp ?? this.createSimResp,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      createSimLoadingStatus:
          createSimLoadingStatus ?? this.createSimLoadingStatus,
      itemName: itemName ?? this.itemName,
      simStatus: simStatus ?? this.simStatus,
      fxLineResp: fxLineResp ?? this.fxLineResp,
      itemDescription: itemDescription ?? this.itemDescription,
      productionLocation: productionLocation ?? this.productionLocation,
      sellVolume: sellVolume ?? this.sellVolume,
      deliveredTo: deliveredTo ?? this.deliveredTo,
      packSize: packSize ?? this.packSize,
      packUom: packUom ?? this.packUom,
      sellVolumeUnit: sellVolumeUnit ?? this.sellVolumeUnit,
      linksPerPack: linksPerPack ?? this.linksPerPack,
      packsPerCase: packsPerCase ?? this.packsPerCase,
      itemCurrency: itemCurrency ?? this.itemCurrency,
      itemCurrencyValue: itemCurrencyValue ?? this.itemCurrencyValue,
      sellCurrency: sellCurrency ?? this.sellCurrency,
      sellCurrencyValue: sellCurrencyValue ?? this.sellCurrencyValue,
      consumerCurrency: consumerCurrency ?? this.consumerCurrency,
      consumerCurrencyValue:
          consumerCurrencyValue ?? this.consumerCurrencyValue,
      plannedExchangeRate: plannedExchangeRate ?? this.plannedExchangeRate,
      // jvlSubsidiarySale: jvlSubsidiarySale ?? this.jvlSubsidiarySale,
      subsidiaryId: subsidiaryId ?? this.subsidiaryId,
      customerName: customerName ?? this.customerName,
      costSimulatorId: costSimulatorId ?? this.costSimulatorId,
      dropDownCurrencyList: dropDownCurrencyList ?? this.dropDownCurrencyList,
      dropDownProdLocList: dropDownProdLocList ?? this.dropDownProdLocList,
      dropDownProdCountryList:
          dropDownProdCountryList ?? this.dropDownProdCountryList,
      dropDownBusinessUnitList:
          dropDownBusinessUnitList ?? this.dropDownBusinessUnitList,
      dropDownProdPlantList:
          dropDownProdPlantList ?? this.dropDownProdPlantList,
      dropDownDeliverToList:
          dropDownDeliverToList ?? this.dropDownDeliverToList,
      dropDownSubsidiaryList:
          dropDownSubsidiaryList ?? this.dropDownSubsidiaryList,
      dropDownJvlCurrencyList:
          dropDownJvlCurrencyList ?? this.dropDownJvlCurrencyList,
      dropDownSellCurrencyToConsumerList: dropDownSellCurrencyToConsumerList ??
          this.dropDownSellCurrencyToConsumerList,
      unitMeasureList: unitMeasureList ?? this.unitMeasureList,
      loadCostSimulatorResp:
          loadCostSimulatorResp ?? this.loadCostSimulatorResp,
      estSellVolComment: estSellVolComment ?? this.estSellVolComment,
      plannedExchangeRateComment:
          plannedExchangeRateComment ?? this.plannedExchangeRateComment,
    );
  }
}

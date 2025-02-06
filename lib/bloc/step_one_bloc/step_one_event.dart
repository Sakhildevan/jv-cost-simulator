part of 'step_one_bloc.dart';

sealed class StepOneEvent extends Equatable {
  const StepOneEvent();

  @override
  List<Object> get props => [];
}

//*--------------(item info update)
class ItemInfoUpdateValue extends StepOneEvent {
  const ItemInfoUpdateValue({
    this.itemName,
    this.itemDescription,
    this.productionLocation,
    this.productionCountry,
    this.productionPlant,
    this.businessUnit,
  });
  final String? itemName;
  final String? itemDescription;
  final ProfitCenter? productionLocation;
  final ProductionCountry? productionCountry;
  final ProductionPlant? productionPlant;
  final BusinessUnit? businessUnit;
}

//*--------------(production plant update)
class ProdPlantUpdate extends StepOneEvent {
  const ProdPlantUpdate({
    required this.productionCountry,
  });
  final ProductionCountry? productionCountry;
}

//*--------------(provide sell volume update)
class ProvideSellVolumeUpdateValue extends StepOneEvent {
  const ProvideSellVolumeUpdateValue({
    this.deliveredTo,
    this.sellVolume,
    this.estSellVolComment,
    this.sellVolumeUnit,
  });
  final String? sellVolume;
  final DeliveryCountry? deliveredTo;
  final String? estSellVolComment;
  final String? sellVolumeUnit;
}

//*---------------(enter item detail)
class EnterItemDetailUpdate extends StepOneEvent {
  const EnterItemDetailUpdate({
    this.packSize,
    this.packUom,
    this.linksPerPack,
    this.packsPerCase,
    this.currency,
  });
  final String? packSize;
  final String? packUom;
  final String? linksPerPack;
  final String? packsPerCase;
  final Currency? currency;
}

//*-------------(provide sell detail)
class ProvideSellDetailUpdate extends StepOneEvent {
  const ProvideSellDetailUpdate({
    this.customerName,
    this.subsidiaryId,
  });
  final Subsidiary? subsidiaryId;
  final String? customerName;
}

//*------------(Customer name add)
class CustomerNameAdd extends StepOneEvent {
  const CustomerNameAdd();
}

//*------------(Customer name remove)
class CustomerNameRemove extends StepOneEvent {
  const CustomerNameRemove(this.index);
  final int index;
}

//*------------(item reference data update)
class ItemReferenceDataUpdate extends StepOneEvent {
  const ItemReferenceDataUpdate();
}

//*------------(Provide delivery information update)
class ProvideDeliveryInfoUpdate extends StepOneEvent {
  const ProvideDeliveryInfoUpdate({
    this.sellCurrency,
    this.consumerCurrency,
    this.plannedExchangeRate,
    this.plannedExchangeRateComment,
  });
  final Currency? sellCurrency;
  final Currency? consumerCurrency;
  final String? plannedExchangeRate;
  final String? plannedExchangeRateComment;
}

class StepOneInitial extends StepOneEvent {
  final String? simId;
  const StepOneInitial({
    this.simId,
  });
}

class CheckMetrics extends StepOneEvent {
  final String? sellVolumeUnit;
  final String? packUom;
  const CheckMetrics({
    this.sellVolumeUnit,
    this.packUom,
  });
}

class OnNextTap extends StepOneEvent {
  const OnNextTap();
}

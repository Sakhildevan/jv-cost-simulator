import 'package:equatable/equatable.dart';

import '../../screens/step_two/step_two_widgets/tax_margin_box.dart';
import 'load_simulator.model.dart';

class CostSimulatorDetails extends Equatable {
  final String costSimulatorId;
  final String subsidiaryTrade;
  final String itemCurrency;
  final String advConsumer;
  final String tradeSpend;
  final String peopleAndOthers;
  final String jvlSellPriceForeignCurr;
  final String jvlSellPriceUsd;
  final String discountsPromo;
  final String discountsCustomer;
  final String importFees;
  final String localTransport;
  final String foreignSupplyChain;
  final String usDelivery;
  final String usSupplyChain;
  final String isTaxIncludedSelection;
  final String isYourStdCostDiffFromAbove;
  final String taxIncludedInShelfPrice;
  final String shelfPriceTax;
  final String standardCost;
  final String calculatedStandardCost;
  final String cosMeatPpv;
  final String cosMfgVariance;
  final UnitMeasure? sellUnitOfMeasure;
  final Other? cosOther;
  final Other? sellPriceDiscountOther;
  final Other? deliverySupplyChainOther;
  final Other? sellingExpensesOther;
  final String estDistributorMarginOn;
  final String localTaxVat;
  final String retailerMargin;
  final String isOtherSelected;
  final String isDeliveryOtherSelected;
  final String isSellingExpenseOtherSelected;
  final String isSellPriceDisOtherSelected;
  final String packUOM;
  final String broker;
  final int othersLimit;
  final List<Other>? cosOtherList;
  final List<Other>? sellDiscountOtherList;
  final List<Other>? deliverySupplyOtherList;
  final List<Other>? sellExpenseOtherList;

  const CostSimulatorDetails({
    this.costSimulatorId = '',
    this.subsidiaryTrade = '',
    this.itemCurrency = '',
    this.advConsumer = '',
    this.tradeSpend = '',
    this.broker = '',
    this.peopleAndOthers = '',
    this.jvlSellPriceForeignCurr = '',
    this.jvlSellPriceUsd = '',
    this.discountsPromo = '',
    this.discountsCustomer = '',
    this.importFees = '',
    this.localTransport = '',
    this.foreignSupplyChain = '',
    this.usDelivery = '',
    this.usSupplyChain = '',
    this.isTaxIncludedSelection = '',
    this.isYourStdCostDiffFromAbove = '',
    this.taxIncludedInShelfPrice = '',
    this.shelfPriceTax = '',
    this.standardCost = '',
    this.calculatedStandardCost = '',
    this.cosMeatPpv = '',
    this.cosMfgVariance = '',
    this.sellUnitOfMeasure,
    this.cosOther,
    this.othersLimit = 0,
    this.sellPriceDiscountOther,
    this.deliverySupplyChainOther,
    this.sellingExpensesOther,
    this.estDistributorMarginOn = '',
    this.localTaxVat = '',
    this.packUOM = '',
    this.retailerMargin = '',
    this.isOtherSelected = '',
    this.isDeliveryOtherSelected = '',
    this.isSellingExpenseOtherSelected = '',
    this.isSellPriceDisOtherSelected = '',
    this.cosOtherList,
    this.sellDiscountOtherList,
    this.deliverySupplyOtherList,
    this.sellExpenseOtherList,
  });

  CostSimulatorDetails copyWith({
    String? costSimulatorId,
    String? subsidiaryTrade,
    String? itemCurrency,
    String? advConsumer,
    String? tradeSpend,
    String? broker,
    String? peopleAndOthers,
    String? jvlSellPriceForeignCurr,
    String? jvlSellPriceUsd,
    String? discountsPromo,
    String? discountsCustomer,
    String? importFees,
    int? othersLimit,
    String? localTransport,
    String? foreignSupplyChain,
    String? usDelivery,
    String? usSupplyChain,
    String? isTaxIncludedSelection,
    String? isYourStdCostDiffFromAbove,
    String? taxIncludedInShelfPrice,
    String? shelfPriceTax,
    String? standardCost,
    String? calculatedStandardCost,
    String? cosMeatPpv,
    String? cosMfgVariance,
    UnitMeasure? sellUnitOfMeasure,
    Other? cosOther,
    Other? sellPriceDiscountOther,
    Other? deliverySupplyChainOther,
    Other? sellingExpensesOther,
    String? estDistributorMarginOn,
    String? localTaxVat,
    String? packUOM,
    String? retailerMargin,
    String? isOtherSelected,
    String? isDeliveryOtherSelected,
    String? isSellingExpenseOtherSelected,
    String? isSellPriceDisOtherSelected,
    List<Other>? cosOtherList,
    List<Other>? sellDiscountOtherList,
    List<Other>? deliverySupplyOtherList,
    List<Other>? sellExpenseOtherList,
  }) {
    return CostSimulatorDetails(
      cosOtherList: cosOtherList ?? this.cosOtherList,
      sellDiscountOtherList:
          sellDiscountOtherList ?? this.sellDiscountOtherList,
      deliverySupplyOtherList:
          deliverySupplyOtherList ?? this.deliverySupplyOtherList,
      sellExpenseOtherList: sellExpenseOtherList ?? this.sellExpenseOtherList,
      costSimulatorId: costSimulatorId ?? this.costSimulatorId,
      subsidiaryTrade: subsidiaryTrade ?? this.subsidiaryTrade,
      itemCurrency: itemCurrency ?? this.itemCurrency,
      advConsumer: advConsumer ?? this.advConsumer,
      tradeSpend: tradeSpend ?? this.tradeSpend,
      broker: broker ?? this.broker,
      othersLimit: othersLimit ?? this.othersLimit,
      peopleAndOthers: peopleAndOthers ?? this.peopleAndOthers,
      jvlSellPriceForeignCurr:
          jvlSellPriceForeignCurr ?? this.jvlSellPriceForeignCurr,
      jvlSellPriceUsd: jvlSellPriceUsd ?? this.jvlSellPriceUsd,
      discountsPromo: discountsPromo ?? this.discountsPromo,
      discountsCustomer: discountsCustomer ?? this.discountsCustomer,
      importFees: importFees ?? this.importFees,
      localTransport: localTransport ?? this.localTransport,
      foreignSupplyChain: foreignSupplyChain ?? this.foreignSupplyChain,
      usDelivery: usDelivery ?? this.usDelivery,
      usSupplyChain: usSupplyChain ?? this.usSupplyChain,
      isTaxIncludedSelection:
          isTaxIncludedSelection ?? this.isTaxIncludedSelection,
      isYourStdCostDiffFromAbove:
          isYourStdCostDiffFromAbove ?? this.isYourStdCostDiffFromAbove,
      taxIncludedInShelfPrice:
          taxIncludedInShelfPrice ?? this.taxIncludedInShelfPrice,
      shelfPriceTax: shelfPriceTax ?? this.shelfPriceTax,
      standardCost: standardCost ?? this.standardCost,
      calculatedStandardCost:
          calculatedStandardCost ?? this.calculatedStandardCost,
      cosMeatPpv: cosMeatPpv ?? this.cosMeatPpv,
      cosMfgVariance: cosMfgVariance ?? this.cosMfgVariance,
      sellUnitOfMeasure: sellUnitOfMeasure ?? this.sellUnitOfMeasure,
      cosOther: cosOther ?? this.cosOther,
      sellPriceDiscountOther:
          sellPriceDiscountOther ?? this.sellPriceDiscountOther,
      deliverySupplyChainOther:
          deliverySupplyChainOther ?? this.deliverySupplyChainOther,
      sellingExpensesOther: sellingExpensesOther ?? this.sellingExpensesOther,
      isOtherSelected: isOtherSelected ?? this.isOtherSelected,
      isDeliveryOtherSelected:
          isDeliveryOtherSelected ?? this.isDeliveryOtherSelected,
      isSellingExpenseOtherSelected:
          isSellingExpenseOtherSelected ?? this.isSellingExpenseOtherSelected,
      isSellPriceDisOtherSelected:
          isSellPriceDisOtherSelected ?? this.isSellPriceDisOtherSelected,
      estDistributorMarginOn:
          estDistributorMarginOn ?? this.estDistributorMarginOn,
      localTaxVat: localTaxVat ?? this.localTaxVat,
      packUOM: packUOM ?? this.packUOM,
      retailerMargin: retailerMargin ?? this.retailerMargin,
    );
  }

  @override
  List<Object?> get props => [
        costSimulatorId,
        cosOtherList ?? [],
        subsidiaryTrade,
        itemCurrency,
        advConsumer,
        tradeSpend,
        broker,
        peopleAndOthers,
        jvlSellPriceForeignCurr,
        jvlSellPriceUsd,
        discountsPromo,
        discountsCustomer,
        importFees,
        localTransport,
        foreignSupplyChain,
        usDelivery,
        usSupplyChain,
        isTaxIncludedSelection,
        isYourStdCostDiffFromAbove,
        taxIncludedInShelfPrice,
        shelfPriceTax,
        standardCost,
        calculatedStandardCost,
        cosMeatPpv,
        cosMfgVariance,
        sellUnitOfMeasure,
        cosOther,
        othersLimit,
        sellDiscountOtherList,
        deliverySupplyOtherList,
        sellExpenseOtherList,
        sellPriceDiscountOther,
        deliverySupplyChainOther,
        sellingExpensesOther,
        estDistributorMarginOn,
        localTaxVat,
        packUOM,
        retailerMargin,
        isOtherSelected,
        isSellPriceDisOtherSelected,
        isDeliveryOtherSelected,
        isSellingExpenseOtherSelected,
      ];
}

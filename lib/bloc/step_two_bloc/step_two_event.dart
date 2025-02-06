part of 'step_two_bloc.dart';

class StepTwoEvent extends Equatable {
  const StepTwoEvent();

  @override
  List<Object> get props => [];
}

class ShowOthersValue extends StepTwoEvent {
  final bool isYesTapped;
  const ShowOthersValue({required this.isYesTapped});

  @override
  List<Object> get props => [isYesTapped];
}

class NoShowOthersValue extends StepTwoEvent {
  final bool isNoTapped;
  const NoShowOthersValue({required this.isNoTapped});

  @override
  List<Object> get props => [isNoTapped];
}

class StepTwoInitial extends StepTwoEvent {
  const StepTwoInitial({this.id});
  final String? id;
}

class RetailTaxAndMargin extends StepTwoEvent {
  final String? isTaxIncludedSelection;
  final String? taxIncludedInShelfPrice;
  final String? shelfPriceTax;
  final String? taxAndMarginsComment;
  final UnitMeasure? sellUnitOfMeasure;
  // final String? retailMarginOnSalesComment;

  const RetailTaxAndMargin({
    this.isTaxIncludedSelection,
    this.taxIncludedInShelfPrice,
    this.shelfPriceTax,
    this.taxAndMarginsComment,
    this.sellUnitOfMeasure,
    // this.retailMarginOnSalesComment,
  });
}

//*------------(Other add)
class OtherListAdd extends StepTwoEvent {
  const OtherListAdd({
    required this.otherType,
  });
  final OtherType otherType;
}

//*------------(Other remove)
class OtherListRemove extends StepTwoEvent {
  const OtherListRemove({
    required this.index,
    required this.otherType,
  });
  final int index;
  final OtherType otherType;
}

class SaveComment extends StepTwoEvent {
  final String? commentFieldName;
  final String? commentDescription;

  const SaveComment({
    required this.commentFieldName,
    required this.commentDescription,
  });
}

class CostOfSales extends StepTwoEvent {
  final String? standardCost;
  // final String? standardCostComment;
  final String? cosMeatPpv;
  // final String? cosMeatPpvComment;
  final String? cosMfgVariance;
  // final String? cosMfgVarianceComment;
  final Other? cosOther;
  // final String? cosOthersComment;
  final String? coscostofSalesComment;
  final String? isYourStdCostDiffFromAbove;
  final String? calculatedStandardCost;

  final String? isOtherSelected;
  const CostOfSales({
    this.standardCost,
    this.calculatedStandardCost,
    // this.standardCostComment,
    this.cosMeatPpv,
    // this.cosMeatPpvComment,
    this.cosMfgVariance,
    // this.cosMfgVarianceComment,
    this.cosOther,
    // this.cosOthersComment,
    this.isOtherSelected,
    this.coscostofSalesComment,
    this.isYourStdCostDiffFromAbove,
  });
}

class DistributorMarginImport extends StepTwoEvent {
  final String? estDistributorMarginOn;
  final String? localTaxVat;
  final String? retailerMargin;
  // final String? estDistributorMarginOnComment;

  const DistributorMarginImport({
    this.estDistributorMarginOn,
    this.localTaxVat,
    this.retailerMargin,
    // this.estDistributorMarginOnComment,
  });
}

class DeliveryAndSupplyChain extends StepTwoEvent {
  final String? importFees;
  // final String? importFeesComment;
  final String? localTransport;
  // final String? localTransportComment;
  final String? foreignSupplyChain;
  // final String? foreignSupplyChainComment;
  final String? usDelivery;
  // final String? usDeliveryComment;
  final String? usSupplyChain;
  // final String? usSupplyChainComment;
  final Other? deliverySupplyChainOthers;
  final String? isOtherSelected;
  // final String? deliverySupplyChainOthersCmmnt;
  final String? deliveryandSuppChainComment;

  const DeliveryAndSupplyChain({
    this.importFees,
    // this.importFeesComment,
    this.localTransport,
    // this.localTransportComment,
    this.foreignSupplyChain,
    // this.foreignSupplyChainComment,
    this.usDelivery,
    // this.usDeliveryComment,
    this.usSupplyChain,
    // this.usSupplyChainComment,
    this.deliverySupplyChainOthers,
    this.isOtherSelected,
    // this.deliverySupplyChainOthersCmmnt,
    this.deliveryandSuppChainComment,
  });
}

class JvlSellPriceAndDiscounts extends StepTwoEvent {
  final String? jvlSellPriceForeignCurr;
  // final String? jvlSellPriceForeignCurrComment;
  final String? jvlSellPriceUsd;
  // final String? jvlSellPriceUsdComment;
  final String? discountsPromo;
  // final String? discountsPromoComment;
  final String? discountsCustomer;
  // final String? discountsCustomerComment;
  final Other? sellPriceDiscountOthers;
  final String? isOtherSelected;
  // final String? sellPriceDiscountOthersCmmnt;
  final String? sellPriceandDiscountComment;

  const JvlSellPriceAndDiscounts({
    this.jvlSellPriceForeignCurr,
    // this.jvlSellPriceForeignCurrComment,
    this.jvlSellPriceUsd,
    // this.jvlSellPriceUsdComment,
    this.discountsPromo,
    // this.discountsPromoComment,
    this.discountsCustomer,
    // this.discountsCustomerComment,
    this.sellPriceDiscountOthers,
    this.isOtherSelected,
    // this.sellPriceDiscountOthersCmmnt,
    this.sellPriceandDiscountComment,
  });
}

class SellingExpense extends StepTwoEvent {
  final String? subsidiaryTrade;
  // final String? subsidiaryTradeComment;
  final String? advConsumer;
  // final String? advConsumerComment;
  final String? tradeSpend;
  final String? broker;
  // final String? tradeSpendComment;
  final String? peopleAndOthers;
  // final String? peopleAndOthersComment;
  final Other? sellingExpensesOthers;
  final String? isOtherSelected;
  // final String? sellingExpensesOthersCmmnt;
  final String? sellingExpensesComment;

  const SellingExpense({
    this.subsidiaryTrade,
    // this.subsidiaryTradeComment,
    this.advConsumer,
    // this.advConsumerComment,
    this.tradeSpend,
    // this.tradeSpendComment,
    this.peopleAndOthers,
    this.broker,
    // this.peopleAndOthersComment,
    this.sellingExpensesOthers,
    this.isOtherSelected,
    // this.sellingExpensesOthersCmmnt,
    this.sellingExpensesComment,
  });
}

class ViewPricingSheet extends StepTwoEvent {
  const ViewPricingSheet();
}

class StepTwoSave extends StepTwoEvent {
  const StepTwoSave();
}

class CommentChecker extends StepTwoEvent {
  const CommentChecker();
}

class CalculateCostOfSales extends StepTwoEvent {
  const CalculateCostOfSales();
}

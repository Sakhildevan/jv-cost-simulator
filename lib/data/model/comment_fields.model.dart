import 'package:equatable/equatable.dart';

class CommentFields extends Equatable {
  // final String retailMarginComment;
  // final String stdCostComment;
  // final String meatPpvComment;
  // final String mgfVarianceComment;
  // final String estDistMarginComment;
  // final String importFeesComment;
  // final String localTransportComment;
  // final String foreignSupplyChainComment;
  // final String usDeliveryComment;
  // final String usSupplyChainComment;
  // final String jvlSellPriceForeignCurrencyComment;
  // final String jvlSellPriceUsdComment;
  // final String discountPromoComment;
  // final String discountCustomerProgComment;
  // final String subsidiaryTradeComment;
  // final String advConsumerComment;
  // final String tradeSpendComment;
  // final String peopleOthersComment;
  // final String cosOthersComment;
  // final String sellPriceDiscountOthersCmmnt;
  // final String deliverySupplyChainOthersCmmnt;
  // final String sellingExpensesOthersCmmnt;
  final String taxAndMarginsComment;
  final String costofSalesComment;
  final String sellPriceandDiscountComment;
  final String deliveryandSuppChainComment;
  final String sellingExpensesComment;

  const CommentFields({
    // this.retailMarginComment = '',
    // this.stdCostComment = '',
    // this.meatPpvComment = '',
    // this.mgfVarianceComment = '',
    // this.estDistMarginComment = '',
    // this.importFeesComment = '',
    // this.localTransportComment = '',
    // this.foreignSupplyChainComment = '',
    // this.usDeliveryComment = '',
    // this.usSupplyChainComment = '',
    // this.jvlSellPriceForeignCurrencyComment = '',
    // this.jvlSellPriceUsdComment = '',
    // this.discountPromoComment = '',
    // this.discountCustomerProgComment = '',
    // this.subsidiaryTradeComment = '',
    // this.advConsumerComment = '',
    // this.tradeSpendComment = '',
    // this.peopleOthersComment = '',
    // this.cosOthersComment = '',
    // this.sellPriceDiscountOthersCmmnt = '',
    // this.deliverySupplyChainOthersCmmnt = '',
    // this.sellingExpensesOthersCmmnt = '',
    this.taxAndMarginsComment = '',
    this.costofSalesComment = '',
    this.sellPriceandDiscountComment = '',
    this.deliveryandSuppChainComment = '',
    this.sellingExpensesComment = '',
  });

  CommentFields copyWith({
    // String? retailMarginComment,
    // String? stdCostComment,
    // String? meatPpvComment,
    // String? mgfVarianceComment,
    // String? estDistMarginComment,
    // String? importFeesComment,
    // String? localTransportComment,
    // String? foreignSupplyChainComment,
    // String? usDeliveryComment,
    // String? usSupplyChainComment,
    // String? jvlSellPriceForeignCurrencyComment,
    // String? jvlSellPriceUsdComment,
    // String? discountPromoComment,
    // String? discountCustomerProgComment,
    // String? subsidiaryTradeComment,
    // String? advConsumerComment,
    // String? tradeSpendComment,
    // String? peopleOthersComment,
    // String? cosOthersComment,
    // String? sellPriceDiscountOthersCmmnt,
    // String? deliverySupplyChainOthersCmmnt,
    // String? sellingExpensesOthersCmmnt,
    String? taxAndMarginsComment,
    String? costofSalesComment,
    String? sellPriceandDiscountComment,
    String? deliveryandSuppChainComment,
    String? sellingExpensesComment,
  }) {
    return CommentFields(
      // retailMarginComment: retailMarginComment ?? this.retailMarginComment,
      // stdCostComment: stdCostComment ?? this.stdCostComment,
      // cosOthersComment: cosOthersComment ?? this.cosOthersComment,
      // sellPriceDiscountOthersCmmnt:
      //     sellPriceDiscountOthersCmmnt ?? this.sellPriceDiscountOthersCmmnt,
      // deliverySupplyChainOthersCmmnt:
      //     deliverySupplyChainOthersCmmnt ?? this.deliverySupplyChainOthersCmmnt,
      // sellingExpensesOthersCmmnt:
      //     sellingExpensesOthersCmmnt ?? this.sellingExpensesOthersCmmnt,
      // meatPpvComment: meatPpvComment ?? this.meatPpvComment,
      // mgfVarianceComment: mgfVarianceComment ?? this.mgfVarianceComment,
      // estDistMarginComment: estDistMarginComment ?? this.estDistMarginComment,
      // importFeesComment: importFeesComment ?? this.importFeesComment,
      // localTransportComment:
      //     localTransportComment ?? this.localTransportComment,
      // foreignSupplyChainComment:
      //     foreignSupplyChainComment ?? this.foreignSupplyChainComment,
      // usDeliveryComment: usDeliveryComment ?? this.usDeliveryComment,
      // usSupplyChainComment: usSupplyChainComment ?? this.usSupplyChainComment,
      // jvlSellPriceForeignCurrencyComment: jvlSellPriceForeignCurrencyComment ??
      //     this.jvlSellPriceForeignCurrencyComment,
      // jvlSellPriceUsdComment:
      //     jvlSellPriceUsdComment ?? this.jvlSellPriceUsdComment,
      // discountPromoComment: discountPromoComment ?? this.discountPromoComment,
      // discountCustomerProgComment:
      //     discountCustomerProgComment ?? this.discountCustomerProgComment,
      // subsidiaryTradeComment:
      //     subsidiaryTradeComment ?? this.subsidiaryTradeComment,
      // advConsumerComment: advConsumerComment ?? this.advConsumerComment,
      // tradeSpendComment: tradeSpendComment ?? this.tradeSpendComment,
      // peopleOthersComment: peopleOthersComment ?? this.peopleOthersComment,
      taxAndMarginsComment: taxAndMarginsComment ?? this.taxAndMarginsComment,
      costofSalesComment: costofSalesComment ?? this.costofSalesComment,
      sellPriceandDiscountComment:
          sellPriceandDiscountComment ?? this.sellPriceandDiscountComment,
      deliveryandSuppChainComment:
          deliveryandSuppChainComment ?? this.deliveryandSuppChainComment,
      sellingExpensesComment:
          sellingExpensesComment ?? this.sellingExpensesComment,
    );
  }

  @override
  List<Object?> get props => [
        // retailMarginComment,
        // stdCostComment,
        // cosOthersComment,
        // sellPriceDiscountOthersCmmnt,
        // deliverySupplyChainOthersCmmnt,
        // sellingExpensesOthersCmmnt,
        // meatPpvComment,
        // mgfVarianceComment,
        // estDistMarginComment,
        // importFeesComment,
        // localTransportComment,
        // foreignSupplyChainComment,
        // usDeliveryComment,
        // usSupplyChainComment,
        // jvlSellPriceForeignCurrencyComment,
        // jvlSellPriceUsdComment,
        // discountPromoComment,
        // discountCustomerProgComment,
        // subsidiaryTradeComment,
        // advConsumerComment,
        // tradeSpendComment,
        // peopleOthersComment,
        taxAndMarginsComment,
        costofSalesComment,
        sellPriceandDiscountComment,
        deliveryandSuppChainComment,
        sellingExpensesComment,
      ];
}

import 'pricing_worksheet.model.dart';

var dummyData = const PricingWorkSheetModel(
  isSuccess: true,
  pricingWorksheetSegmentItems: PricingWorksheetSegmentItems(
    title: "PRICING WORKSHEET",
    month: "September 2024",
    lastupdatedon: ' 13 Sep 2024, 08:47 AM',
    customer: 'Canada West 3PL',
    pricingWorksheetTableHeadings: PricingWorksheetTableHeadings(
      itemDetailsVolume: "ITEM DETAILS & VOLUME",
      usdBasis: " USD BASIS",
      foreignCurrencyCadBasis: "FOREIGN CURRENCY - CAD BASIS",
    ),
    pricingWorksheetSubTableHeadings: PricingWorksheetSubTableHeadings(
        itemNameDescription: "Alginate Products  Mild Italia",
        valueInUsd: "Value in USD",
        volumeLevelUsd: "Volume Level (USD/lb)",
        packageLevelUsd: "Package Level (USD/Pack)",
        caseLevelUsd: "CaseLevel (USD/Case)",
        linkLevelUsd: "LinkLevel (USD/Link)",
        volumeLevelCad: " Volume Level (CAD)",
        packageLevelCad: "Package Level (CAD)",
        caseLevelCad: "CaseLevel (CAD)",
        linkLevelCad: "LinkLevel (CAD/Link)"),
    calculatedshelfprice: Calculatedshelfprice(
      title: "Calculated Shelf Price",
      data: [
        Datum(
            component: null,
            valInUsd: null,
            isEditable1: false,
            volLvlUsd: "7.71%",
            isEditable2: false,
            packlvlUsd: "6.37",
            isEditable3: false,
            caselvlUsd: "1.06",
            isEditable4: false,
            linklvlUsd: "10.41",
            isEditable5: false,
            vollvlCad: "8.60",
            isEditable6: false,
            packlvlCad: "0.00",
            isEditable7: false,
            caselvlCad: "1.43",
            isEditable8: false,
            linklvlCad: "0.00",
            isEditable9: false),
      ],
    ),
    retailTaxMargin: Calculatedshelfprice(
      title: "Retail Tax* & Margins",
      data: [
        Datum(
            component: 'Tax included in Shelf Price',
            valInUsd: '30%',
            isEditable1: true,
            volLvlUsd: "7.71%",
            isEditable2: false,
            packlvlUsd: "6.37",
            isEditable3: false,
            caselvlUsd: "1.06",
            isEditable4: false,
            linklvlUsd: "10.41",
            isEditable5: false,
            vollvlCad: "8.60",
            isEditable6: false,
            packlvlCad: "0.00",
            isEditable7: false,
            caselvlCad: "1.43",
            isEditable8: false,
            linklvlCad: "0.00",
            isEditable9: false),
        Datum(
            component: 'Retail margin on sales',
            valInUsd: '30%',
            isEditable1: true,
            volLvlUsd: "7.71%",
            isEditable2: false,
            packlvlUsd: "6.37",
            isEditable3: false,
            caselvlUsd: "1.06",
            isEditable4: false,
            linklvlUsd: "10.41",
            isEditable5: false,
            vollvlCad: "8.60",
            isEditable6: false,
            packlvlCad: "0.00",
            isEditable7: false,
            caselvlCad: "1.43",
            isEditable8: false,
            linklvlCad: "0.00",
            isEditable9: false),
        Datum(
            component: 'Price to Retailer',
            valInUsd: null,
            isEditable1: false,
            volLvlUsd: "7.71%",
            isEditable2: false,
            packlvlUsd: "6.37",
            isEditable3: false,
            caselvlUsd: "1.06",
            isEditable4: false,
            linklvlUsd: "10.41",
            isEditable5: false,
            vollvlCad: "8.60",
            isEditable6: false,
            packlvlCad: "0.00",
            isEditable7: false,
            caselvlCad: "1.43",
            isEditable8: false,
            linklvlCad: "0.00",
            isEditable9: false),
      ],
    ),
    distributorMargin: Calculatedshelfprice(
      title: "Distributor Margins & Import",
      data: [
        Datum(
            component: 'Est Distributor Margin on Sale',
            valInUsd: '19%',
            isEditable1: true,
            volLvlUsd: "7.71%",
            isEditable2: false,
            packlvlUsd: "6.37",
            isEditable3: false,
            caselvlUsd: "1.06",
            isEditable4: false,
            linklvlUsd: "10.41",
            isEditable5: false,
            vollvlCad: "8.60",
            isEditable6: false,
            packlvlCad: "0.00",
            isEditable7: false,
            caselvlCad: "1.43",
            isEditable8: false,
            linklvlCad: "0.00",
            isEditable9: false),
        Datum(
            component: 'Distributor Price from JVL',
            valInUsd: null,
            isEditable1: false,
            volLvlUsd: "7.71%",
            isEditable2: false,
            packlvlUsd: "6.37",
            isEditable3: false,
            caselvlUsd: "1.06",
            isEditable4: false,
            linklvlUsd: "10.41",
            isEditable5: false,
            vollvlCad: "8.60",
            isEditable6: false,
            packlvlCad: "0.00",
            isEditable7: false,
            caselvlCad: "1.43",
            isEditable8: false,
            linklvlCad: "0.00",
            isEditable9: false),
      ],
    ),
    jvlsellpricediscount: Calculatedshelfprice(
      title: "JVL Sell Price & Discounts",
      data: [
        Datum(
          component: 'JVL Sell Price-Foreign Curr',
          valInUsd: '524,444.44',
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
        Datum(
          component: 'JVL Sell Price-USD',
          valInUsd: null,
          isEditable1: false,
          volLvlUsd: "7.71%",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
        Datum(
          component: 'Discounts-Promo/JVL allow',
          valInUsd: '18,666.67',
          isEditable1: false,
          volLvlUsd: "7.71%",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
        Datum(
          component: 'Discounts-Customer Prog',
          valInUsd: '18,666.67',
          isEditable1: false,
          volLvlUsd: "7.71%",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
      ],
    ),
    netsales: Calculatedshelfprice(
      title: "NET SALES",
      data: [
        Datum(
          component: null,
          valInUsd: null,
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
      ],
    ),
    costofSales: Calculatedshelfprice(
      title: "Cost of Sales",
      data: [
        Datum(
          component: 'Standard Cost',
          valInUsd: '30%',
          isEditable1: true,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
        Datum(
          component: 'Meat PPV',
          valInUsd: '30%',
          isEditable1: true,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
        Datum(
          component: 'MGF Variance',
          valInUsd: '30%',
          isEditable1: true,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
        Datum(
          component: 'Others',
          valInUsd: '30%',
          isEditable1: true,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
      ],
    ),
    costotal: Calculatedshelfprice(
      title: "COST OF GOODS SOLD TOTAL",
      data: [
        Datum(
          component: null,
          valInUsd: null,
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
      ],
    ),
    deliveryAndSupplychain: Calculatedshelfprice(
      title: "Delivery & Supply Chain",
      data: [
        Datum(
          component: 'Import Fees',
          valInUsd: null,
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
        Datum(
          component: 'Local Transport',
          valInUsd: null,
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
        Datum(
          component: 'Foregn Supply Chain/Obsol',
          valInUsd: null,
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
        Datum(
          component: 'US Delivery',
          valInUsd: null,
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
        Datum(
          component: 'US Supply Chain',
          valInUsd: null,
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
      ],
    ),
    delsupplychainTotal: Calculatedshelfprice(
      title: "DELIVERY & SUPPLY CHAIN TOTAL",
      data: [
        Datum(
          component: null,
          valInUsd: null,
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
      ],
    ),
    grossProfit: Calculatedshelfprice(
      title: "GROSS PROFIT",
      data: [
        Datum(
          component: null,
          valInUsd: null,
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
      ],
    ),
    grossProfitpercent: Calculatedshelfprice(
      title: "GROSS PROFIT %",
      data: [
        Datum(
          component: null,
          valInUsd: null,
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
      ],
    ),
    sellingExpense: Calculatedshelfprice(
      title: "Selling Expenses",
      data: [
        Datum(
          component: 'Subsidiary Trade/Mktg',
          valInUsd: '0.00',
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
        Datum(
          component: 'Adv. & Consumer',
          valInUsd: '0.00',
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
        Datum(
          component: 'Trade Spend',
          valInUsd: '0.00',
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
        Datum(
          component: 'People & Others',
          valInUsd: '0.00',
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
      ],
    ),
    sellingExpenseTotal: Calculatedshelfprice(
      title: "SELLING EXPENSES TOTAL",
      data: [
        Datum(
          component: null,
          valInUsd: null,
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
      ],
    ),
    operatingProfit: Calculatedshelfprice(
      title: "OPERATING PROFIT",
      data: [
        Datum(
          component: null,
          valInUsd: null,
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
      ],
    ),
    operatingProfitpercent: Calculatedshelfprice(
      title: "OPERATING PROFIT %",
      data: [
        Datum(
          component: null,
          valInUsd: null,
          isEditable1: false,
          volLvlUsd: "4.37",
          isEditable2: false,
          packlvlUsd: "6.37",
          isEditable3: false,
          caselvlUsd: "1.06",
          isEditable4: false,
          linklvlUsd: "10.41",
          isEditable5: false,
          vollvlCad: "8.60",
          isEditable6: false,
          packlvlCad: "0.00",
          isEditable7: false,
          caselvlCad: "1.43",
          isEditable8: false,
          linklvlCad: "0.00",
          isEditable9: false,
        ),
      ],
    ),
  ),
);

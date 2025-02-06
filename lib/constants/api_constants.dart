class ApiConst {
  // ReCaptcha Key
  static const String reCaptchaKey = "6LeR0ZUpAAAAAIcZQMkqm_eFBHyw6oWXsH0j8NGu";
  //--------------------(login section)
  // login end point
  static const String loginEndpoint = "user/login/authenticate";
  //--------------------(create CostSimulator section)
  // create CostSimulator end point
  static const String createCostSimulatorEndPoint = "costsimulator/create";
  // create CostSimulator end point
  static const String createNewVersionCostSimEndPoint =
      "costsimulator/newversion";
  // create CostSimulator end point
  static const String generateVersionExcelEndPoint =
      "costsimulator/pricingworksheetVersionXL";
  // create CostSimulator end point
  static const String deleteVersionEndPoint = "costsimulator/deleteversion";
  // create CostSimulator end point
  static const String fetchVersionListSimEndPoint = "costsimulator/versionlist";
  // create step two simulator end point
  static const String createStepTwo = "costsimulator/createStep2";
  //-----------------(currency list)
  static const String currencyListEndPoint = 'masterlists/currency';
  //-----------------(comment field list end point)
  static const String commentFieldEndPoint = 'masterlists/commentfield';
  //-----------------(update field list end point)
  static const String updateFieldEndPoint = 'masterlists/updatefield';
  //-----------------(update sheet value end point)
  static const String updateSheetValueEndPoint =
      'costsimulator/savepricingworksheetvalue';
  //-----------------(comment field list end point)
  static const String saveCommentEndPoint = 'costsimulator/savecomment';
  //--------------------(cost simulator section)
  // cost simulator end point
  static const String costSimulatorEndpoint = "costsimulator/list";
  //--------------------(cost simulator section)
  // cost simulator end point
  static const String productionLocationEndPoint = "masterlists/profitcenter";
  // production country end point
  static const String productionCountryEndPoint =
      "masterlists/productioncountries";
  // business unit end point
  static const String businessUnitEndPoint = "masterlists/businessunits";
  // Subsidiary end point
  static const String subsidiaryEndPoint = "masterlists/subsidiary";
  static const String deliveryToEndPoint = "masterlists/deliveryto";
  // production plant end point
  static const String productionPlantEndPoint = "masterlists/productionplants";
  // cost simulator end point
  static const String pricingWorksheetEndPoint =
      "costsimulator/pricingworksheet";
  static const String pricingWorksheetV1EndPoint =
      "costsimulator/pricingworksheetV1";
  static const String pricingWorksheetV2EndPoint =
      "costsimulator/pricingworksheetV2";
  static const String pricingWorksheetV3EndPoint =
      "costsimulator/pricingworksheetV3";
  static const String pricingWorksheetV4EndPoint =
      "costsimulator/pricingworksheetV4";
  // cost simulator end point
  static const String replicateWorksheetEndPoint =
      "costsimulator/copysimulator";
  // cost simulator end point
  static const String createExcelEndPoint = "costsimulator/pricingworksheetXL";
  // create pdf end point
  static const String createPdfEndPoint = "costsimulator/pricingworksheetPDF";
  // cost simulator end point
  static const String completeEndPoint = "costsimulator/completedstatus";
  //--------------------(cost simulator section)
  static const String loadCostSimulatorEndpoint = "costsimulator/load";
  //--------------------(cost simulator section)
  static const String fxLineGraphEndPoint = "costsimulator/fxtrendlinegraph";
  //--------------------(Entity List section)
  static const String entityEndPoint = "masterlists/entities";
  //--------------------(Entity List section)
  static const String masterFilterEndPoint = "masterlists/costsimulatorfilters";
  //--------------------(Filter List section)
  static const String filterEndPoint = "masterlists/filters";
}

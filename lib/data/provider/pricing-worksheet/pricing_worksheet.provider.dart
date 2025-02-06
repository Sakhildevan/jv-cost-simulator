import 'package:johnsonville_cost_simulator/data/model/common_success_resp.model.dart';
import 'package:johnsonville_cost_simulator/data/service/pricing-worksheet/pricing_worksheet.service.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/generate_excel_resp.model.dart';
import '../../model/pricing_worksheet.model.dart';

class PricingWorkSheetProvider {
  final PricingWorkSheetService service =
      autoInjector.get<PricingWorkSheetService>();
  Future<PricingWorkSheetModel> getPricingWorkSheetData({
    required String costSimulatorId,
    required String userId,
    required String packUOM,
    required String retailSellPriceUOM,
  }) async {
    try {
      final response = await service.getPricingWorkSheetData(
        costSimulatorId: costSimulatorId,
        userId: userId,
        packUOM: packUOM,
        retailSellPriceUOM: retailSellPriceUOM,
      );

      final PricingWorkSheetModel model = PricingWorkSheetModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }

  Future<GenerateExcelRespModel> generateExcel({
    required String costSimulatorId,
    required String userId,
  }) async {
    try {
      final response = await service.generateExcel(
        costSimulatorId: costSimulatorId,
        userId: userId,
      );
      final GenerateExcelRespModel model = GenerateExcelRespModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }

  Future<GenerateExcelRespModel> generatePdf({
    required String costSimulatorId,
    required String userId,
  }) async {
    try {
      final response = await service.generatePdf(
        costSimulatorId: costSimulatorId,
        userId: userId,
      );
      final GenerateExcelRespModel model = GenerateExcelRespModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }

  Future<CommonSuccessRespModel> fetchStatusCompleted({
    required String costSimulatorId,
    required String userId,
    required String status,
  }) async {
    try {
      final response = await service.fetchStatusCompleted(
        costSimulatorId: costSimulatorId,
        userId: userId,
        status: status,
      );
      final CommonSuccessRespModel model = CommonSuccessRespModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

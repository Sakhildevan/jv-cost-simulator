import 'package:johnsonville_cost_simulator/data/provider/pricing-worksheet/pricing_worksheet.provider.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/common_success_resp.model.dart';
import '../../model/generate_excel_resp.model.dart';
import '../../model/pricing_worksheet.model.dart';

class PricingWorkSheetRepo {
  final PricingWorkSheetProvider provider =
      autoInjector.get<PricingWorkSheetProvider>();

  Future<PricingWorkSheetModel?> getPricingWorkSheetData({
    required String costSimulatorId,
    required String userId,
    required String packUOM,
    required String retailSellPriceUOM,
  }) async {
    try {
      final PricingWorkSheetModel response =
          await provider.getPricingWorkSheetData(
        costSimulatorId: costSimulatorId,
        userId: userId,
        packUOM: packUOM,
        retailSellPriceUOM: retailSellPriceUOM,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }

  Future<GenerateExcelRespModel?> generateExcel({
    required String costSimulatorId,
    required String userId,
  }) async {
    try {
      final GenerateExcelRespModel response = await provider.generateExcel(
        costSimulatorId: costSimulatorId,
        userId: userId,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }

  Future<GenerateExcelRespModel?> generatePdf({
    required String costSimulatorId,
    required String userId,
  }) async {
    try {
      final GenerateExcelRespModel response = await provider.generatePdf(
        costSimulatorId: costSimulatorId,
        userId: userId,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }

  Future<CommonSuccessRespModel?> fetchStatusCompleted({
    required String costSimulatorId,
    required String userId,
    required String status,
  }) async {
    try {
      final CommonSuccessRespModel response =
          await provider.fetchStatusCompleted(
        costSimulatorId: costSimulatorId,
        userId: userId,
        status: status,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

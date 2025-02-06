import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:johnsonville_cost_simulator/data/service/dio_base.service.dart';

import '../../../constants/api_constants.dart';

class PricingWorkSheetService extends DioBaseService {
  final Dio _dio = DioBaseService.dio;
  Future<Response<dynamic>?> getPricingWorkSheetData({
    required String costSimulatorId,
    required String userId,
    required String packUOM,
    required String retailSellPriceUOM,
  }) async {
    final Object body = <String, String>{
      "costSimulatorID": costSimulatorId,
      'UserID': userId,
    };
    String url = (() {
      if (packUOM == "GMS" && retailSellPriceUOM == "KG") {
        return ApiConst.pricingWorksheetV1EndPoint;
      } else if (packUOM == "GMS" && retailSellPriceUOM == "PACK") {
        return ApiConst.pricingWorksheetV4EndPoint;
      } else if (packUOM == "OZ" && retailSellPriceUOM == "LB") {
        return ApiConst.pricingWorksheetV3EndPoint;
      } else if (packUOM == "OZ" && retailSellPriceUOM == "PACK") {
        return ApiConst.pricingWorksheetV2EndPoint;
      } else {
        return "";
      }
    })();
    try {
      return await _dio.post(
        url,
        data: body,
      );
    } on DioException catch (e) {
      if (e.response != null) {
        log('Dio error status: ${e.response!.statusCode}');
        log('Dio error message: ${e.response!.statusMessage}');
        log('Dio error data: ${e.response!.data}');
      } else {
        log('Dio request failed due to an exception: $e');
      }
      rethrow;
    }
  }

  Future<Response<dynamic>?> generateExcel({
    required String costSimulatorId,
    required String userId,
  }) async {
    final Object body = <String, String>{
      "costSimulatorID": costSimulatorId,
      'UserID': userId,
    };
    try {
      return await _dio.post(
        ApiConst.createExcelEndPoint,
        data: body,
      );
    } on DioException catch (e) {
      if (e.response != null) {
        log('Dio error status: ${e.response!.statusCode}');
        log('Dio error message: ${e.response!.statusMessage}');
        log('Dio error data: ${e.response!.data}');
      } else {
        log('Dio request failed due to an exception: $e');
      }
      rethrow;
    }
  }

  Future<Response<dynamic>?> generatePdf({
    required String costSimulatorId,
    required String userId,
  }) async {
    final Object body = <String, String>{
      "costSimulatorID": costSimulatorId,
      'UserID': userId,
    };
    try {
      return await _dio.post(
        ApiConst.createPdfEndPoint,
        data: body,
      );
    } on DioException catch (e) {
      if (e.response != null) {
        log('Dio error status: ${e.response!.statusCode}');
        log('Dio error message: ${e.response!.statusMessage}');
        log('Dio error data: ${e.response!.data}');
      } else {
        log('Dio request failed due to an exception: $e');
      }
      rethrow;
    }
  }

  Future<Response<dynamic>?> fetchStatusCompleted({
    required String costSimulatorId,
    required String userId,
    required String status,
  }) async {
    final Object body = <String, String>{
      "costSimulatorID": costSimulatorId,
      'UserID': userId,
      "Status": status,
    };
    try {
      return await _dio.post(
        ApiConst.completeEndPoint,
        data: body,
      );
    } on DioException catch (e) {
      if (e.response != null) {
        log('Dio error status: ${e.response!.statusCode}');
        log('Dio error message: ${e.response!.statusMessage}');
        log('Dio error data: ${e.response!.data}');
      } else {
        log('Dio request failed due to an exception: $e');
      }
      rethrow;
    }
  }
}

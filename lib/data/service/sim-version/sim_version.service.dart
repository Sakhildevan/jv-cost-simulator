import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:johnsonville_cost_simulator/data/service/dio_base.service.dart';

import '../../../constants/api_constants.dart';

class SimVersionService extends DioBaseService {
  final Dio _dio = DioBaseService.dio;
  Future<Response<dynamic>?> createNewVersion({
    required String simId,
    required String userId,
  }) async {
    try {
      return await _dio.post(
        ApiConst.createNewVersionCostSimEndPoint,
        data: {
          "CostSimulatorID": simId,
          "UserId": userId,
        },
      );
    } on DioException catch (e) {
      // Handle DioError
      log('Dio error: $e');
      if (e.response != null) {
        log('Dio error status: ${e.response!.statusCode}');
        log('Dio error message: ${e.response!.statusMessage}');
        log('Dio error data: ${e.response!.data}');
      } else {
        log('Dio request failed due to an exception: $e');
      }
      // Return null or rethrow the DioError to propagate it further
      rethrow;
    }
  }

  Future<Response<dynamic>?> generateVersionExcel({
    required String simId,
    required String userId,
    required String versionNo,
  }) async {
    try {
      return await _dio.post(
        ApiConst.generateVersionExcelEndPoint,
        data: {
          "CostSimulatorID": simId,
          "UserId": userId,
          "VersionNo": versionNo
        },
      );
    } on DioException catch (e) {
      // Handle DioError
      log('Dio error: $e');
      if (e.response != null) {
        log('Dio error status: ${e.response!.statusCode}');
        log('Dio error message: ${e.response!.statusMessage}');
        log('Dio error data: ${e.response!.data}');
      } else {
        log('Dio request failed due to an exception: $e');
      }
      // Return null or rethrow the DioError to propagate it further
      rethrow;
    }
  }

  Future<Response<dynamic>?> deleteVersion({
    required String simId,
    required String versionNo,
  }) async {
    try {
      return await _dio.post(
        ApiConst.deleteVersionEndPoint,
        data: {
          "CostSimulatorID": simId,
          "VersionNo": versionNo,
        },
      );
    } on DioException catch (e) {
      // Handle DioError
      log('Dio error: $e');
      if (e.response != null) {
        log('Dio error status: ${e.response!.statusCode}');
        log('Dio error message: ${e.response!.statusMessage}');
        log('Dio error data: ${e.response!.data}');
      } else {
        log('Dio request failed due to an exception: $e');
      }
      // Return null or rethrow the DioError to propagate it further
      rethrow;
    }
  }

  Future<Response<dynamic>?> fetchVersionList({
    required String simId,
    required String userId,
  }) async {
    try {
      return await _dio.post(
        ApiConst.fetchVersionListSimEndPoint,
        data: {
          "CostSimulatorID": simId,
          "UserId": userId,
        },
      );
    } on DioException catch (e) {
      // Handle DioError
      log('Dio error: $e');
      if (e.response != null) {
        log('Dio error status: ${e.response!.statusCode}');
        log('Dio error message: ${e.response!.statusMessage}');
        log('Dio error data: ${e.response!.data}');
      } else {
        log('Dio request failed due  to an exception: $e');
      }
      // Return null or rethrow the DioError to propagate it further
      rethrow;
    }
  }
}

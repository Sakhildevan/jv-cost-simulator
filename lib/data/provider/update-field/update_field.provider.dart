import 'package:johnsonville_cost_simulator/data/service/update-field/update_fields.service.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/update_field_resp.model.dart';
import '../../model/update_field_save_resp.model.dart';

class UpdateFieldProvider {
  //*--------(service instance)
  final UpdateFieldsService service = autoInjector.get<UpdateFieldsService>();

  ///fetch update field data
  Future<UpdateFieldRespModel> fetchUpdateFieldData() async {
    try {
      final response = await service.fetchUpdateFieldData();

      final UpdateFieldRespModel model = UpdateFieldRespModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }

  ///fetch update field data
  Future<UpdateFieldSaveRespModel> updateSheetValue({
    required String simId,
    required String updateFieldId,
    required String updateFieldValue,
    required String userId,
  }) async {
    try {
      final response = await service.updateSheetValue(
        simId: simId,
        updateFieldId: updateFieldId,
        updateFieldValue: updateFieldValue,
        userId: userId,
      );

      final UpdateFieldSaveRespModel model = UpdateFieldSaveRespModel.fromJson(
        response?.data as Map<String, dynamic>,
      );
      return model;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

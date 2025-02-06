import 'package:johnsonville_cost_simulator/data/provider/update-field/update_field.provider.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../../main.dart';
import '../../model/update_field_resp.model.dart';
import '../../model/update_field_save_resp.model.dart';

class UpdateFieldRepo {
  //*--------(provider instance)
  final UpdateFieldProvider provider = autoInjector.get<UpdateFieldProvider>();

  ///fetch update field data
  Future<UpdateFieldRespModel> fetchUpdateFieldData() async {
    try {
      final UpdateFieldRespModel response =
          await provider.fetchUpdateFieldData();
      return response;
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
      final UpdateFieldSaveRespModel response = await provider.updateSheetValue(
        simId: simId,
        updateFieldId: updateFieldId,
        updateFieldValue: updateFieldValue,
        userId: userId,
      );
      return response;
    } on Exception catch (e) {
      e.logWarn();
      rethrow;
    }
  }
}

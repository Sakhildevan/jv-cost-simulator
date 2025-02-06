import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:johnsonville_cost_simulator/data/repository/download/download.repo.dart';
import 'package:johnsonville_cost_simulator/data/repository/replicate/replicate.repo.dart';
import 'package:johnsonville_cost_simulator/utils/enums.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';

import '../../config/config.dart';
import '../../data/model/new_version_resp.model.dart';
import '../../data/model/pricing_worksheet.model.dart';
import '../../data/model/update_field_resp.model.dart';
import '../../data/model/update_field_save_resp.model.dart';
import '../../data/model/version_list.model.dart';
import '../../data/repository/pricing-worksheet/pricing_worksheet.repo.dart';
import '../../data/repository/sim-version/sim_version.repo.dart';
import '../../data/repository/update-field/update_field.repo.dart';
import '../../main.dart';
import '../../utils/string_const.dart';

part 'pricing_event.dart';
part 'pricing_state.dart';

class PricingBloc extends Bloc<PricingEvent, PricingState> {
  final UpdateFieldRepo updateFieldRepo = autoInjector.get<UpdateFieldRepo>();
  final DownloadRepo downLoadRepo = autoInjector.get<DownloadRepo>();
  final ReplicateRepo replicateSheetRepo = autoInjector.get<ReplicateRepo>();
  final SimVersionRepo simVersionRepo = autoInjector.get<SimVersionRepo>();
  final PricingWorkSheetRepo pricingWorkSheetRepo =
      autoInjector.get<PricingWorkSheetRepo>();
  PricingBloc() : super(const PricingState()) {
    on<OnRetailSliderChange>(_onRetailSliderChange);
    on<ResetSaveVersionStatusEvent>(_onResetSaveVersionStatusEvent);
    on<ResetStatusEvent>(_onResetStatusEvent);
    on<PricingInit>(_onPricingInit);
    on<LoadSimulator>(_onLoadSim);
    on<UpdateFieldOnChangeEvent>(_onUpdateFieldOnChange);
    on<UpdateFieldEvent>(_onUpdateFieldEvent);
    on<DownloadExcelEvent>(_onDownloadExcel);
    on<ShowCostOfGoods>(_showCostOfGoods);
    on<ShowBannerEvent>(_showBanner);

    on<DownloadPdfEvent>(_onDownLoadPdfEvent);
    on<ReplicateSheetEvent>(_onReplicateSheetEvent);
    on<PricingCompletedEvent>(_onPricingCompletedEvent);
    on<PricingApproveEvent>(_onPricingApproveEvent);
    on<SaveThisVersionEvent>(_onSaveThisVersionEvent);
    on<VersionDownloadExcelEvent>(_onVersionDownloadExcelEvent);
    on<FetchVersionListEvent>(_onFetchVersionListEvent);
    on<DeleteVersionEvent>(_onDeleteVersionEvent);
  }

  FutureOr<void> _onRetailSliderChange(
    OnRetailSliderChange event,
    Emitter<PricingState> emit,
  ) async {}
//   on<ResetSaveVersionStatusEvent>((event, emit) {
//   emit(state.copyWith(
//     saveThisVersionStatus: LoadingStatus.initial, // or any initial state
//     // Reset other necessary fields
//   ));
// });
  FutureOr<void> _onResetSaveVersionStatusEvent(
    ResetSaveVersionStatusEvent event,
    Emitter<PricingState> emit,
  ) async {
    emit(state.copyWith(
      saveThisVersionStatus: LoadingStatus.initial,
    ));
  }

  FutureOr<void> _onResetStatusEvent(
    ResetStatusEvent event,
    Emitter<PricingState> emit,
  ) async {
    emit(state.copyWith(
      deleteThisVersionStatus: LoadingStatus.initial,
    ));
  }

  FutureOr<void> _onUpdateFieldEvent(
    UpdateFieldEvent event,
    Emitter<PricingState> emit,
  ) async {
    emit(
      state.copyWith(
        savingStatus: LoadingStatus.loading,
        isSaveError: false,
      ),
    );
    try {
      final commentField = state.updateFieldList?.firstWhere(
        (element) =>
            element.commentFieldName?.trim().toUpperCase() ==
            event.updateFieldName?.trim().toUpperCase(),
        orElse: () => CommentField(),
      );

      //update field list
      UpdateFieldSaveRespModel? updateFieldListData =
          await updateFieldRepo.updateSheetValue(
        simId: state.simId ?? '',
        updateFieldId: commentField?.commentFieldId.toString() ?? "",
        updateFieldValue: fCon.removePercentageSymbol(event.updateValue ?? ""),
        userId: state.userId ?? '',
      );
      if (updateFieldListData.isSuccess ?? false) {
        add(const LoadSimulator());
      } else {
        emit(
          state.copyWith(
            savingStatus: LoadingStatus.failure,
            isSaveError: true,
          ),
        );
      }
    } on Exception catch (e) {
      e.logFailure();
      emit(
        state.copyWith(
          savingStatus: LoadingStatus.failure,
          isSaveError: true,
        ),
      );
    }
  }

  FutureOr<void> _onDownloadExcel(
    DownloadExcelEvent event,
    Emitter<PricingState> emit,
  ) async {
    emit(state.copyWith(
      excelDownloadingStatus: LoadingStatus.loading,
    ));
    try {
      final excelResp = await pricingWorkSheetRepo.generateExcel(
        costSimulatorId: state.simId ?? '',
        userId: state.userId ?? "",
      );
      if (excelResp?.isSuccess ?? false) {
        await downLoadRepo.downloadFile(
          isPdf: false,
          worksheetUrl: excelResp?.xlSheetUrl ?? "",
        );
        emit(state.copyWith(
          excelDownloadingStatus: LoadingStatus.success,
        ));
      } else {
        emit(state.copyWith(
          excelDownloadingStatus: LoadingStatus.failure,
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        excelDownloadingStatus: LoadingStatus.failure,
      ));
      e.logFailure();
    }
  }

  FutureOr<void> _showCostOfGoods(
    ShowCostOfGoods event,
    Emitter<PricingState> emit,
  ) {
    emit(
      state.copyWith(
        showCostOfGoods: event.showCostOfGoods,
      ),
    );
  }

  FutureOr<void> _showBanner(
    ShowBannerEvent event,
    Emitter<PricingState> emit,
  ) {
    emit(
      state.copyWith(
        showBanner: event.showBanner,
      ),
    );
  }

  FutureOr<void> _onDownLoadPdfEvent(
    DownloadPdfEvent event,
    Emitter<PricingState> emit,
  ) async {
    emit(state.copyWith(
      pdfDownloadingStatus: LoadingStatus.loading,
    ));
    try {
      final pdfResp = await pricingWorkSheetRepo.generatePdf(
        costSimulatorId: state.simId ?? '',
        userId: state.userId ?? "",
      );
      if (pdfResp?.isSuccess ?? false) {
        await downLoadRepo.downloadFile(
          isPdf: true,
          worksheetUrl: pdfResp?.xlSheetUrl ?? "",
        );
        emit(state.copyWith(
          pdfDownloadingStatus: LoadingStatus.success,
        ));
      } else {
        emit(state.copyWith(
          pdfDownloadingStatus: LoadingStatus.failure,
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        pdfDownloadingStatus: LoadingStatus.failure,
      ));
      e.logFailure();
    }
  }

  FutureOr<void> _onReplicateSheetEvent(
    ReplicateSheetEvent event,
    Emitter<PricingState> emit,
  ) async {
    emit(state.copyWith(
      replicateSheetStatus: LoadingStatus.loading,
    ));
    try {
      final replicateResp = await replicateSheetRepo.replicateWorkSheet(
        costSimulatorId: state.simId ?? '',
        userId: state.userId ?? "",
      );
      if (replicateResp?.isSuccess ?? false) {
        emit(state.copyWith(
          replicateSimId: replicateResp?.costSimulatorId.toString(),
          replicateSheetStatus: LoadingStatus.success,
        ));
      } else {
        emit(state.copyWith(
          replicateSheetStatus: LoadingStatus.failure,
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        replicateSheetStatus: LoadingStatus.failure,
      ));
      e.logFailure();
    }
  }

  FutureOr<void> _onPricingCompletedEvent(
    PricingCompletedEvent event,
    Emitter<PricingState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          pricingSaveStatus: LoadingStatus.loading,
        ),
      );
      final saveResp = await pricingWorkSheetRepo.fetchStatusCompleted(
        status: StringConst.approval.toUpperCase(),
        costSimulatorId: state.simId ?? "",
        userId: state.userId ?? "",
      );
      if (saveResp?.isSuccess ?? false) {
        emit(
          state.copyWith(
            pricingSaveStatus: LoadingStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            pricingSaveStatus: LoadingStatus.failure,
          ),
        );
      }
    } on Exception catch (e) {
      e.logError();
      emit(
        state.copyWith(
          pricingSaveStatus: LoadingStatus.failure,
        ),
      );
    }
  }

// pricing approval
  FutureOr<void> _onPricingApproveEvent(
    PricingApproveEvent event,
    Emitter<PricingState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          pricingConfirmStatus: LoadingStatus.loading,
        ),
      );
      final saveResp = await pricingWorkSheetRepo.fetchStatusCompleted(
        status: StringConst.completed.toUpperCase(),
        costSimulatorId: state.simId ?? "",
        userId: state.userId ?? "",
      );
      if (saveResp?.isSuccess ?? false) {
        emit(
          state.copyWith(
            pricingConfirmStatus: LoadingStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            pricingConfirmStatus: LoadingStatus.failure,
          ),
        );
      }
    } on Exception catch (e) {
      e.logError();
      emit(
        state.copyWith(
          pricingConfirmStatus: LoadingStatus.failure,
        ),
      );
    }
  }

// save this version pricing
  FutureOr<void> _onSaveThisVersionEvent(
    SaveThisVersionEvent event,
    Emitter<PricingState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          saveThisVersionStatus: LoadingStatus.loading,
        ),
      );
      final saveResp = await simVersionRepo.createNewVersion(
        simId: state.simId ?? "",
        userId: state.userId ?? "",
      );
      if (saveResp.isSuccess ?? false) {
        emit(
          state.copyWith(
            saveThisVersionStatus: LoadingStatus.success,
            versionResp: saveResp,
          ),
        );
        add(const FetchVersionListEvent());
      } else {
        emit(
          state.copyWith(
            saveThisVersionStatus: LoadingStatus.failure,
            versionResp: saveResp,
          ),
        );
      }
    } on Exception catch (e) {
      e.logError();
      emit(
        state.copyWith(
          saveThisVersionStatus: LoadingStatus.failure,
          versionResp: NewVersionRespModel(
            isSuccess: false,
            errorOnFailure: e.toString(),
          ),
        ),
      );
    }
  }

// download excel version pricing
  FutureOr<void> _onVersionDownloadExcelEvent(
    VersionDownloadExcelEvent event,
    Emitter<PricingState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          selectedVersion: event.versionNo,
          versionExcelStatus: LoadingStatus.loading,
        ),
      );
      final resp = await simVersionRepo.generateVersionExcel(
        simId: state.simId ?? "",
        userId: state.userId ?? "",
        versionNo: event.versionNo,
      );
      if (resp.isSuccess ?? false) {
        await downLoadRepo.downloadFile(
          isPdf: false,
          worksheetUrl: resp.xlSheetUrl ?? "",
        );
        emit(
          state.copyWith(
            versionExcelStatus: LoadingStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            versionExcelStatus: LoadingStatus.failure,
          ),
        );
      }
    } on Exception catch (e) {
      e.logError();
      emit(
        state.copyWith(
          versionExcelStatus: LoadingStatus.failure,
        ),
      );
    }
  }

// save this version pricing
  FutureOr<void> _onFetchVersionListEvent(
    FetchVersionListEvent event,
    Emitter<PricingState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          fetchVersionListStatus: LoadingStatus.loading,
        ),
      );
      final saveResp = await simVersionRepo.fetchVersionList(
        simId: state.simId ?? "",
        userId: state.userId ?? "",
      );
      if (saveResp.isSuccess ?? false) {
        emit(
          state.copyWith(
            revisionList: saveResp.costSimulatorRevisionListItems,
            fetchVersionListStatus: LoadingStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            fetchVersionListStatus: LoadingStatus.failure,
          ),
        );
      }
    } on Exception catch (e) {
      e.logError();
      emit(
        state.copyWith(
          fetchVersionListStatus: LoadingStatus.failure,
        ),
      );
    }
  }

// save this version pricing
  FutureOr<void> _onDeleteVersionEvent(
    DeleteVersionEvent event,
    Emitter<PricingState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          deleteThisVersionStatus: LoadingStatus.loading,
        ),
      );

      final saveResp = await simVersionRepo.deleteVersion(
        simId: state.simId ?? "",
        versionNo: event.versionNo,
      );
      if (saveResp.isSuccess ?? false) {
        add(const FetchVersionListEvent());
        emit(
          state.copyWith(
            deleteThisVersionStatus: LoadingStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            deleteThisVersionStatus: LoadingStatus.failure,
          ),
        );
      }
    } on Exception catch (e) {
      e.logError();
      emit(
        state.copyWith(
          deleteThisVersionStatus: LoadingStatus.failure,
        ),
      );
    }
  }

  FutureOr<void> _onPricingInit(
    PricingInit event,
    Emitter<PricingState> emit,
  ) async {
    final userId = await fCon.getValueFromStorage(
      value: StringConst.userId,
    );
    final userName = await fCon.getValueFromStorage(
      value: StringConst.userFirstNameValue,
    );
    final userRole = await fCon.getValueFromStorage(
      value: StringConst.userRole,
    );
    final isAdmin = await fCon.getBoolValueFromStorage(
      value: StringConst.isAdmin,
    );
    emit(PricingState(
      sliderValue: 0,
      userId: userId,
      updatedValue: '',
      isAdmin: isAdmin,
      userRole: userRole,
      showCostOfGoods: false,
      loadingStatus: LoadingStatus.loading,
      simId: event.simId,
      packUOM: event.packUOM,
      sellPriceUOM: event.sellPriceUOM,
      userName: userName,
    ));
    try {
      //update field list
      UpdateFieldRespModel? updateFieldListData =
          await updateFieldRepo.fetchUpdateFieldData();
      add(const FetchVersionListEvent());
      List<CommentField> updateFieldList =
          updateFieldListData.commentFields ?? [];
      emit(state.copyWith(
        updateFieldList: updateFieldList,
      ));
      final pricingResp = await pricingWorkSheetRepo.getPricingWorkSheetData(
        packUOM: event.packUOM,
        retailSellPriceUOM: event.sellPriceUOM,
        costSimulatorId: event.simId,
        userId: userId,
      );
      if (pricingResp?.isSuccess ?? false) {
        emit(state.copyWith(
          pricingData: pricingResp,
          worksheetUrl:
              pricingResp?.pricingWorksheetSegmentItems?.worksheetUrl ?? "",
          isDataLoadedAfterChange: true,
          loadingStatus: LoadingStatus.success,
        ));
      } else {
        emit(state.copyWith(
          loadingStatus: LoadingStatus.failure,
        ));
      }
    } on Exception catch (e) {
      e.logFailure();
      emit(state.copyWith(
        loadingStatus: LoadingStatus.failure,
      ));
    }
  }

  FutureOr<void> _onLoadSim(
    LoadSimulator event,
    Emitter<PricingState> emit,
  ) async {
    try {
      final pricingResp = await pricingWorkSheetRepo.getPricingWorkSheetData(
        packUOM: state.packUOM ?? "",
        retailSellPriceUOM: state.sellPriceUOM ?? "",
        costSimulatorId: state.simId ?? "0",
        userId: state.userId ?? '',
      );
      if (pricingResp?.isSuccess ?? false) {
        emit(
          state.copyWith(
            pricingData: pricingResp,
            sellVolume:
                pricingResp?.pricingWorksheetSegmentItems?.sellVolume ?? '',
            worksheetUrl:
                pricingResp?.pricingWorksheetSegmentItems?.worksheetUrl ?? "",
            isDataLoadedAfterChange: true,
            savingStatus: LoadingStatus.success,
          ),
        );
      } else {}
    } on Exception catch (e) {
      e.logFailure();
      emit(state.copyWith(
        savingStatus: LoadingStatus.failure,
      ));
    }
  }

  FutureOr<void> _onUpdateFieldOnChange(
    UpdateFieldOnChangeEvent event,
    Emitter<PricingState> emit,
  ) {
    emit(state.copyWith(
      isDataLoadedAfterChange: event.isDataLoadedAfterChange,
      updatedValue: event.updateValue,
      isSaveError: event.isSaveError,
      showCostOfGoods: event.showCostOfGoods,
    ));
  }
}

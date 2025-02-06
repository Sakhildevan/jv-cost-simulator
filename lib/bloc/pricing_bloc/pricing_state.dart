part of 'pricing_bloc.dart';

class PricingState extends Equatable {
  final double sliderValue;
  final LoadingStatus loadingStatus;
  final LoadingStatus savingStatus;
  final LoadingStatus excelDownloadingStatus;
  final LoadingStatus pdfDownloadingStatus;
  final LoadingStatus pricingSaveStatus;
  final LoadingStatus pricingConfirmStatus;
  final LoadingStatus saveThisVersionStatus;
  final LoadingStatus deleteThisVersionStatus;
  final LoadingStatus versionExcelStatus;
  final LoadingStatus fetchVersionListStatus;
  final LoadingStatus replicateSheetStatus;
  final PricingWorkSheetModel? pricingData;
  final NewVersionRespModel? versionResp;
  final String? userName;
  final String? simId;
  final String? replicateSimId;
  final String? updatedValue;
  final String? selectedVersion;
  final List<CommentField>? updateFieldList;
  final String? userId;
  final String? worksheetUrl;
  final bool? isDataLoadedAfterChange;
  final bool? showCostOfGoods;
  final bool? isSaveError;
  final bool? showBanner;
  final bool? isAdmin;
  final String? userRole;
  final String? packUOM;
  final String? sellPriceUOM;
  final List<CostSimulatorRevisionListItem>? revisionList;
  final String? sellVolume;

  const PricingState({
    this.sliderValue = 0.0,
    this.loadingStatus = LoadingStatus.initial,
    this.replicateSheetStatus = LoadingStatus.initial,
    this.pricingSaveStatus = LoadingStatus.initial,
    this.pricingConfirmStatus = LoadingStatus.initial,
    this.saveThisVersionStatus = LoadingStatus.initial,
    this.deleteThisVersionStatus = LoadingStatus.initial,
    this.versionExcelStatus = LoadingStatus.initial,
    this.fetchVersionListStatus = LoadingStatus.initial,
    this.pdfDownloadingStatus = LoadingStatus.initial,
    this.excelDownloadingStatus = LoadingStatus.initial,
    this.savingStatus = LoadingStatus.initial,
    this.pricingData,
    this.versionResp,
    this.replicateSimId,
    this.showCostOfGoods,
    this.userName,
    this.updateFieldList,
    this.updatedValue,
    this.simId,
    this.worksheetUrl,
    this.isSaveError,
    this.userId,
    this.isDataLoadedAfterChange,
    this.isAdmin,
    this.userRole,
    this.packUOM,
    this.sellPriceUOM,
    this.showBanner,
    this.selectedVersion,
    this.revisionList,
    this.sellVolume,
  });

  PricingState copyWith({
    double? sliderValue,
    LoadingStatus? loadingStatus,
    LoadingStatus? pricingSaveStatus,
    LoadingStatus? replicateSheetStatus,
    LoadingStatus? pricingConfirmStatus,
    LoadingStatus? saveThisVersionStatus,
    LoadingStatus? deleteThisVersionStatus,
    LoadingStatus? versionExcelStatus,
    LoadingStatus? fetchVersionListStatus,
    LoadingStatus? pdfDownloadingStatus,
    LoadingStatus? excelDownloadingStatus,
    LoadingStatus? savingStatus,
    PricingWorkSheetModel? pricingData,
    List<CostSimulatorRevisionListItem>? revisionList,
    NewVersionRespModel? versionResp,
    String? userName,
    String? worksheetUrl,
    String? updatedValue,
    String? simId,
    String? replicateSimId,
    String? userId,
    String? selectedVersion,
    List<CommentField>? updateFieldList,
    bool? isDataLoadedAfterChange,
    bool? isSaveError,
    bool? showCostOfGoods,
    bool? showPopup,
    bool? isAdmin,
    bool? showBanner,
    String? userRole,
    String? packUOM,
    String? sellPriceUOM,
    String? sellVolume,
  }) {
    return PricingState(
      sliderValue: sliderValue ?? this.sliderValue,
      versionResp: versionResp ?? this.versionResp,
      selectedVersion: selectedVersion ?? this.selectedVersion,
      revisionList: revisionList ?? this.revisionList,
      showCostOfGoods: showCostOfGoods ?? this.showCostOfGoods,
      replicateSimId: replicateSimId ?? this.replicateSimId,
      pdfDownloadingStatus: pdfDownloadingStatus ?? this.pdfDownloadingStatus,
      replicateSheetStatus: replicateSheetStatus ?? this.replicateSheetStatus,
      pricingSaveStatus: pricingSaveStatus ?? this.pricingSaveStatus,
      pricingConfirmStatus: pricingConfirmStatus ?? this.pricingConfirmStatus,
      saveThisVersionStatus:
          saveThisVersionStatus ?? this.saveThisVersionStatus,
      deleteThisVersionStatus:
          deleteThisVersionStatus ?? this.deleteThisVersionStatus,
      versionExcelStatus: versionExcelStatus ?? this.versionExcelStatus,
      fetchVersionListStatus:
          fetchVersionListStatus ?? this.fetchVersionListStatus,
      excelDownloadingStatus:
          excelDownloadingStatus ?? this.excelDownloadingStatus,
      worksheetUrl: worksheetUrl ?? this.worksheetUrl,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      savingStatus: savingStatus ?? this.savingStatus,
      pricingData: pricingData ?? this.pricingData,
      userName: userName ?? this.userName,
      simId: simId ?? this.simId,
      userId: userId ?? this.userId,
      userRole: userRole ?? this.userRole,
      packUOM: packUOM ?? this.packUOM,
      sellPriceUOM: sellPriceUOM ?? this.sellPriceUOM,
      isAdmin: isAdmin ?? this.isAdmin,
      showBanner: showBanner ?? this.showBanner,
      isSaveError: isSaveError ?? this.isSaveError,
      updatedValue: updatedValue ?? this.updatedValue,
      sellVolume: sellVolume ?? this.sellVolume,
      updateFieldList: updateFieldList ?? this.updateFieldList,
      isDataLoadedAfterChange:
          isDataLoadedAfterChange ?? this.isDataLoadedAfterChange,
    );
  }

  @override
  List<Object> get props => [
        loadingStatus,
        versionResp ?? NewVersionRespModel(),
        excelDownloadingStatus,
        replicateSheetStatus,
        pdfDownloadingStatus,
        pricingSaveStatus,
        pricingConfirmStatus,
        saveThisVersionStatus,
        deleteThisVersionStatus,
        versionExcelStatus,
        fetchVersionListStatus,
        selectedVersion ?? "",
        replicateSimId ?? "",
        worksheetUrl ?? "",
        isDataLoadedAfterChange ?? false,
        isSaveError ?? false,
        showBanner ?? false,
        savingStatus,
        sliderValue,
        showCostOfGoods ?? false,
        isAdmin ?? false,
        pricingData ?? const PricingWorkSheetModel(),
        userName ?? '',
        updateFieldList ?? [],
        simId ?? '',
        userId ?? '',
        userRole ?? '',
        packUOM ?? '',
        sellPriceUOM ?? '',
        updatedValue ?? '',
        sellVolume ?? '',
      ];
}

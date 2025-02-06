part of 'simulator_category_bloc.dart';

final class SimulatorCategoryState extends Equatable {
  const SimulatorCategoryState({
    this.pendingList,
    this.currentPageIndex,
    this.paginatedData,
    this.totalPages,
    this.startDate,
    this.endDate,
    this.status,
    this.selectedCurrVal,
    this.costSimulatorListModel,
    this.selectedStartDate,
    this.selectedEndDate,
    this.filterStatus,
    this.showSearch,
    this.currencyList,
    this.loadingStatus,
    this.selectedItemIndex,
    this.userName,
    this.packUom,
    this.sellPriceUOM,
    this.itemLoadingStatus = LoadingStatus.initial,
  });
  final List<CostSimulatorListItem>? pendingList;
  final List<CostSimulatorListItem>? paginatedData;
  final int? currentPageIndex;
  final int? selectedItemIndex;
  final List<Currency>? currencyList;
  final String? selectedCurrVal;
  final String? filterStatus;
  final int? totalPages;
  final DateTime? startDate;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final DateTime? endDate;
  final SimulatorStatus? status;
  final CostSimulatorListModel? costSimulatorListModel;
  final LoadingStatus? loadingStatus;
  final bool? showSearch;
  final String? userName;
  final String? packUom;
  final String? sellPriceUOM;
  final LoadingStatus itemLoadingStatus;

  SimulatorCategoryState copyWith({
    CostSimulatorListModel? costSimulatorListModel,
    List<CostSimulatorListItem>? pendingList,
    List<CostSimulatorListItem>? paginatedData,
    String? filterStatus,
    DateTime? selectedEndDate,
    DateTime? selectedStartDate,
    int? currentPageIndex,
    int? selectedItemIndex,
    String? selectedCurrVal,
    String? userName,
    int? totalPages,
    DateTime? startDate,
    DateTime? endDate,
    SimulatorStatus? status,
    bool? showSearch,
    LoadingStatus? loadingStatus,
    List<Currency>? currencyList,
    String? packUom,
    String? sellPriceUOM,
    LoadingStatus? itemLoadingStatus,
  }) {
    return SimulatorCategoryState(
      selectedEndDate: selectedEndDate ?? this.selectedEndDate,
      selectedItemIndex: selectedItemIndex ?? this.selectedItemIndex,
      selectedStartDate: selectedStartDate ?? this.selectedStartDate,
      filterStatus: filterStatus ?? this.filterStatus,
      userName: userName ?? this.userName,
      pendingList: pendingList ?? this.pendingList,
      costSimulatorListModel:
          costSimulatorListModel ?? this.costSimulatorListModel,
      paginatedData: paginatedData ?? this.paginatedData,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      totalPages: totalPages ?? this.totalPages,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      selectedCurrVal: selectedCurrVal ?? this.selectedCurrVal,
      showSearch: showSearch ?? this.showSearch,
      currencyList: currencyList ?? this.currencyList,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      packUom: packUom ?? this.packUom,
      sellPriceUOM: sellPriceUOM ?? this.sellPriceUOM,
      itemLoadingStatus: itemLoadingStatus ?? this.itemLoadingStatus,
    );
  }

  @override
  List<Object> get props => [
        filterStatus ?? "",
        userName ?? "",
        selectedItemIndex ?? -1,
        costSimulatorListModel ?? CostSimulatorListModel(),
        pendingList ?? [],
        paginatedData ?? [],
        currentPageIndex ?? 0,
        totalPages ?? 0,
        startDate ?? DateTime.now(),
        endDate ?? DateTime.now(),
        status ?? SimulatorStatus,
        selectedCurrVal ?? '',
        showSearch ?? false,
        currencyList ?? [],
        selectedStartDate ?? DateTime.now(),
        selectedEndDate ?? DateTime.now(),
        loadingStatus ?? LoadingStatus.loading,
        packUom ?? "",
        sellPriceUOM ?? "",
        itemLoadingStatus,
      ];
}

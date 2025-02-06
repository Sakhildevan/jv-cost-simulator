import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';
import 'package:johnsonville_cost_simulator/utils/string_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/cost_simulator.model.dart';
import '../../data/model/currency_list.model.dart';
import '../../data/model/load_simulator.model.dart';
import '../../data/repository/currency/currency_list.repo.dart';
import '../../data/repository/load-simulator/load_simulator.repo.dart';
import '../../data/repository/master-list/master_list.repo.dart';
import '../../data/repository/simulator-list/simulator_list.repo.dart';
import '../../main.dart';
import '../../utils/enums.dart';

part 'simulator_category_event.dart';
part 'simulator_category_state.dart';

class SimulatorCategoryBloc
    extends Bloc<SimulatorCategoryEvent, SimulatorCategoryState> {
  final SimulatorListRepo simulatorListRepo =
      autoInjector.get<SimulatorListRepo>();
  final CurrencyListRepo currencyListRepo =
      autoInjector.get<CurrencyListRepo>();
  final MasterListRepo masterListRepo = autoInjector.get<MasterListRepo>();
  final LoadCostSimulatorRepo loadCostSimulatorRepo =
      autoInjector.get<LoadCostSimulatorRepo>();

  SimulatorCategoryBloc() : super(const SimulatorCategoryState()) {
    on<SimCategoryInit>(onSimCategoryInit);
    on<PageChangeEvent>(onPageChange);
    on<DatePickEvent>(onDatePick);
    on<FilterStatusTapEvent>(onFilterStatusTap);
    on<FilterSellCurrTapEvent>(onFilterSellCurrTapEvent);
    on<ShowOrHideSearch>(onShowOrHideSearch);
    on<FilterSave>(onFilterSave);
    on<SearchEvent>(onSearchEvent);
    on<OnItemSelect>(_onItemSelect);
    on<ItemTap>(_onItemTap);
  }

//!----------------(Event handlers _onItemTap)----------------
  FutureOr<void> _onItemTap(
      ItemTap event, Emitter<SimulatorCategoryState> emit) async {
    emit(
      state.copyWith(itemLoadingStatus: LoadingStatus.loading),
    );
    try {
      LoadCostSimulatorModel? loadCostSimResp =
          await loadCostSimulatorRepo.getLoadCostSimulatorList(
        costSimulatorId: event.simId,
      );

      emit(state.copyWith(
        itemLoadingStatus: LoadingStatus.success,
        packUom: loadCostSimResp?.packUom ?? "",
        sellPriceUOM: loadCostSimResp?.retailSellPriceUom ?? "",
      ));
    } on Exception catch (e) {
      e.logFailure();
      emit(state.copyWith(
        itemLoadingStatus: LoadingStatus.failure,
      ));
    }
  }

//!----------------(Event handlers onmenuchanged)----------------
  FutureOr<void> _onItemSelect(
      OnItemSelect event, Emitter<SimulatorCategoryState> emit) {
    emit(state.copyWith(
      selectedItemIndex: event.index,
    ));
  }

  FutureOr<void> onFilterSave(
    FilterSave event,
    Emitter<SimulatorCategoryState> emit,
  ) async {
    //!-------- (filter list)
    try {
      CostSimulatorListModel? filteredList =
          await simulatorListRepo.getCostSimulatorList(
        costSimulatorStatus:
            fCon.simulatorCategoryStatus(state.status ?? SimulatorStatus.all),
        fromDate: fCon.formatDate(
          date: state.selectedStartDate ?? DateTime.now(),
          formatType: DateFormatType.yearMonthDaySlash,
        ),
        toDate: fCon.formatDate(
          date: state.selectedEndDate ?? DateTime.now(),
          formatType: DateFormatType.yearMonthDaySlash,
        ),
        currencyCode:
            state.selectedCurrVal != 'ALL' ? state.selectedCurrVal : '',
        listCount: '0',
      );
      //!-------- (paginated data)
      List<CostSimulatorListItem>? paginatedData = getPaginatedData(
          filteredList?.costSimulatorListSegmentItems?.costSimulatorListItems ??
              [],
          1,
          50);
      //!-------- (total pages)
      int totalPages = ((filteredList?.costSimulatorListSegmentItems
                      ?.costSimulatorListItems?.length ??
                  0) /
              50)
          .ceil();
      emit(state.copyWith(
        costSimulatorListModel: filteredList,
        pendingList:
            filteredList?.costSimulatorListSegmentItems?.costSimulatorListItems,
        currentPageIndex: 0,
        paginatedData: paginatedData,
        totalPages: totalPages,
      ));
    } on Exception catch (e) {
      e.logFailure();
    }
  }

  FutureOr<void> onSearchEvent(
    SearchEvent event,
    Emitter<SimulatorCategoryState> emit,
  ) async {
    //!-------- (filter list)
    try {
      CostSimulatorListModel? filteredList =
          await simulatorListRepo.getCostSimulatorList(
        costSimulatorStatus: fCon.simulatorCategoryStatus(
          state.status ?? SimulatorStatus.all,
        ),
        fromDate: fCon.formatDate(
          date: state.selectedStartDate ?? DateTime.now(),
          formatType: DateFormatType.yearMonthDaySlash,
        ),
        toDate: fCon.formatDate(
          date: state.selectedEndDate ?? DateTime.now(),
          formatType: DateFormatType.yearMonthDaySlash,
        ),
        currencyCode:
            state.selectedCurrVal != 'ALL' ? state.selectedCurrVal : '',
        listCount: '0',
        searchQuery: event.query,
      );
      //!-------- (paginated data)
      List<CostSimulatorListItem>? paginatedData = getPaginatedData(
          filteredList?.costSimulatorListSegmentItems?.costSimulatorListItems ??
              [],
          1,
          50);
      //!-------- (total pages)
      int totalPages = ((filteredList?.costSimulatorListSegmentItems
                      ?.costSimulatorListItems?.length ??
                  0) /
              50)
          .ceil();
      emit(state.copyWith(
        costSimulatorListModel: filteredList,
        pendingList:
            filteredList?.costSimulatorListSegmentItems?.costSimulatorListItems,
        currentPageIndex: 0,
        paginatedData: paginatedData,
        totalPages: totalPages,
      ));
    } on Exception catch (e) {
      e.logFailure();
    }
  }

//!---------(onSimulator Initial)
  FutureOr<void> onSimCategoryInit(
    SimCategoryInit event,
    Emitter<SimulatorCategoryState> emit,
  ) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();

    String userName = prefs.getString(
          StringConst.userFirstNameValue,
        ) ??
        '';
    emit(state.copyWith(
      loadingStatus: LoadingStatus.loading,
    ));
    final masterListResp = await masterListRepo.fetchMasterList();
    DateTime? startDate = fCon.convertDate(masterListResp.dates?[0].start);
    DateTime? endDate = fCon.convertDate(masterListResp.dates?[0].end);

    //!-------- (pending list)
    final currencyResp = await currencyListRepo.fetchCurrencyList();
    List<Currency> updatedCurrencyList = [
      Currency(
        currencyCode: StringConst.all.toUpperCase(),
        currencyName: StringConst.all.toUpperCase(),
      ),
      ...currencyResp.currencies ?? [] // Adding the "ALL" option
    ];
    CostSimulatorListModel? pendingList =
        await simulatorListRepo.getCostSimulatorList(
      costSimulatorStatus: event.type,
      listCount: '0',
    );
    //!-------- (paginated data)
    List<CostSimulatorListItem>? paginatedData = getPaginatedData(
        pendingList?.costSimulatorListSegmentItems?.costSimulatorListItems ??
            [],
        1,
        50);
    //!-------- (total pages)
    int totalPages = ((pendingList?.costSimulatorListSegmentItems
                    ?.costSimulatorListItems?.length ??
                0) /
            50)
        .ceil();
    emit(
      SimulatorCategoryState(
        currencyList: updatedCurrencyList, userName: userName,
        // currencyList: currencyResp.currencies,
        costSimulatorListModel: pendingList,
        pendingList:
            pendingList?.costSimulatorListSegmentItems?.costSimulatorListItems,
        currentPageIndex: 0,
        paginatedData: paginatedData,
        totalPages: totalPages,
        selectedCurrVal: StringConst.all.toUpperCase(),
        showSearch: false,
        startDate: startDate,
        endDate: endDate,
        selectedStartDate: startDate,
        selectedEndDate: endDate,
        filterStatus: event.type,
        status: event.type == 'pending'
            ? SimulatorStatus.pending
            : event.type == 'completed'
                ? SimulatorStatus.completed
                : SimulatorStatus.all,
      ),
    );
  }

//!---------(onPageChange)
  FutureOr<void> onPageChange(
    PageChangeEvent event,
    Emitter<SimulatorCategoryState> emit,
  ) async {
    List<CostSimulatorListItem>? paginatedData =
        getPaginatedData(state.pendingList ?? [], (event.index + 1), 50);
    emit(state.copyWith(
      currentPageIndex: event.index,
      paginatedData: paginatedData,
    ));
  }

//!---------(onDatePick)
  FutureOr<void> onDatePick(
    DatePickEvent event,
    Emitter<SimulatorCategoryState> emit,
  ) {
    if (event.status == DatePickerType.start) {
      emit(state.copyWith(selectedStartDate: event.date));
    } else {
      emit(state.copyWith(selectedEndDate: event.date));
    }
  }

//*---------(onFilterStatusTap)
  FutureOr<void> onFilterStatusTap(
    FilterStatusTapEvent event,
    Emitter<SimulatorCategoryState> emit,
  ) {
    emit(state.copyWith(
      status: event.status,
    ));
  }

//*---------(onShowOrHideSearch)
  FutureOr<void> onShowOrHideSearch(
    ShowOrHideSearch event,
    Emitter<SimulatorCategoryState> emit,
  ) {
    if (!event.showSearch) {
      add(const SearchEvent(query: ''));
    }
    emit(state.copyWith(
      showSearch: event.showSearch,
    ));
  }

//*---------(onFilterSellCurrTapEvent)
  FutureOr<void> onFilterSellCurrTapEvent(
    FilterSellCurrTapEvent event,
    Emitter<SimulatorCategoryState> emit,
  ) {
    emit(state.copyWith(
      selectedCurrVal: event.status.currencyCode,
    ));
  }
}

List<CostSimulatorListItem> getPaginatedData(
    List<CostSimulatorListItem> data, int page, int pageSize) {
  int startIndex = (page - 1) * pageSize;
  int endIndex = startIndex + pageSize;

  if (startIndex >= data.length) {
    return [];
  }

  return data.sublist(
      startIndex, endIndex > data.length ? data.length : endIndex);
}

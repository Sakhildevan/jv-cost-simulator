import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:johnsonville_cost_simulator/utils/enums.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/cost_simulator.model.dart';
import '../../data/model/load_simulator.model.dart';
import '../../data/repository/load-simulator/load_simulator.repo.dart';
import '../../data/repository/simulator-list/simulator_list.repo.dart';
import '../../main.dart';
import '../../utils/string_const.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //*--------(repo instance)
  final SimulatorListRepo simulatorListRepo =
      autoInjector.get<SimulatorListRepo>();
  final LoadCostSimulatorRepo loadCostSimulatorRepo =
      autoInjector.get<LoadCostSimulatorRepo>();
  //!----------------(HomeBloc)----------------
  HomeBloc() : super(const HomeState()) {
    on<ChangeMenu>(_changeMenu);
    on<OnMenuChanged>(_onMenuChanged);
    on<OnItemSelect>(_onItemSelect);
    on<HomeInitial>(_onHomeInit);
    on<ItemTap>(_onItemTap);
  }

//!----------------(Event handlers _onItemTap)----------------
  FutureOr<void> _onItemTap(ItemTap event, Emitter<HomeState> emit) async {
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

  FutureOr<void> _changeMenu(ChangeMenu event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      selectedOption: event.item,
      isMenuItemClicked: true,
    ));
  }

//!----------------(Event handlers onmenuchanged)----------------
  FutureOr<void> _onMenuChanged(OnMenuChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(onMenuChanged: event.value));
  }

//!----------------(Event handlers onmenuchanged)----------------
  FutureOr<void> _onItemSelect(OnItemSelect event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      selectedItemIndex: event.index,
    ));
  }

//!----------------(Event handlers onhomeinit)----------------
  Future<FutureOr<void>> _onHomeInit(
      HomeInitial event, Emitter<HomeState> emit) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();

    String userName = prefs.getString(
          StringConst.userFirstNameValue,
        ) ??
        '';

    emit(state.copyWith(
      loadingStatus: LoadingStatus.loading,
      selectedItemIndex: -1,
      userName: userName,
    ));
    CostSimulatorListModel? data = await simulatorListRepo.getCostSimulatorList(
      costSimulatorStatus: 'All',
      listCount: '5',
    );
    emit(state.copyWith(
      loadingStatus: LoadingStatus.success,
      costSimulatorListModel: data,
      onMenuChanged: false,
      isMenuItemClicked: false,
    ));
  }
}

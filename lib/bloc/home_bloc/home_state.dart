part of 'home_bloc.dart';

final class HomeState extends Equatable {
  final List<String> popUpOption;
  final String selectedOption;
  final bool onMenuChanged;
  final bool isMenuItemClicked;
  final LoadingStatus loadingStatus;
  final LoadingStatus itemLoadingStatus;
  final CostSimulatorListModel? costSimulatorListModel;
  final int? selectedItemIndex;
  final String? userName;
  final String? packUom;
  final String? sellPriceUOM;

  const HomeState({
    this.popUpOption = const <String>[
      'Summary',
      'New Simulator',
      'Pending Simulator',
      'Completed Simulator',
      // 'Reference Tables',
      // 'My Profile',
      'Logout',
    ],
    this.selectedOption = '',
    this.onMenuChanged = false,
    this.isMenuItemClicked = false,
    this.costSimulatorListModel,
    this.loadingStatus = LoadingStatus.initial,
    this.itemLoadingStatus = LoadingStatus.initial,
    this.selectedItemIndex,
    this.userName,
    this.packUom,
    this.sellPriceUOM,
  });

  HomeState copyWith({
    int? selectedItemIndex,
    List<String>? popUpOption,
    String? selectedOption,
    String? userName,
    String? packUom,
    String? sellPriceUOM,
    bool? onMenuChanged,
    bool? isMenuItemClicked,
    CostSimulatorListModel? costSimulatorListModel,
    LoadingStatus? loadingStatus,
    LoadingStatus? itemLoadingStatus,
  }) {
    return HomeState(
      selectedItemIndex: selectedItemIndex ?? this.selectedItemIndex,
      popUpOption: popUpOption ?? this.popUpOption,
      selectedOption: selectedOption ?? this.selectedOption,
      onMenuChanged: onMenuChanged ?? this.onMenuChanged,
      isMenuItemClicked: isMenuItemClicked ?? this.isMenuItemClicked,
      costSimulatorListModel:
          costSimulatorListModel ?? this.costSimulatorListModel,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      itemLoadingStatus: itemLoadingStatus ?? this.itemLoadingStatus,
      userName: userName ?? this.userName,
      packUom: packUom ?? this.packUom,
      sellPriceUOM: sellPriceUOM ?? this.sellPriceUOM,
    );
  }

  @override
  List<Object> get props => [
        popUpOption,
        selectedOption,
        onMenuChanged,
        isMenuItemClicked,
        costSimulatorListModel ?? CostSimulatorListModel(),
        loadingStatus,
        itemLoadingStatus,
        selectedItemIndex ?? -1,
        userName ?? "",
        packUom ?? "",
        sellPriceUOM ?? ""
      ];
}

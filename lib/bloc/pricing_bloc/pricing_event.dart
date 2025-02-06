part of 'pricing_bloc.dart';

abstract class PricingEvent extends Equatable {
  const PricingEvent();

  @override
  List<Object> get props => [];
}

class OnRetailSliderChange extends PricingEvent {
  final double newValue;
  final bool isSlider1;

  const OnRetailSliderChange({
    required this.newValue,
    required this.isSlider1,
  });

  @override
  List<Object> get props => [
        newValue,
        isSlider1,
      ];
}

class ResetSaveVersionStatusEvent extends PricingEvent {
  const ResetSaveVersionStatusEvent();
}

class ResetStatusEvent extends PricingEvent {
  const ResetStatusEvent();
}

class PricingInit extends PricingEvent {
  const PricingInit({
    required this.simId,
    required this.packUOM,
    required this.sellPriceUOM,
  });
  final String simId;
  final String packUOM;
  final String sellPriceUOM;
}

class DownloadExcelEvent extends PricingEvent {
  const DownloadExcelEvent();
}

class ShowCostOfGoods extends PricingEvent {
  const ShowCostOfGoods({
    required this.showCostOfGoods,
  });
  final bool showCostOfGoods;
}

class DownloadPdfEvent extends PricingEvent {
  const DownloadPdfEvent();
}

class VersionDownloadExcelEvent extends PricingEvent {
  const VersionDownloadExcelEvent({
    required this.versionNo,
  });
  final String versionNo;
}

class UpdateFieldEvent extends PricingEvent {
  final String? updateFieldName;
  final String? updateValue;

  const UpdateFieldEvent({
    required this.updateFieldName,
    required this.updateValue,
  });
}

class UpdateFieldOnChangeEvent extends PricingEvent {
  final String? updateValue;
  final bool? isDataLoadedAfterChange;
  final bool? isSaveError;
  final bool? showCostOfGoods;

  const UpdateFieldOnChangeEvent({
    required this.updateValue,
    required this.isDataLoadedAfterChange,
    required this.isSaveError,
    required this.showCostOfGoods,
  });
}

class LoadSimulator extends PricingEvent {
  const LoadSimulator();
}

class PricingCompletedEvent extends PricingEvent {
  const PricingCompletedEvent();
}

class PricingApproveEvent extends PricingEvent {
  const PricingApproveEvent();
}

class ReplicateSheetEvent extends PricingEvent {
  const ReplicateSheetEvent();
}

class SaveThisVersionEvent extends PricingEvent {
  const SaveThisVersionEvent();
}

class FetchVersionListEvent extends PricingEvent {
  const FetchVersionListEvent();
}

class DeleteVersionEvent extends PricingEvent {
  const DeleteVersionEvent({
    required this.versionNo,
  });
  final String versionNo;
}

class ShowBannerEvent extends PricingEvent {
  const ShowBannerEvent({
    required this.showBanner,
  });
  final bool? showBanner;
}

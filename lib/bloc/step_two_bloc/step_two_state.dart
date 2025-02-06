part of 'step_two_bloc.dart';

class StepTwoState extends Equatable {
  final String? userName;
  final StepTwoRequestModel? stepTwoData;
  final bool isStepTwoCompleted;
  final bool onShowOthers;
  final bool isEdited;
  final bool yesSelected;
  final bool noSelected;
  final bool? isCommentSaved;
  final LoadingStatus loadingStatus;
  final LoadingStatus stepTwoCreateLoadingStatus;
  final LoadingStatus stepTwoSaveLoadingStatus;
  final LoadCostSimulatorModel? loadCostSimulatorResp;
  final List<CommentField>? commentFieldList;
  final List<UnitMeasure>? unitMeasureList;
  final LoadingStatus createSimLoadingStatus;
  final String? createdBy;
  final String? createdOn;
  final String? approvedBy;
  final String? approvedOn;
  final String? simStatus;

  // Grouped similar fields together
  final CostSimulatorDetails costSimulatorDetails;
  final CommentFields commentFields;

  const StepTwoState({
    this.createSimLoadingStatus = LoadingStatus.initial,
    this.stepTwoData,
    this.userName,
    this.isStepTwoCompleted = false,
    this.isEdited = false,
    this.onShowOthers = false,
    this.yesSelected = false,
    this.noSelected = false,
    this.costSimulatorDetails = const CostSimulatorDetails(),
    this.commentFields = const CommentFields(),
    this.loadCostSimulatorResp,
    this.loadingStatus = LoadingStatus.initial,
    this.stepTwoCreateLoadingStatus = LoadingStatus.initial,
    this.stepTwoSaveLoadingStatus = LoadingStatus.initial,
    this.commentFieldList,
    this.unitMeasureList,
    this.isCommentSaved,
    this.createdBy,
    this.createdOn,
    this.approvedBy,
    this.approvedOn,
    this.simStatus,
  });

  StepTwoState copyWith({
    LoadingStatus? createSimLoadingStatus,
    StepTwoRequestModel? stepTwoData,
    bool? isStepTwoCompleted,
    bool? onShowOthers,
    bool? yesSelected,
    bool? noSelected,
    bool? isEdited,
    bool? isCommentSaved,
    String? userName,
    String? createdBy,
    String? createdOn,
    String? approvedBy,
    String? approvedOn,
    String? simStatus,
    CostSimulatorDetails? costSimulatorDetails,
    CommentFields? commentFields,
    LoadCostSimulatorModel? loadCostSimulatorResp,
    LoadingStatus? loadingStatus,
    LoadingStatus? stepTwoCreateLoadingStatus,
    LoadingStatus? stepTwoSaveLoadingStatus,
    List<CommentField>? commentFieldList,
    List<UnitMeasure>? unitMeasureList,
  }) {
    return StepTwoState(
      createSimLoadingStatus:
          createSimLoadingStatus ?? this.createSimLoadingStatus,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      approvedBy: approvedBy ?? this.approvedBy,
      approvedOn: approvedOn ?? this.approvedOn,
      userName: userName ?? this.userName,
      simStatus: simStatus ?? this.simStatus,
      stepTwoData: stepTwoData ?? this.stepTwoData,
      isEdited: isEdited ?? this.isEdited,
      isCommentSaved: isCommentSaved ?? this.isCommentSaved,
      isStepTwoCompleted: isStepTwoCompleted ?? this.isStepTwoCompleted,
      onShowOthers: onShowOthers ?? this.onShowOthers,
      yesSelected: yesSelected ?? this.yesSelected,
      noSelected: noSelected ?? this.noSelected,
      costSimulatorDetails: costSimulatorDetails ?? this.costSimulatorDetails,
      commentFields: commentFields ?? this.commentFields,
      unitMeasureList: unitMeasureList ?? this.unitMeasureList,
      loadCostSimulatorResp:
          loadCostSimulatorResp ?? this.loadCostSimulatorResp,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      stepTwoCreateLoadingStatus:
          stepTwoCreateLoadingStatus ?? this.stepTwoCreateLoadingStatus,
      stepTwoSaveLoadingStatus:
          stepTwoSaveLoadingStatus ?? this.stepTwoSaveLoadingStatus,
      commentFieldList: commentFieldList ?? this.commentFieldList,
    );
  }

  @override
  List<Object?> get props => [
        createdBy ?? "",
        createdOn ?? "",
        approvedBy ?? "",
        approvedOn ?? "",
        stepTwoData,
        simStatus ?? "",
        isStepTwoCompleted,
        onShowOthers,
        yesSelected,
        noSelected,
        costSimulatorDetails,
        commentFields,
        unitMeasureList,
        loadCostSimulatorResp,
        loadingStatus,
        stepTwoCreateLoadingStatus,
        commentFieldList,
        isCommentSaved,
        stepTwoSaveLoadingStatus,
        isEdited,
        userName,
      ];
}

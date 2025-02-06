import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:johnsonville_cost_simulator/data/model/comment_field_response.model.dart';
import 'package:johnsonville_cost_simulator/data/model/save_comment.model.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';
import '../../data/model/comment_fields.model.dart';
import '../../data/model/cost_simulator_detail.model.dart';
import '../../data/model/load_simulator.model.dart';
import '../../data/model/step_two_request.model.dart';
import '../../data/repository/comments/comments.repo.dart';
import '../../data/repository/create_step_two/create_step_two.repo.dart';
import '../../data/repository/load-simulator/load_simulator.repo.dart';
import '../../main.dart';
import '../../screens/step_two/step_two_widgets/tax_margin_box.dart';
import '../../utils/enums.dart';
import '../../utils/string_const.dart';

part 'step_two_event.dart';
part 'step_two_state.dart';

class StepTwoBloc extends Bloc<StepTwoEvent, StepTwoState> {
  final LoadCostSimulatorRepo loadCostSimulatorRepo =
      autoInjector.get<LoadCostSimulatorRepo>();
  final CreateStepTwoRepo createStepTwoRepo =
      autoInjector.get<CreateStepTwoRepo>();
  final CommentsRepo commentsRepo = autoInjector.get<CommentsRepo>();

  List<UnitMeasure> unitOzMeasureList = <UnitMeasure>[
    UnitMeasure(
      unitName: '/PACK',
      unitCode: 'PACK',
    ),
    UnitMeasure(
      unitName: '/LB',
      unitCode: 'LB',
    ),
  ];
  List<UnitMeasure> unitGmsMeasureList = <UnitMeasure>[
    UnitMeasure(
      unitName: '/PACK',
      unitCode: 'PACK',
    ),
    UnitMeasure(
      unitName: '/KG',
      unitCode: 'KG',
    ),
  ];
  List<UnitMeasure> unitMeasureList = [];
  StepTwoBloc() : super(const StepTwoState()) {
    on<ShowOthersValue>(_showOthers);
    on<NoShowOthersValue>(_noShowOthers);
    on<StepTwoInitial>(_onStepTwoInit);
    on<CommentChecker>(_commentChecker);
    on<CalculateCostOfSales>(_onCalculateCostOfSales);

    //------------Api Calling --------------------//
    on<RetailTaxAndMargin>(_retailTaxAndMargin);
    on<SaveComment>(_onSaveComment);
    on<CostOfSales>(_costOfSales);
    on<DistributorMarginImport>(_distributorMarginImport);
    on<DeliveryAndSupplyChain>(_deliveryAndSupplyChain);
    on<JvlSellPriceAndDiscounts>(_jvlSellPriceAndDiscounts);
    on<SellingExpense>(_sellingExpense);
    on<ViewPricingSheet>(_viewPricingSheet);
    on<StepTwoSave>(_stepTwoOnSave);
    on<OtherListAdd>(_onOtherListAdd);
    on<OtherListRemove>(_onOtherListRemove);
  }

  FutureOr<void> _onOtherListAdd(
    OtherListAdd event,
    Emitter<StepTwoState> emit,
  ) {
    switch (event.otherType) {
      case OtherType.costOfSales:
        List<Other> data =
            List.from(state.costSimulatorDetails.cosOtherList ?? []);
        if ((state.costSimulatorDetails.cosOther?.label?.isNotEmpty ?? false) &&
            (state.costSimulatorDetails.cosOther?.value
                    ?.toString()
                    .isNotEmpty ??
                false)) {
          data.add(state.costSimulatorDetails.cosOther ?? Other());
          emit(
            state.copyWith(
              costSimulatorDetails: state.costSimulatorDetails.copyWith(
                cosOther: Other(),
                cosOtherList: data,
              ),
            ),
          );
        }
      case OtherType.sellPriceAndDiscount:
        List<Other> data =
            List.from(state.costSimulatorDetails.sellDiscountOtherList ?? []);
        if ((state.costSimulatorDetails.sellPriceDiscountOther?.label
                    ?.isNotEmpty ??
                false) &&
            (state.costSimulatorDetails.sellPriceDiscountOther?.value
                    ?.toString()
                    .isNotEmpty ??
                false)) {
          data.add(
              state.costSimulatorDetails.sellPriceDiscountOther ?? Other());
          emit(
            state.copyWith(
              costSimulatorDetails: state.costSimulatorDetails.copyWith(
                sellPriceDiscountOther: Other(),
                sellDiscountOtherList: data,
              ),
            ),
          );
        }
      case OtherType.deliverySupply:
        List<Other> data =
            List.from(state.costSimulatorDetails.deliverySupplyOtherList ?? []);
        if ((state.costSimulatorDetails.deliverySupplyChainOther?.label
                    ?.isNotEmpty ??
                false) &&
            (state.costSimulatorDetails.deliverySupplyChainOther?.value
                    ?.toString()
                    .isNotEmpty ??
                false)) {
          data.add(
              state.costSimulatorDetails.deliverySupplyChainOther ?? Other());
          emit(
            state.copyWith(
              costSimulatorDetails: state.costSimulatorDetails.copyWith(
                deliverySupplyChainOther: Other(),
                deliverySupplyOtherList: data,
              ),
            ),
          );
        }
      case OtherType.sellExpense:
        List<Other> data =
            List.from(state.costSimulatorDetails.sellExpenseOtherList ?? []);
        if ((state.costSimulatorDetails.sellingExpensesOther?.label
                    ?.isNotEmpty ??
                false) &&
            (state.costSimulatorDetails.sellingExpensesOther?.value
                    ?.toString()
                    .isNotEmpty ??
                false)) {
          data.add(state.costSimulatorDetails.sellingExpensesOther ?? Other());
          emit(
            state.copyWith(
              costSimulatorDetails: state.costSimulatorDetails.copyWith(
                sellingExpensesOther: Other(),
                sellExpenseOtherList: data,
              ),
            ),
          );
        }

      default:
    }
    //*------------(calculate cost of sales)
    add(const CalculateCostOfSales());
  }

  FutureOr<void> _onOtherListRemove(
    OtherListRemove event,
    Emitter<StepTwoState> emit,
  ) {
    switch (event.otherType) {
      case OtherType.costOfSales:
        List<Other> data =
            List.from(state.costSimulatorDetails.cosOtherList ?? []);
        data.removeAt(event.index);
        emit(
          state.copyWith(
            costSimulatorDetails: state.costSimulatorDetails.copyWith(
              cosOtherList: data,
            ),
          ),
        );
      case OtherType.sellPriceAndDiscount:
        List<Other> data =
            List.from(state.costSimulatorDetails.sellDiscountOtherList ?? []);
        data.removeAt(event.index);
        emit(
          state.copyWith(
            costSimulatorDetails: state.costSimulatorDetails.copyWith(
              sellDiscountOtherList: data,
            ),
          ),
        );
      case OtherType.deliverySupply:
        List<Other> data =
            List.from(state.costSimulatorDetails.deliverySupplyOtherList ?? []);
        data.removeAt(event.index);
        emit(
          state.copyWith(
            costSimulatorDetails: state.costSimulatorDetails.copyWith(
              deliverySupplyOtherList: data,
            ),
          ),
        );
      case OtherType.sellExpense:
        List<Other> data =
            List.from(state.costSimulatorDetails.sellExpenseOtherList ?? []);
        data.removeAt(event.index);
        emit(
          state.copyWith(
            costSimulatorDetails: state.costSimulatorDetails.copyWith(
              sellExpenseOtherList: data,
            ),
          ),
        );

      default:
    }
  }

  FutureOr<void> _retailTaxAndMargin(
      RetailTaxAndMargin event, Emitter<StepTwoState> emit) async {
    emit(state.copyWith(
      isEdited: true,
      costSimulatorDetails: state.costSimulatorDetails.copyWith(
        isTaxIncludedSelection: event.isTaxIncludedSelection,
        taxIncludedInShelfPrice: event.taxIncludedInShelfPrice,
        shelfPriceTax: event.shelfPriceTax,
        sellUnitOfMeasure: event.sellUnitOfMeasure,
      ),
      commentFields: state.commentFields
          .copyWith(taxAndMarginsComment: event.taxAndMarginsComment),
    ));
    //*------------(calculate cost of sales)
    add(const CalculateCostOfSales());
  }

//TODO add cost of sales
  // Future<String> costOfSalesCalculate() async {
  //   final shelfPriceTax =
  //       double.tryParse(state.costSimulatorDetails.shelfPriceTax) ?? 0;
  //   final retailMargin =
  //       double.tryParse(state.costSimulatorDetails.retailerMargin) ?? 0;
  //   final estDistributorMargin =
  //       double.tryParse(state.costSimulatorDetails.estDistributorMarginOn) ?? 0;

  //   return (shelfPriceTax *
  //           (1 - (retailMargin / 100)) *
  //           (1 - (estDistributorMargin / 100)))
  //       .toStringAsFixed(2);
  // }

  FutureOr<void> _onSaveComment(
      SaveComment event, Emitter<StepTwoState> emit) async {
    final commentField = state.commentFieldList?.firstWhere(
      (element) => element.commentFieldName == event.commentFieldName,
      orElse: () => CommentField(),
    );

    SaveCommentModel? saveCommentResp = await commentsRepo.saveComment(
      costSimulatorID: state.costSimulatorDetails.costSimulatorId,
      commentFieldID: commentField?.commentFieldId.toString() ?? "",
      commentDescription: event.commentDescription ?? "",
    );
    saveCommentResp.isSuccess?.logInfo();
    emit(state.copyWith(
      isEdited: true,
      isCommentSaved: true,
    ));
  }

  FutureOr<void> _costOfSales(CostOfSales event, Emitter<StepTwoState> emit) {
    emit(state.copyWith(
      costSimulatorDetails: state.costSimulatorDetails.copyWith(
        standardCost: event.standardCost,
        cosMeatPpv: event.cosMeatPpv,
        cosMfgVariance: event.cosMfgVariance,
        cosOther: event.cosOther,
        isOtherSelected: event.isOtherSelected,
        isYourStdCostDiffFromAbove: event.isYourStdCostDiffFromAbove,
      ),
      commentFields: state.commentFields.copyWith(
          // stdCostComment: event.standardCostComment,
          // meatPpvComment: event.cosMeatPpvComment,
          // mgfVarianceComment: event.cosMfgVarianceComment,
          // cosOthersComment: event.cosOthersComment,
          costofSalesComment: event.coscostofSalesComment),
      isEdited: true,
    ));
  }

  FutureOr<void> _distributorMarginImport(
      DistributorMarginImport event, Emitter<StepTwoState> emit) async {
    emit(state.copyWith(
      isEdited: true,
      costSimulatorDetails: state.costSimulatorDetails.copyWith(
        estDistributorMarginOn: event.estDistributorMarginOn,
        localTaxVat: event.localTaxVat,
        retailerMargin: event.retailerMargin,
      ),
      // commentFields: state.commentFields.copyWith(
      //   estDistMarginComment: event.estDistributorMarginOnComment,
      // ),
    ));
//*------------(calculate cost of sales)
    add(const CalculateCostOfSales());
  }

  FutureOr<void> _deliveryAndSupplyChain(
      DeliveryAndSupplyChain event, Emitter<StepTwoState> emit) {
    emit(state.copyWith(
      isEdited: true,
      costSimulatorDetails: state.costSimulatorDetails.copyWith(
        importFees: event.importFees,
        localTransport: event.localTransport,
        foreignSupplyChain: event.foreignSupplyChain,
        usDelivery: event.usDelivery,
        usSupplyChain: event.usSupplyChain,
        deliverySupplyChainOther: event.deliverySupplyChainOthers,
        isDeliveryOtherSelected: event.isOtherSelected,
      ),
      commentFields: state.commentFields.copyWith(
        // importFeesComment: event.importFeesComment,
        // localTransportComment: event.localTransportComment,
        // foreignSupplyChainComment: event.foreignSupplyChainComment,
        // usDeliveryComment: event.usDeliveryComment,
        // usSupplyChainComment: event.usSupplyChainComment,
        // deliverySupplyChainOthersCmmnt: event.deliverySupplyChainOthersCmmnt,
        deliveryandSuppChainComment: event.deliveryandSuppChainComment,
      ),
    ));
  }

  FutureOr<void> _jvlSellPriceAndDiscounts(
      JvlSellPriceAndDiscounts event, Emitter<StepTwoState> emit) {
    emit(state.copyWith(
      isEdited: true,
      costSimulatorDetails: state.costSimulatorDetails.copyWith(
        jvlSellPriceForeignCurr: event.jvlSellPriceForeignCurr,
        jvlSellPriceUsd: event.jvlSellPriceUsd,
        discountsPromo: event.discountsPromo,
        discountsCustomer: event.discountsCustomer,
        sellPriceDiscountOther: event.sellPriceDiscountOthers,
        isSellPriceDisOtherSelected: event.isOtherSelected,
      ),
      commentFields: state.commentFields.copyWith(
        // jvlSellPriceForeignCurrencyComment:
        //     event.jvlSellPriceForeignCurrComment,
        // jvlSellPriceUsdComment: event.jvlSellPriceUsdComment,
        // discountPromoComment: event.discountsPromoComment,
        // discountCustomerProgComment: event.discountsCustomerComment,
        // sellPriceDiscountOthersCmmnt: event.sellPriceDiscountOthersCmmnt,
        sellPriceandDiscountComment: event.sellPriceandDiscountComment,
      ),
    ));
    //*------------(calculate cost of sales)
    add(const CalculateCostOfSales());
  }

  FutureOr<void> _sellingExpense(
      SellingExpense event, Emitter<StepTwoState> emit) {
    emit(state.copyWith(
        isEdited: true,
        costSimulatorDetails: state.costSimulatorDetails.copyWith(
          subsidiaryTrade: event.subsidiaryTrade,
          advConsumer: event.advConsumer,
          tradeSpend: event.tradeSpend,
          peopleAndOthers: event.peopleAndOthers,
          isSellingExpenseOtherSelected: event.isOtherSelected,
          sellingExpensesOther: event.sellingExpensesOthers,
          broker: event.broker,
        ),
        commentFields: state.commentFields.copyWith(
          // tradeSpendComment: event.tradeSpendComment,
          // advConsumerComment: event.advConsumerComment,
          // subsidiaryTradeComment: event.subsidiaryTradeComment,
          // peopleOthersComment: event.peopleAndOthersComment,
          // sellingExpensesOthersCmmnt: event.sellingExpensesOthersCmmnt,
          sellingExpensesComment: event.sellingExpensesComment,
        )));
  }

//*-------------------_(view pricing sheet)
  FutureOr<void> _viewPricingSheet(
    ViewPricingSheet event,
    Emitter<StepTwoState> emit,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final createdBy = prefs.getString(
        StringConst.userFirstNameValue,
      );

      emit(
        state.copyWith(
          stepTwoCreateLoadingStatus: LoadingStatus.loading,
          createSimLoadingStatus: LoadingStatus.loading,
        ),
      );
      final response = await createStepTwoRepo.createStepTwo(
        requestBody: StepTwoRequestModel(
          broker: state.costSimulatorDetails.broker,
          cosMeatPpv: state.costSimulatorDetails.cosMeatPpv,
          retailerMargin: state.costSimulatorDetails.retailerMargin,
          retailerMarginPercent: state.costSimulatorDetails.retailerMargin,
          retailSellPriceUOM:
              state.costSimulatorDetails.sellUnitOfMeasure?.unitCode,
          // sellPriceDiscountOthers: "",
          // deliverySupplyChainOthers: "",
          // sellingExpensesOthers: "",
          // cosOthers: "",
          //TODO: need to use this method
          sellPriceDiscountOthers: fCon.convertOtherListToMapList(
            otherList: state.costSimulatorDetails.sellDiscountOtherList ?? [],
            newOther: state.costSimulatorDetails.sellPriceDiscountOther,
          ),
          deliverySupplyChainOthers: fCon.convertOtherListToMapList(
            otherList: state.costSimulatorDetails.deliverySupplyOtherList ?? [],
            newOther: state.costSimulatorDetails.deliverySupplyChainOther,
          ),
          sellingExpensesOthers: fCon.convertOtherListToMapList(
            otherList: state.costSimulatorDetails.sellExpenseOtherList ?? [],
            newOther: state.costSimulatorDetails.sellingExpensesOther,
          ),
          cosOthers: fCon.convertOtherListToMapList(
            otherList: state.costSimulatorDetails.cosOtherList ?? [],
            newOther: state.costSimulatorDetails.cosOther,
          ),
          //TODO:--------
          // state.costSimulatorDetails.isSellPriceDisOtherSelected ==
          //         StringConst.yes
          //     ? state.costSimulatorDetails.sellPriceDiscountOthers
          //     : "",

          // state.costSimulatorDetails.isDeliveryOtherSelected ==
          //         StringConst.yes
          //     ? state.costSimulatorDetails.deliverySupplyChainOthers
          //     : "",

          // state.costSimulatorDetails.isSellingExpenseOtherSelected ==
          //         StringConst.yes
          //     ? state.costSimulatorDetails.sellingExpensesOthers
          //     : "",
          cosMfgVariance: state.costSimulatorDetails.cosMfgVariance,

          // state.costSimulatorDetails.isOtherSelected == StringConst.yes
          //     ? state.costSimulatorDetails.cosOthers
          //     : "",
          cosStdCost: state.costSimulatorDetails.standardCost,
          // cosStdCost: state.costSimulatorDetails.calculatedStandardCost,
          customerDiscount: state.costSimulatorDetails.discountsCustomer,
          distributorMargin: state.costSimulatorDetails.estDistributorMarginOn,
          expConsumerAdv: state.costSimulatorDetails.advConsumer,
          expPeopleOthers: state.costSimulatorDetails.peopleAndOthers,
          expSubsidiarySales: state.costSimulatorDetails.subsidiaryTrade,
          expTradeSpent: state.costSimulatorDetails.tradeSpend,
          foreignSupplyChain: state.costSimulatorDetails.foreignSupplyChain,
          importFees: state.costSimulatorDetails.importFees,
          localTransport: state.costSimulatorDetails.localTransport,
          promotionalDiscount: state.costSimulatorDetails.discountsPromo,
          // retailerMargin: state.costSimulatorDetails.retailMarginOnSales,
          sellPrice: state.costSimulatorDetails.jvlSellPriceForeignCurr,
          sellPriceUsd: state.costSimulatorDetails.jvlSellPriceUsd,
          shelfPriceTax: state.costSimulatorDetails.shelfPriceTax,
          usDelivery: state.costSimulatorDetails.usDelivery,
          usSupplyChain: state.costSimulatorDetails.usSupplyChain,
          isTaxIncluded:
              state.costSimulatorDetails.isTaxIncludedSelection == 'NO'
                  ? "False"
                  : state.costSimulatorDetails.isTaxIncludedSelection == 'YES'
                      ? "True"
                      : "",
          status: state.simStatus,
          costSimulatorId: state.costSimulatorDetails.costSimulatorId,
          updatedBy: createdBy,
          localTaxVat: state.costSimulatorDetails.localTaxVat,
        ).toJson(),
      );

      if (response.isSuccess ?? false) {
        emit(state.copyWith(
            stepTwoCreateLoadingStatus: LoadingStatus.success,
            isEdited: false,
            isStepTwoCompleted: true,
            costSimulatorDetails: state.costSimulatorDetails.copyWith(
              costSimulatorId: response.costSimulatorId.toString(),
            )));
      } else {
        emit(
          state.copyWith(
            stepTwoCreateLoadingStatus: LoadingStatus.failure,
            createSimLoadingStatus: LoadingStatus.failure,
          ),
        );
      }
    } catch (error) {
      error.logFailure();
      emit(
        state.copyWith(
          stepTwoCreateLoadingStatus: LoadingStatus.failure,
          createSimLoadingStatus: LoadingStatus.failure,
        ),
      );
    }
  }

//*----------------------(on step two save)
  FutureOr<void> _stepTwoOnSave(
    StepTwoSave event,
    Emitter<StepTwoState> emit,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final createdBy = prefs.getString(
        StringConst.userFirstNameValue,
      );

      emit(
        state.copyWith(
          stepTwoSaveLoadingStatus: LoadingStatus.loading,
        ),
      );
      final response = await createStepTwoRepo.createStepTwo(
        requestBody: StepTwoRequestModel(
          cosMeatPpv: state.costSimulatorDetails.cosMeatPpv,
          cosMfgVariance: state.costSimulatorDetails.cosMfgVariance,
          retailerMargin: state.costSimulatorDetails.retailerMargin,
          retailerMarginPercent: state.costSimulatorDetails.retailerMargin,
          retailSellPriceUOM:
              state.costSimulatorDetails.sellUnitOfMeasure?.unitCode,
          broker: state.costSimulatorDetails.broker,
          // cosOthers: "",
          // sellPriceDiscountOthers: "",
          // deliverySupplyChainOthers: "",
          // sellingExpensesOthers: "",
          //TODO: need to use this method
          sellPriceDiscountOthers: fCon.convertOtherListToMapList(
            otherList: state.costSimulatorDetails.sellDiscountOtherList ?? [],
            newOther: state.costSimulatorDetails.sellPriceDiscountOther,
          ),
          deliverySupplyChainOthers: fCon.convertOtherListToMapList(
            otherList: state.costSimulatorDetails.deliverySupplyOtherList ?? [],
            newOther: state.costSimulatorDetails.deliverySupplyChainOther,
          ),
          sellingExpensesOthers: fCon.convertOtherListToMapList(
            otherList: state.costSimulatorDetails.sellExpenseOtherList ?? [],
            newOther: state.costSimulatorDetails.sellingExpensesOther,
          ),
          cosOthers: fCon.convertOtherListToMapList(
            otherList: state.costSimulatorDetails.cosOtherList ?? [],
            newOther: state.costSimulatorDetails.cosOther,
          ),
          //Todo----------
          // sellPriceDiscountOthers:
          //     state.costSimulatorDetails.isSellPriceDisOtherSelected ==
          //             StringConst.yes
          //         ? state.costSimulatorDetails.sellPriceDiscountOthers
          //         : "",

          // state.costSimulatorDetails.deliverySupplyChainOthers,
          // state.costSimulatorDetails.isDeliveryOtherSelected ==
          //         StringConst.yes
          //     ? state.costSimulatorDetails.deliverySupplyChainOthers
          //     : "",

          // state.costSimulatorDetails.sellingExpensesOthers,
          // state.costSimulatorDetails.isSellingExpenseOtherSelected ==
          //         StringConst.yes
          //     ? state.costSimulatorDetails.sellingExpensesOthers
          //     : "",
          cosStdCost: state.costSimulatorDetails.standardCost,
          customerDiscount: state.costSimulatorDetails.discountsCustomer,
          distributorMargin: state.costSimulatorDetails.estDistributorMarginOn,
          expConsumerAdv: state.costSimulatorDetails.advConsumer,
          expPeopleOthers: state.costSimulatorDetails.peopleAndOthers,
          // expPeopleOthers: state.costSimulatorDetails.peopleAndOthers,
          expSubsidiarySales: state.costSimulatorDetails.subsidiaryTrade,
          expTradeSpent: state.costSimulatorDetails.tradeSpend,
          foreignSupplyChain: state.costSimulatorDetails.foreignSupplyChain,
          importFees: state.costSimulatorDetails.importFees,
          localTransport: state.costSimulatorDetails.localTransport,
          promotionalDiscount: state.costSimulatorDetails.discountsPromo,
          // retailerMargin: state.costSimulatorDetails.retailMarginOnSales,
          sellPrice: state.costSimulatorDetails.jvlSellPriceForeignCurr,
          sellPriceUsd: state.costSimulatorDetails.jvlSellPriceUsd,
          shelfPriceTax: state.costSimulatorDetails.shelfPriceTax,
          // shelfPriceTax: state.costSimulatorDetails.taxIncludedInShelfPrice,
          usDelivery: state.costSimulatorDetails.usDelivery,
          usSupplyChain: state.costSimulatorDetails.usSupplyChain,
          isTaxIncluded:
              state.costSimulatorDetails.isTaxIncludedSelection == 'NO'
                  ? "False"
                  : state.costSimulatorDetails.isTaxIncludedSelection == 'YES'
                      ? "True"
                      : "",
          status: state.simStatus,
          costSimulatorId: state.costSimulatorDetails.costSimulatorId,
          updatedBy: createdBy,
          localTaxVat: state.costSimulatorDetails.localTaxVat,
        ).toJson(),
      );

      if (response.isSuccess ?? false) {
        emit(state.copyWith(
            stepTwoSaveLoadingStatus: LoadingStatus.success,
            isEdited: false,
            costSimulatorDetails: state.costSimulatorDetails.copyWith(
              costSimulatorId: response.costSimulatorId.toString(),
            )));
      } else {
        emit(
          state.copyWith(
            stepTwoSaveLoadingStatus: LoadingStatus.failure,
          ),
        );
      }
    } catch (error) {
      error.logFailure();
      emit(
        state.copyWith(
          stepTwoSaveLoadingStatus: LoadingStatus.failure,
        ),
      );
    }
  }

  ///============================//

  _showOthers(ShowOthersValue event, Emitter<StepTwoState> emit) {
    emit(
      state.copyWith(
          onShowOthers: true,
          yesSelected: event.isYesTapped,
          noSelected: false),
    );
  }

  _commentChecker(CommentChecker event, Emitter<StepTwoState> emit) {
    emit(
      state.copyWith(isCommentSaved: false),
    );
    emit(
      state.copyWith(isCommentSaved: true),
    );
  }

//*-------------(calculate cost of sales)
  void _onCalculateCostOfSales(
      CalculateCostOfSales event, Emitter<StepTwoState> emit) {
    // Ensure all required fields are not empty
    if (state.costSimulatorDetails.shelfPriceTax.isNotEmpty &&
        state.costSimulatorDetails.retailerMargin.isNotEmpty &&
        state.costSimulatorDetails.estDistributorMarginOn.isNotEmpty &&
        state.costSimulatorDetails.discountsPromo.isNotEmpty &&
        state.costSimulatorDetails.discountsCustomer.isNotEmpty) {
      // Parse input values
      final double shelfPriceWithTax =
          double.tryParse(state.costSimulatorDetails.shelfPriceTax) ?? 0;
      final double retailerMarginPercentage =
          double.tryParse(state.costSimulatorDetails.retailerMargin) ?? 0;
      final double distributorMarginPercentage =
          double.tryParse(state.costSimulatorDetails.estDistributorMarginOn) ??
              0;
      final double promotionalDiscount =
          double.tryParse(state.costSimulatorDetails.discountsPromo) ?? 0;
      final double customerDiscount =
          double.tryParse(state.costSimulatorDetails.discountsCustomer) ?? 0;
      final double otherDiscounts = double.tryParse(fCon.updateSumWithList(
              state.costSimulatorDetails.sellDiscountOtherList ?? [],
              state.costSimulatorDetails.sellPriceDiscountOther?.value ??
                  "0")) ??
          0;

      // Calculate total discounts
      final double totalDiscounts =
          promotionalDiscount + customerDiscount + otherDiscounts;

      // Step-by-step calculation
      final double adjustedShelfPrice =
          shelfPriceWithTax * (1 - (retailerMarginPercentage / 100));
      final double priceAfterDiscounts = adjustedShelfPrice - totalDiscounts;
      final double costOfSales =
          (priceAfterDiscounts * (1 - (distributorMarginPercentage / 100)));

      final String calculatedCostOfSales = costOfSales.toStringAsFixed(2);
      // Update state with calculated values
      if (state.costSimulatorDetails.isYourStdCostDiffFromAbove ==
          StringConst.no) {
        emit(
          state.copyWith(
            costSimulatorDetails: state.costSimulatorDetails.copyWith(
              calculatedStandardCost: calculatedCostOfSales,
              standardCost: calculatedCostOfSales,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            costSimulatorDetails: state.costSimulatorDetails.copyWith(
              calculatedStandardCost: calculatedCostOfSales,
            ),
          ),
        );
      }
    }
  }

// //*-------------(calculate cost of sales)
//   _onCalculateCostOfSales(
//       CalculateCostOfSales event, Emitter<StepTwoState> emit) {
//     if (state.costSimulatorDetails.shelfPriceTax.isNotEmpty &&
//         state.costSimulatorDetails.retailerMargin.isNotEmpty &&
//         state.costSimulatorDetails.estDistributorMarginOn.isNotEmpty) {
//       final shelfPriceTax =
//           double.tryParse(state.costSimulatorDetails.shelfPriceTax) ?? 0;
//       final retailMargin =
//           double.tryParse(state.costSimulatorDetails.retailerMargin) ?? 0;
//       final estDistributorMargin =
//           double.tryParse(state.costSimulatorDetails.estDistributorMarginOn) ??
//               0;

//       String calculatedCostOfSales = (shelfPriceTax *
//               (1 - (retailMargin / 100)) *
//               (1 - (estDistributorMargin / 100)))
//           .toStringAsFixed(2);
//       if (state.costSimulatorDetails.isYourStdCostDiffFromAbove ==
//           StringConst.no) {
//         emit(
//           state.copyWith(
//             costSimulatorDetails: state.costSimulatorDetails.copyWith(
//               calculatedStandardCost: calculatedCostOfSales,
//               standardCost: calculatedCostOfSales,
//             ),
//           ),
//         );
//       } else {
//         emit(
//           state.copyWith(
//             costSimulatorDetails: state.costSimulatorDetails.copyWith(
//               calculatedStandardCost: calculatedCostOfSales,
//             ),
//           ),
//         );
//       }
//     }
//   }

  _noShowOthers(NoShowOthersValue event, Emitter<StepTwoState> emit) {
    emit(
      state.copyWith(
          onShowOthers: false,
          noSelected: event.isNoTapped,
          yesSelected: false),
    );
  }

  Future<FutureOr<void>> _onStepTwoInit(
      StepTwoInitial event, Emitter<StepTwoState> emit) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();

    String userName = prefs.getString(
          StringConst.userFirstNameValue,
        ) ??
        '';

    emit(StepTwoState(
        loadingStatus: LoadingStatus.loading,
        userName: userName,
        costSimulatorDetails: state.costSimulatorDetails.copyWith(
          costSimulatorId: event.id ?? "0",
        )));
    LoadCostSimulatorModel? loadCostSimResp =
        await loadCostSimulatorRepo.getLoadCostSimulatorList(
      costSimulatorId: event.id ?? "0",
    );
    if (loadCostSimResp?.packUom == "OZ") {
      unitMeasureList = List.from(unitOzMeasureList);
    } else {
      unitMeasureList = List.from(unitGmsMeasureList);
    }
    CommentFieldResponseModel? commentFieldListData =
        await commentsRepo.fetchCommentFieldData();
    List<CommentField> commentFieldList =
        commentFieldListData.commentFields ?? [];
    final sellUnitOfMeasure = loadCostSimResp?.retailSellPriceUom != null
        ? unitMeasureList.firstWhere(
            (element) {
              return element.unitCode == loadCostSimResp?.retailSellPriceUom;
            },
            orElse: () => UnitMeasure(),
          )
        : null;

    emit(state.copyWith(
      isCommentSaved: false,
      unitMeasureList: unitMeasureList,
      loadingStatus: LoadingStatus.success,
      simStatus: loadCostSimResp?.status,
      createdBy: loadCostSimResp?.createdBy,
      createdOn: loadCostSimResp?.createdOn,
      approvedBy: loadCostSimResp?.approvedBy,
      approvedOn: loadCostSimResp?.approvedOn,
      commentFieldList: commentFieldList,
      costSimulatorDetails: state.costSimulatorDetails.copyWith(
        costSimulatorId: event.id ?? "0",
        packUOM: loadCostSimResp?.packUom ?? "",
        broker: loadCostSimResp?.brokerValue,
        cosMeatPpv: loadCostSimResp?.cosMeatPpv ?? "",
        othersLimit: loadCostSimResp?.othersLimit ?? 0,
        itemCurrency: loadCostSimResp?.consumerCurrencyId ?? '',
        cosMfgVariance: loadCostSimResp?.cosMfgVariance ?? "",

        cosOther: (loadCostSimResp?.cosOther?.length == 1)
            ? loadCostSimResp?.cosOther?.lastOrNull
            : (loadCostSimResp?.cosOther?.length == 3)
                ? (loadCostSimResp?.cosOther?.firstOrNull)
                : Other(),
        cosOtherList: (loadCostSimResp?.cosOther?.length == 1)
            ? []
            : (loadCostSimResp?.cosOther?.length == 3)
                ? loadCostSimResp?.cosOther?.sublist(1, 3) ?? []
                : loadCostSimResp?.cosOther ?? [],
        sellPriceDiscountOther:
            (loadCostSimResp?.sellPriceDiscountsOthers?.length == 1)
                ? loadCostSimResp?.sellPriceDiscountsOthers?.lastOrNull
                : (loadCostSimResp?.sellPriceDiscountsOthers?.length == 3)
                    ? (loadCostSimResp?.sellPriceDiscountsOthers?.firstOrNull)
                    : Other(),
        sellDiscountOtherList: (loadCostSimResp
                    ?.sellPriceDiscountsOthers?.length ==
                1)
            ? []
            : (loadCostSimResp?.sellPriceDiscountsOthers?.length == 3)
                ? loadCostSimResp?.sellPriceDiscountsOthers?.sublist(1, 3) ?? []
                : loadCostSimResp?.sellPriceDiscountsOthers ?? [],
        deliverySupplyChainOther:
            (loadCostSimResp?.delSupplyChainOthers?.length == 1)
                ? loadCostSimResp?.delSupplyChainOthers?.lastOrNull
                : (loadCostSimResp?.delSupplyChainOthers?.length == 3)
                    ? loadCostSimResp?.delSupplyChainOthers?.firstOrNull
                    : Other(),
        deliverySupplyOtherList:
            (loadCostSimResp?.delSupplyChainOthers?.length == 1)
                ? []
                : (loadCostSimResp?.delSupplyChainOthers?.length == 3)
                    ? loadCostSimResp?.delSupplyChainOthers?.sublist(1, 3)
                    : loadCostSimResp?.delSupplyChainOthers ?? [],
        // loadCostSimResp?.delSupplyChainOthers ?? "",
        sellingExpensesOther:
            (loadCostSimResp?.sellingExpenseOthers?.length == 1)
                ? loadCostSimResp?.sellingExpenseOthers?.lastOrNull
                : (loadCostSimResp?.sellingExpenseOthers?.length == 3)
                    ? loadCostSimResp?.sellingExpenseOthers?.firstOrNull
                    : Other(),
        sellExpenseOtherList:
            (loadCostSimResp?.sellingExpenseOthers?.length == 1)
                ? []
                : (loadCostSimResp?.sellingExpenseOthers?.length == 3)
                    ? loadCostSimResp?.sellingExpenseOthers?.sublist(1, 3)
                    : loadCostSimResp?.sellingExpenseOthers ?? [],
        standardCost: loadCostSimResp?.cosStdCost ?? "",
        discountsCustomer: loadCostSimResp?.customerDiscount ?? "",
        estDistributorMarginOn: loadCostSimResp?.distributorMargin ?? "",
        localTaxVat: loadCostSimResp?.localTaxVat ?? "",
        //TODO: need to add this value
        retailerMargin: loadCostSimResp?.retailerMargin,
        sellUnitOfMeasure: sellUnitOfMeasure,
        advConsumer: loadCostSimResp?.expConsumerAdv ?? "",
        peopleAndOthers: loadCostSimResp?.expPeopleOthers ?? "",
        subsidiaryTrade: loadCostSimResp?.expSubsidiarySales ?? "",
        tradeSpend: loadCostSimResp?.expTradeSpent ?? "",
        foreignSupplyChain: loadCostSimResp?.foreignSupplyChain ?? "",
        importFees: loadCostSimResp?.importFees ?? "",
        localTransport: loadCostSimResp?.localTransport ?? "",
        discountsPromo: loadCostSimResp?.promotionalDiscount ?? "",
        shelfPriceTax: loadCostSimResp?.shelfPriceTax ?? "",
        jvlSellPriceForeignCurr: loadCostSimResp?.sellPrice ?? "",
        jvlSellPriceUsd: loadCostSimResp?.sellPriceUsd ?? "",
        // taxIncludedInShelfPrice: loadCostSimResp?.shelfPriceTax ?? "",
        usDelivery: loadCostSimResp?.usDelivery ?? "",
        usSupplyChain: loadCostSimResp?.usSupplyChain ?? "",
        isTaxIncludedSelection: StringConst.yes,
        // isTaxIncludedSelection:
        //     (loadCostSimResp?.isTaxIncluded ?? "") == 'True' ||
        //             (loadCostSimResp?.isTaxIncluded ?? "") == 'true'
        //         ? StringConst.yes
        //         : (loadCostSimResp?.isTaxIncluded ?? "") == 'False' ||
        //                 (loadCostSimResp?.isTaxIncluded ?? "") == 'false'
        //             ? StringConst.no
        //             : '',
        // isOtherSelected: (loadCostSimResp?.cosOthers?.isNotEmpty ?? false)
        //     ? StringConst.yes
        //     : StringConst.no,
        // isSellPriceDisOtherSelected:
        //     (loadCostSimResp?.sellPriceDiscountOthers?.isNotEmpty ?? false)
        //         ? StringConst.yes
        //         : StringConst.no,
        // isDeliveryOtherSelected:
        //     (loadCostSimResp?.deliverySupplyChainOthers?.isNotEmpty ?? false)
        //         ? StringConst.yes
        //         : StringConst.no,
        // isSellingExpenseOtherSelected:
        //     (loadCostSimResp?.sellingExpensesOthers?.isNotEmpty ?? false)
        //         ? StringConst.yes
        //         : StringConst.no,
      ),
      commentFields: state.commentFields.copyWith(
        //*-----------comments
        // meatPpvComment: loadCostSimResp?.meatPpvCmmnt ?? '',
        // cosOthersComment: loadCostSimResp?.cosOthersCmmnt ?? '',
        // sellPriceDiscountOthersCmmnt:
        //     loadCostSimResp?.sellPriceDiscountOthersCmmnt ?? '',
        // deliverySupplyChainOthersCmmnt:
        //     loadCostSimResp?.deliverySupplyChainOthersCmmnt ?? '',
        // sellingExpensesOthersCmmnt:
        //     loadCostSimResp?.sellingExpensesOthersCmmnt ?? '',

        // mgfVarianceComment: loadCostSimResp?.mgfVarianceCmmnt ?? '',
        // estDistMarginComment: loadCostSimResp?.estDistributorMarginCmmnt ?? '',
        // importFeesComment: loadCostSimResp?.importFeesCmmnt ?? '',
        // stdCostComment: loadCostSimResp?.standardCostCmmnt ?? "",

        // retailMarginComment: loadCostSimResp?.retailMarginonSalesCmmnt ?? "",
        // localTransportComment: loadCostSimResp?.localTransportCmmnt ?? "",
        // foreignSupplyChainComment:
        //     loadCostSimResp?.foreignSupplyChainCmmnt ?? '',
        // usDeliveryComment: loadCostSimResp?.usDeliveryCmmnt ?? '',
        // usSupplyChainComment: loadCostSimResp?.usSupplyChainCmmnt ?? '',
        // jvlSellPriceForeignCurrencyComment:
        //     loadCostSimResp?.jvlSellPriceForeignCurrencyCmmnt ?? '',
        // jvlSellPriceUsdComment: loadCostSimResp?.jvlSellPriceUsdCmmnt ?? '',
        // discountPromoComment: loadCostSimResp?.discountsPromoCmmnt ?? "",
        // discountCustomerProgComment:
        //     loadCostSimResp?.discountsCustomerProgCmmnt ?? "",
        // subsidiaryTradeComment: loadCostSimResp?.subsidiaryTradeCmmnt ?? "",
        // advConsumerComment: loadCostSimResp?.advConsumerCmmnt ?? "",
        // tradeSpendComment: loadCostSimResp?.tradeSpendCmmnt ?? "",
        // peopleOthersComment: loadCostSimResp?.peopleOthersCmmnt ?? "",
        taxAndMarginsComment: loadCostSimResp?.taxAndMarginsComment ?? "",
        costofSalesComment: loadCostSimResp?.costOfSalesComment ?? "",
        sellPriceandDiscountComment:
            loadCostSimResp?.sellPriceAndDiscountComment ?? "",
        deliveryandSuppChainComment:
            loadCostSimResp?.deliveryAndSuppChainComment ?? "",
        sellingExpensesComment: loadCostSimResp?.sellingExpensesComment ?? "",
      ),
      onShowOthers: false,
      yesSelected: false,
      noSelected: false,
    ));

// //*------------(calculate cost of sales)
    final double shelfPriceWithTax =
        double.tryParse(loadCostSimResp?.shelfPriceTax ?? "0") ?? 0;
    final double retailerMarginPercentage =
        double.tryParse(loadCostSimResp?.retailerMargin ?? "0") ?? 0;
    final double distributorMarginPercentage =
        double.tryParse(loadCostSimResp?.distributorMargin ?? "0") ?? 0;
    final double promotionalDiscount =
        double.tryParse(loadCostSimResp?.promotionalDiscount ?? "0") ?? 0;
    final double customerDiscount =
        double.tryParse(loadCostSimResp?.customerDiscount ?? "0") ?? 0;

    final double otherDiscounts = double.tryParse(fCon.updateSumWithList(
          loadCostSimResp?.sellPriceDiscountsOthers ?? [],
          "0",
        )) ??
        0;
    // Calculate total discounts
    final double totalDiscounts =
        promotionalDiscount + customerDiscount + otherDiscounts;
    final double adjustedShelfPrice =
        shelfPriceWithTax * (1 - (retailerMarginPercentage / 100));
    final double priceAfterDiscounts = adjustedShelfPrice - totalDiscounts;
    final double costOfSales =
        (priceAfterDiscounts * (1 - (distributorMarginPercentage / 100)));
    final String calculatedCostOfSales = costOfSales.toStringAsFixed(2);
    emit(state.copyWith(
        costSimulatorDetails: state.costSimulatorDetails.copyWith(
      calculatedStandardCost: calculatedCostOfSales,
    )));
//     final shelfPriceTax =
//         double.tryParse(loadCostSimResp?.shelfPriceTax ?? "0") ?? 0;
//     final retailMargin =
//         double.tryParse(loadCostSimResp?.retailerMargin ?? "0") ?? 0;
//     final estDistributorMargin =
//         double.tryParse(state.costSimulatorDetails.estDistributorMarginOn) ?? 0;

//     String calculatedCostOfSales = (shelfPriceTax *
//             (1 - (retailMargin / 100)) *
//             (1 - (estDistributorMargin / 100)))
//         .toStringAsFixed(2);
    String standardCost =
        double.tryParse(state.costSimulatorDetails.standardCost)
                ?.toStringAsFixed(2) ??
            "";

    if (state.costSimulatorDetails.standardCost.isNotEmpty &&
        calculatedCostOfSales.isNotEmpty) {
      if (calculatedCostOfSales == standardCost) {
        emit(state.copyWith(
          costSimulatorDetails: state.costSimulatorDetails.copyWith(
            calculatedStandardCost: calculatedCostOfSales,
            isYourStdCostDiffFromAbove: StringConst.no,
          ),
        ));
      } else {
        emit(state.copyWith(
          costSimulatorDetails: state.costSimulatorDetails.copyWith(
            calculatedStandardCost: calculatedCostOfSales,
            isYourStdCostDiffFromAbove: StringConst.yes,
          ),
        ));
      }
    } else {
      emit(state.copyWith(
        costSimulatorDetails: state.costSimulatorDetails.copyWith(
          calculatedStandardCost: calculatedCostOfSales,
          isYourStdCostDiffFromAbove: StringConst.no,
        ),
      ));
    }
  }
}

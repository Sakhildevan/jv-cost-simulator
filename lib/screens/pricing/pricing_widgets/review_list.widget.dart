import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/pricing_bloc/pricing_bloc.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/themes/app_colors.dart';

import 'delivery_and_supply_chain_total_row.dart';
import 'gross_profit_percent_row.dart';
import 'gross_profit_row.dart';
import 'gross_sales_row.dart';
import 'net_sales_row.dart';
import 'operating_profit_row.dart';
import 'operation_profit_percent.row.dart';
import 'sell_expense_total.row.dart';
import 'standard_cost_row.dart';

class ReviewList extends StatelessWidget {
  const ReviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        return Column(
          children: [
            commonSpace,
            //shelf price
            const GrossSalesRow(
              color: AppColors.reviewGreen,
              textColor: AppColors.white,
            ),
            commonSpace,
            //net sales
            const NetSalesRow(
              color: AppColors.reviewGreen,
              textColor: AppColors.white,
              // total: false,
              isReviewList: true,
            ),
            commonSpace,
            const StandardCost(
              color: AppColors.reviewGreen,
              textColor: AppColors.white,
              // total: false,
              isReviewList: true,
            ),
            // const CostGoodSoldTotalRow(
            // color: AppColors.reviewGrey,
            // textColor: AppColors.white,
            // // total: false,
            // isReviewList: true,
            // ),
            //cost of goods
            commonSpace,
            //delivery
            const DeliveryAndSupplyTotalRow(
              color: AppColors.reviewGreen,
              textColor: AppColors.white,
              // total: false,
              isReviewList: true,
            ),
            commonSpace,
            //gross profit
            const GrossProfitRow(
              color: AppColors.maroon,
              textColor: AppColors.white,
              // total: false,
              isReviewList: true,
            ),
            commonSpace,
            //gross profit %
            const GrossProfitPercentRow(
              color: AppColors.maroon,
              textColor: AppColors.white,
              // total: false,
              isReviewList: true,
            ),
            commonSpace,
            //sell expense
            const SellExpenseTotalRow(
              color: AppColors.reviewGrey,
              textColor: AppColors.white,
              // total: false,
              isReviewList: true,
            ),
            commonSpace,
            //operating profit
            const OperationProfitRow(
              color: AppColors.kTextBlue,
              textColor: AppColors.white,
              // total: false,
              isReviewList: true,
            ),
            commonSpace,
            //operating profit
            const OperationProfitPercentRow(
              color: AppColors.kTextBlue,
              textColor: AppColors.white,
              // total: false,
              isReviewList: true,
            ),
            commonSpace,

            //net profit %
            // const NetProfitPercentRow(
            //   isReviewList: true,
            // ),
            // commonSpace,
          ],
        );
      },
    );
  }

  Widget get commonSpace => kDim.kGap02;
}

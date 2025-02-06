import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/pricing_bloc/pricing_bloc.dart';
import '../../../styles/text_styles.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/row_width.dart';
import 'pricing_table_sub_title.widget.dart';
import 'pricing_table_title.widget.dart';

class SheetRowTitleAndSub extends StatelessWidget {
  const SheetRowTitleAndSub({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(
      builder: (context, state) {
        return const Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //!-----(table title)
            PricingTableTitle(),

            PricingSubTitle(),
            //!---------Calculated Shelf Price-------------//
            // commented for future use
            // ShelfPriceRow(),
          ],
        );
      },
    );
  }

  Widget numbers({String? number}) {
    return Expanded(
        child: RowWidth(
      child: KStyles().reg(
        text: number ?? '',
        color: AppColors.white,
      ),
    ));
  }
}

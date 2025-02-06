import 'package:flutter/material.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/global_extensions.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/string_const.dart';

//!------------------------------------SelectionYesNoBox Page-----------------------------------------!
class SelectionYesNoBox extends StatelessWidget {
  final Function()? onYesTap;
  final Function()? onNoTap;
  final String label;
  final Color? yesColor;
  final Color? noColor;
  const SelectionYesNoBox({
    required this.onNoTap,
    required this.onYesTap,
    required this.label,
    this.yesColor,
    this.noColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: KStyles().reg(
            size: 12,
            text: label,
            color: AppColors.black,
          ),
        ),
        5.width,
        Expanded(flex: 2, child: _selectionBox()),
      ],
    );
  }

//!----------------_selectionBox----------------
  Widget _selectionBox() {
    return Row(
      children: [
        //!----------------_selectBoxYes----------------
        Expanded(
          child: InkWell(
            onTap: onYesTap,
            child: _selectBoxYes(),
          ),
        ),
        5.width,
        //!----------------_selectBoxNo----------------
        Expanded(
          child: InkWell(
            onTap: onNoTap,
            child: _selectBoxNo(),
          ),
        ),
        10.width,
        const Expanded(flex: 2, child: SizedBox()),
      ],
    );
  }

//!----------------_selectBoxYes----------------
  Widget _selectBoxYes() {
    return Container(
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(2),
        color: yesColor ?? AppColors.lightGrey,
      ),
      child: Center(
        child: KStyles().reg(
          size: 12,
          text: StringConst.yes,
          color: AppColors.grey,
        ),
      ),
    );
  }

//!----------------_selectBoxNo----------------
  Widget _selectBoxNo() {
    return Container(
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(2),
        color: noColor ?? AppColors.lightGrey,
      ),
      child: Center(
        child: KStyles().reg(
          size: 12,
          text: StringConst.no,
          color: AppColors.grey,
        ),
      ),
    );
  }
}

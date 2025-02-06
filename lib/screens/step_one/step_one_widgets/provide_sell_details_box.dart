import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../bloc/step_one_bloc/step_one_bloc.dart';
import '../../../data/model/subsidiary_resp.model.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/enums.dart';
import '../../../utils/global_extensions.dart';
import '../../../utils/string_const.dart';
import '../../../widgets/custom_box_title.dart';
import '../../../widgets/custom_text_field_label.dart';
import '../../../widgets/post_frame_callback.dart';
import '../../../widgets/shimmer.widget.dart';

class ProvideSellDetailsBox extends StatelessWidget {
  const ProvideSellDetailsBox({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController customerNameCtrl = TextEditingController();
    void addPostFrameCallback() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final state = context.read<StepOneBloc>().state;

        // Using the reusable method for both controllers
        updateTextController(customerNameCtrl, state.customerName);
      });
    }

    return BlocConsumer<StepOneBloc, StepOneState>(
      listener: (context, state) {},
      builder: (context, state) {
        addPostFrameCallback();
        if (state.loadingStatus == LoadingStatus.loading) {
          return const ShimmerLoader(type: ShimmerType.box);
        }
        return CustomBoxTitle(
          title: StringConst.provideSellDetails,
          imagePath: Assets.images.sellDetails.path,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //!-----------------Customer textfield-------------------
              CustomTextFieldLabel(
                dataList: state.customerNameList,
                showAddIcon: true,
                onSuffixIconPressed: () {
                  context.read<StepOneBloc>().add(const CustomerNameAdd());
                },
                keyboardType: TextInputType.text,
                inputFormat: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z, ]')),
                ],
                controller: customerNameCtrl,
                onDeleteTap: (int? index) {
                  context
                      .read<StepOneBloc>()
                      .add(CustomerNameRemove(index ?? -1));
                },
                commonValidator: (String? value) {
                  return null;

                  ///commented for future use
                  // return fCon.commonValidation(
                  //   inputValue: value ?? "",
                  //   errorMsg: StringConst.enterValueError,
                  // );
                },
                hintText: StringConst.hintCustName,
                onChanged: (String customerName) {
                  context.read<StepOneBloc>().add(
                        ProvideSellDetailUpdate(
                          customerName: customerName,
                        ),
                      );
                },
                text: StringConst.customerName,
              ),
              10.height,

              //!-----------------Subsidiary Sale Dropdown-------------------
              CustomTextFieldLabel<Subsidiary>(
                displayText: (Subsidiary? item) {
                  return item?.subsidiaryName;
                },
                value: (Subsidiary? item) {
                  return item?.subsidiaryId;
                },
                dropDownValidator: (Subsidiary? value) {
                  return null;

                  ///commented for future use
                  // return fCon.commonValidation(
                  //   inputValue: value?.profitCenterCode ?? "",
                  //   errorMsg: StringConst.pleaseSelectYourJvlSubsidiary,
                  // );
                },
                dropDownHintText: StringConst.selectTheJVLSubsidiary,
                contentPadding: EdgeInsets.only(
                  left: -5,
                  right: 5,
                  top: getValueForScreenType(
                    context: context,
                    mobile: 6,
                    tablet: 9,
                    desktop: 10,
                  ),
                  bottom: getValueForScreenType(
                    context: context,
                    mobile: 10,
                    tablet: 13,
                    desktop: 10,
                  ),
                ),
                dropDownValue: state.subsidiaryId,
                itemList: state.dropDownSubsidiaryList,
                onDropDownChanged: (
                  Subsidiary? subsidiaryId,
                ) {
                  context.read<StepOneBloc>().add(
                        ProvideSellDetailUpdate(
                          subsidiaryId: subsidiaryId,
                        ),
                      );
                },
                text: StringConst.subSale,
                dropDown: true,
              ),
              10.height,
            ],
          ),
        );
      },
    );
  }
}

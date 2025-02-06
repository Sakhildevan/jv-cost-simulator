import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/step_one_bloc/step_one_bloc.dart';
import 'package:johnsonville_cost_simulator/data/model/business_unit_resp.model.dart';
import 'package:johnsonville_cost_simulator/gen/assets.gen.dart';
import 'package:johnsonville_cost_simulator/utils/enums.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../config/config.dart';
import '../../../data/model/production_country_resp.model.dart';
import '../../../data/model/production_plant_resp.model.dart';
import '../../../utils/global_extensions.dart';
import '../../../utils/string_const.dart';
import '../../../widgets/custom_box_title.dart';
import '../../../widgets/custom_text_field_label.dart';
import '../../../widgets/post_frame_callback.dart';

class ProjectInformationBox extends StatelessWidget {
  const ProjectInformationBox({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController itemNameCtrl = TextEditingController();
    final TextEditingController itemDescriptionCtrl = TextEditingController();

    void addPostFrameCallback() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final state = context.read<StepOneBloc>().state;

        // Using the reusable method for both controllers
        updateTextController(itemNameCtrl, state.itemName);
        updateTextController(itemDescriptionCtrl, state.itemDescription);
      });
    }

    //*custom item information box--
    return BlocConsumer<StepOneBloc, StepOneState>(
      listener: (context, state) {},
      builder: (context, state) {
        addPostFrameCallback();
        if (state.loadingStatus == LoadingStatus.loading) {
          return uiCon.shimmerLoader(
            type: ShimmerType.box,
          );
        }
        return CustomBoxTitle(
          //   //*itemInformation heading and image
          title: StringConst.projectInformation,
          imagePath: Assets.images.sellDetails.path,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //*Project name text fields
              _buildProjectName(itemNameCtrl, context),
              10.height,
              //*item description text field
              _buildProjectDescription(itemDescriptionCtrl, context),
              10.height,
              //*product Country dropdown
              _buildProductionCountryDropDown(context, state),
              10.height,
              //*product plant dropdown
              _buildProductionPlantDropDown(context, state),
              10.height,
              //*(business unit)
              _buildBusinessUnitDropDown(context, state),
              10.height,
            ],
          ),
        );
      },
    );
  }

  ///business unit dropdown
  CustomTextFieldLabel<BusinessUnit> _buildBusinessUnitDropDown(
      BuildContext context, StepOneState state) {
    return CustomTextFieldLabel<BusinessUnit>(
      displayText: (BusinessUnit? item) {
        return item?.businessUnitName;
      },
      value: (BusinessUnit? item) {
        return item?.businessUnitId;
      },
      dropDownValidator: (BusinessUnit? value) {
        return fCon.commonValidation(
          inputValue: value?.businessUnitId ?? "",
          errorMsg: StringConst.pleaseSelectYourBusinessUnit,
        );
      },
      dropDownHintText: StringConst.selectYourBusinessUnit,
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
      dropDownValue: state.businessUnit,
      text: StringConst.businessUnit,
      itemList: state.dropDownBusinessUnitList,
      dropDown: true,
      onDropDownChanged: (
        BusinessUnit? businessUnit,
      ) {
        //calling production Location Id update
        context.read<StepOneBloc>().add(
              ItemInfoUpdateValue(
                businessUnit: businessUnit,
              ),
            );
      },
    );
  }

  /// production plant dropdown
  CustomTextFieldLabel<ProductionPlant> _buildProductionPlantDropDown(
      BuildContext context, StepOneState state) {
    return CustomTextFieldLabel<ProductionPlant>(
      displayText: (ProductionPlant? item) {
        return item?.productionPlantName;
      },
      value: (ProductionPlant? item) {
        return item?.productionPlantId;
      },
      dropDownValidator: (ProductionPlant? value) {
        return fCon.commonValidation(
          inputValue: value?.productionPlantId ?? "",
          errorMsg: StringConst.pleaseSelectYourPlant,
        );
      },
      dropDownHintText: StringConst.selectYourPlant,
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
      dropDownValue: state.productionPlant,
      text: StringConst.productPlant,
      itemList: state.dropDownProdPlantList,
      dropDown: true,
      onDropDownChanged: (
        ProductionPlant? productionPlant,
      ) {
        //calling production Location Id update
        context.read<StepOneBloc>().add(
              ItemInfoUpdateValue(
                productionPlant: productionPlant,
              ),
            );
      },
    );
  }

  ///production country dropdown
  CustomTextFieldLabel<ProductionCountry> _buildProductionCountryDropDown(
      BuildContext context, StepOneState state) {
    return CustomTextFieldLabel<ProductionCountry>(
      displayText: (ProductionCountry? item) {
        return item?.countryName;
      },
      value: (ProductionCountry? item) {
        return item?.countryId;
      },
      dropDownValidator: (ProductionCountry? value) {
        return fCon.commonValidation(
          inputValue: value?.countryId ?? "",
          errorMsg: StringConst.pleaseSelectYourCountry,
        );
      },
      dropDownHintText: StringConst.selectYourCountry,
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
      dropDownValue: state.productionCountry,
      text: StringConst.productCountry,
      itemList: state.dropDownProdCountryList,
      dropDown: true,
      onDropDownChanged: (
        ProductionCountry? productionCountry,
      ) {
        //calling production Location Id update
        context.read<StepOneBloc>().add(
              ItemInfoUpdateValue(
                productionCountry: productionCountry,
              ),
            );
        context.read<StepOneBloc>().add(
              ProdPlantUpdate(
                productionCountry: productionCountry,
              ),
            );
      },
    );
  }

  /// project description textfield
  CustomTextFieldLabel<dynamic> _buildProjectDescription(
      TextEditingController itemDescriptionCtrl, BuildContext context) {
    return CustomTextFieldLabel(
      keyboardType: TextInputType.text,
      controller: itemDescriptionCtrl,
      commonValidator: (String? value) {
        return fCon.commonValidation(
          inputValue: value ?? "",
          errorMsg: StringConst.enterValueError,
        );
      },
      hintText: StringConst.hintprojectdis,
      onChanged: (String itemDescription) {
        //calling item Description update
        context.read<StepOneBloc>().add(ItemInfoUpdateValue(
              itemDescription: itemDescription,
            ));
      },
      text: StringConst.projectDescription,
    );
  }

  /// project name textfield
  CustomTextFieldLabel<dynamic> _buildProjectName(
      TextEditingController itemNameCtrl, BuildContext context) {
    return CustomTextFieldLabel(
      keyboardType: TextInputType.text,
      controller: itemNameCtrl,
      commonValidator: (String? value) {
        return fCon.commonValidation(
          inputValue: value ?? "",
          errorMsg: StringConst.enterValueError,
        );
      },
      hintText: StringConst.hintprojectname,
      onChanged: (String itemName) {
        //calling item info update
        context.read<StepOneBloc>().add(
              ItemInfoUpdateValue(
                itemName: itemName,
              ),
            );
      },
      text: StringConst.projectName,
    );
  }
}

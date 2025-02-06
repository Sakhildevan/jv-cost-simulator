import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:johnsonville_cost_simulator/utils/string_const.dart';

import '../../config/config.dart';
import '../../styles/text_styles.dart';
import '../../themes/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.onSearchTap,
    required this.onCloseTap,
    required this.onChanged,
    required this.searchCtrl,
    required this.onClear,
  });
  final void Function(String)? onSearchTap;
  final void Function(String)? onChanged;
  final void Function()? onCloseTap;
  final void Function()? onClear;
  final TextEditingController searchCtrl;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //!----(search bar )
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardCream,
                  borderRadius: kDim.kRadius25,
                ),
                height: 40,
                child: SearchBar(
                  onChanged: onChanged,
                  hintText: StringConst.searchByItem,
                  hintStyle: const WidgetStatePropertyAll(
                    TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                    ),
                  ),
                  controller: searchCtrl,
                  trailing: [
                    InkWell(
                        borderRadius: kDim.kRadius100,
                        onTap: onClear,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: KStyles().med(
                            text: StringConst.clear,
                            color: AppColors.kTextBlue,
                            size: 14,
                          ),
                        )),
                  ],
                  overlayColor: const WidgetStatePropertyAll(
                    AppColors.cardCream,
                  ),
                  backgroundColor: const WidgetStatePropertyAll(
                    AppColors.cardCream,
                  ),
                  elevation: const WidgetStatePropertyAll(0),
                )),
          ),
          const Gap(15),
          InkWell(
            onTap: () {
              if (searchCtrl.text.isNotEmpty) {
                onSearchTap!(searchCtrl.text);
              } else {
                onSearchTap!("");
              }
            },
            child: const Icon(
              size: 35,
              Icons.search,
              color: AppColors.kTextBlue,
            ),
          ),
          const Gap(15),
          InkWell(
            borderRadius: kDim.kRadius100,
            onTap: onCloseTap,
            child: const Icon(
              size: 35,
              Icons.close,
              color: AppColors.kTextBlue,
            ),
          ),
          const Gap(15),
        ],
      ),
    );
  }
}

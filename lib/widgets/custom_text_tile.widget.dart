import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../config/config.dart';
import '../styles/text_styles.dart';
import '../themes/app_colors.dart';

class CustomTextTile extends StatelessWidget {
  const CustomTextTile({
    super.key,
    this.onDeleteTap,
    required this.text,
    this.showDelete,
  });

  final void Function()? onDeleteTap;
  final String text;
  final bool? showDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: kDim.kRadius04,
        color: AppColors.boxBackGround,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: KStyles().reg(
              overflow: TextOverflow.visible,
              text: text,
              size: getValueForScreenType(
                context: context,
                mobile: 10,
                tablet: 12,
                desktop: 14,
              ),
              color: AppColors.black,
            ),
          ),
          getValueForScreenType(
            context: context,
            mobile: kDim.kGap02,
            tablet: kDim.kGap02,
            desktop: kDim.kGap05,
          ),
          (showDelete ?? false)
              ? InkWell(
                  borderRadius: kDim.kRadius100,
                  onTap: onDeleteTap,
                  child: Icon(
                    Icons.delete_forever,
                    color: AppColors.grey,
                    size: getValueForScreenType(
                      context: context,
                      mobile: 16,
                      tablet: 18,
                      desktop: 20,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

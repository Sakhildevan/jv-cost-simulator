import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../styles/text_styles.dart';
import '../../../themes/app_colors.dart';

class ResponsiveImageButton extends StatelessWidget {
  const ResponsiveImageButton({
    super.key,
    required this.image,
    required this.text,
    this.onTap,
    this.isLoading,
  });
  final String image;
  final String text;
  final void Function()? onTap;
  final bool? isLoading;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      if (sizingInformation.isDesktop) {
        return InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //!--------download--------
              Image.asset(
                image,
                // AppImages.downloadIcon,
                scale: 3,
              ),
              5.width,
              KStyles().bold(
                text: text,
                // StringConst.downloadExcel,
                size: 11,
              ),
              (isLoading ?? false)
                  ? Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: uiCon.circleLoader(
                        color: AppColors.maroon,
                      ))
                  : const SizedBox.shrink(),
            ],
          ),
        );
      } else {
        return InkWell(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                image,
                scale: 3,
              ),
              5.width,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  KStyles().bold(
                    text: text,
                    size: 7,
                  ),
                  (isLoading ?? false)
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: uiCon.circleLoader(
                            color: AppColors.maroon,
                          ))
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        );
      }
    });
  }
}

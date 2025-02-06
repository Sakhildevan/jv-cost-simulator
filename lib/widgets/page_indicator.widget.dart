import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../config/config.dart';
import '../themes/app_colors.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.currentIndex,
    required this.totalPage,
    required this.onTap,
  });
  final int currentIndex;
  final int totalPage;
  final void Function(int? index) onTap;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
              height: 25,
              child: Row(
                children: [
                  //!----back icon-----------
                  InkWell(
                    onTap: () {
                      currentIndex != 0 ? onTap(currentIndex - 1) : onTap(0);
                    },
                    child: const Icon(
                      opticalSize: 8,
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.kTextBlue,
                    ),
                  ),
                  const Gap(10),
                  //!----current page-----------
                  Container(
                    alignment: Alignment.center,
                    width: 20,
                    decoration: BoxDecoration(
                      color: AppColors.kTextBlue,
                      borderRadius: kDim.kRadius100,
                    ),
                    child: KStyles().bold(
                      text: '${currentIndex + 1}',
                      size: getValueForScreenType(
                        context: context,
                        mobile: 12,
                        tablet: 14,
                        desktop: 15,
                      ),
                      color: AppColors.white,
                    ),
                  ),
                  const Gap(5),
                  //!----'-' text-----------
                  KStyles().bold(
                    text: '-',
                    size: getValueForScreenType(
                      context: context,
                      mobile: 12,
                      tablet: 14,
                      desktop: 15,
                    ),
                  ),
                  const Gap(5),
                  //!----total page-----------
                  KStyles().bold(
                    text: '$totalPage',
                    size: getValueForScreenType(
                      context: context,
                      mobile: 12,
                      tablet: 14,
                      desktop: 15,
                    ),
                  ),
                  const Gap(10),
                  //!----next icon-----------
                  InkWell(
                    borderRadius: kDim.kRadius100,
                    onTap: () {
                      currentIndex != totalPage - 1
                          ? onTap(currentIndex + 1)
                          : onTap(totalPage - 1);
                    },
                    child: const Icon(
                      opticalSize: 8,
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.kTextBlue,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

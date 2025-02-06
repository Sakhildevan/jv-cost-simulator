import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shimmer/shimmer.dart';

import '../themes/app_colors.dart';
import '../utils/enums.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({
    this.listCount,
    required this.type,
    super.key,
  });

  final int? listCount;
  final ShimmerType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ShimmerType.box:
        return boxType();
      case ShimmerType.list:
        return listType();

      default:
        return listType();
    }
  }

//*---------(box type)
  Widget boxType() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      color: AppColors.boxBackGroundOrange,
      child: Shimmer.fromColors(
        baseColor: AppColors.boxBackGround,
        highlightColor: AppColors.boxBackGroundOrange,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //!----------------image and title----------------
            Row(
              children: [
                Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: const BoxDecoration(
                    color: AppColors.boxBackGround,
                    shape: BoxShape.rectangle,
                  ),
                ),
                const SizedBox(width: 24.0),
                Container(
                  height: 15.0,
                  width: 200.0,
                  decoration: const BoxDecoration(
                    color: AppColors.boxBackGround,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            //!-------------1st row
            SizedBox(
              height: 100,
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listCount ?? 3,
                  separatorBuilder: (context, index) => const Gap(15),
                  itemBuilder: (context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 15.0,
                          width: 00.0,
                          decoration: BoxDecoration(
                            color: AppColors.boxBackGround,
                            borderRadius: kDim.kRadius04,
                          ),
                        ),
                        const SizedBox(width: 30.0),
                        Container(
                          height: 15.0,
                          width: getValueForScreenType(
                            context: context,
                            mobile: 100,
                            tablet: 150,
                            desktop: 200,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.boxBackGround,
                            borderRadius: kDim.kRadius04,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

//*-------(list type)
  Widget listType() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listCount ?? 0,
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        return Shimmer.fromColors(
          baseColor: AppColors.lighterGrey,
          highlightColor: AppColors.lightGrey,
          child: ListTile(
            title: Container(
              height: 15.0,
              decoration: const BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

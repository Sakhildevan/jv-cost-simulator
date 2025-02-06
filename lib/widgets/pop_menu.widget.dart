import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/home_bloc/home_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../themes/app_colors.dart';

class PopMenu extends StatefulWidget {
  const PopMenu({
    super.key,
    this.icon,
    this.menuBuilder,
    this.menuOnChange,
    this.arrowColor,
    required this.popMenuCtrl,
  });
  final Widget? icon;
  final Widget Function()? menuBuilder;
  final void Function(bool)? menuOnChange;
  final Color? arrowColor;
  final CustomPopupMenuController popMenuCtrl;

  @override
  State<PopMenu> createState() => _PopMenuState();
}

class _PopMenuState extends State<PopMenu> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return CustomPopupMenu(
          barrierColor: Colors.black.withOpacity(0.5),
          showArrow: true,
          arrowColor: widget.arrowColor ?? AppColors.white,
          arrowSize: 20,
          horizontalMargin: 1,
          position: PreferredPosition.bottom,
          menuBuilder: widget.menuBuilder ??
              () => buildMenuBuilder(
                    state,
                    context,
                    widget.popMenuCtrl,
                  ),
          controller: widget.popMenuCtrl,
          menuOnChange: widget.menuOnChange ??
              (val) {
                context.read<HomeBloc>().add(OnMenuChanged(val));
              },
          pressType: PressType.singleClick,
          child: widget.icon ??
              Icon(
                Icons.menu_rounded,
                color: AppColors.maroon,
                size: getValueForScreenType(
                  context: context,
                  mobile: 24,
                  tablet: 30,
                  desktop: 45,
                ),
              ),
        );
      },
    );
  }

  ClipRRect buildMenuBuilder(HomeState state, BuildContext context,
      CustomPopupMenuController customPopupMenuController) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        decoration: buildBoxDecorationForMenu(),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.popUpOption
                .map(
                  (item) => buildTextCheckPoints(
                    context,
                    state,
                    item,
                    customPopupMenuController,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

BoxDecoration buildBoxDecorationForMenu() {
  return const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(6)),
    color: AppColors.boxBackGround,
  );
}

Container buildTextCheckPoints(
  BuildContext context,
  HomeState state,
  String item,
  CustomPopupMenuController customPopupMenuController,
) {
  return Container(
    width: 200,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: InkWell(
      onTap: () {
        customPopupMenuController.hideMenu();
        context.read<HomeBloc>().add(ChangeMenu(item));
      },
      child: Text(
        item,
        style: TextStyle(
          fontWeight:
              state.selectedOption == item ? FontWeight.bold : FontWeight.w500,
          color: state.selectedOption == item
              ? AppColors.kTextBlue
              : AppColors.black,
          decorationColor: AppColors.kTextBlue,
          fontSize: 16,
          decoration: state.selectedOption == item
              ? TextDecoration.underline
              : TextDecoration.none,
        ),
      ),
    ),
  );
}

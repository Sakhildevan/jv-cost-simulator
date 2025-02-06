import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';

import '../config/config.dart';
import '../gen/assets.gen.dart';
import '../routes/routes_constants.dart';
import '../styles/text_styles.dart';
import '../utils/string_const.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.userName,
    this.isUserVisible,
  });
  final String userName;
  final bool? isUserVisible;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            context.goNamed(RouteConstants.name.home);
          },
          child: uiCon.logo(context),
        ),
        (isUserVisible ?? true)
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          AssetImage(Assets.images.personLogin.path),
                      radius: 25,
                    ),
                  ),
                  KStyles().semiBold(
                    text: "Hi,  $userName",
                    color: Colors.white,
                    size: 13,
                  ),
                  7.width,
                  SizedBox(
                    height: 13,
                    child: VerticalDivider(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  7.width,
                  _logout(context),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  InkWell _logout(BuildContext context) {
    return InkWell(
      onTap: () async {
        await fCon.removeLoginCredentials();
        if (context.mounted) {
          context.goNamed(RouteConstants.name.initial);
        }
      },
      child: KStyles().light(
        text: StringConst.logOut,
        color: Colors.white,
        size: 13,
      ),
    );
  }
}

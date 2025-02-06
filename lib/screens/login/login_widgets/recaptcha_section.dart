// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/gen/assets.gen.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/bloc/login/login_bloc.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:johnsonville_cost_simulator/utils/string_const.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../themes/app_colors.dart';

class ReCaptchaIntegration extends StatelessWidget {
  const ReCaptchaIntegration({
    super.key,
    required this.onChanged,
    required this.isChecked,
  });
  final void Function(bool?)? onChanged;
  final bool isChecked;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppColors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: _contentInsideCheckBox(context),
            ),
          ],
        );
      },
    );
  }

  Padding _contentInsideCheckBox(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 7,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _checkBoxWithTitle(context),
          _captchaImageWithPrivacy(context),
        ],
      ),
    );
  }

  Column _captchaImageWithPrivacy(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        uiCon.pngImage(
          assetImage: Assets.images.reCaptcha.path,
          ht: 35,
          wd: 35,
        ),
        _privacyAndTermsLink(context),
      ],
    );
  }

  RichText _privacyAndTermsLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 12.0, color: Colors.grey),
        children: <TextSpan>[
          TextSpan(
            text: StringConst.privacy,
            style: KStyles()
                .reg(
                  text: '',
                  size: getValueForScreenType(
                    context: context,
                    mobile: 7,
                    tablet: 9,
                    desktop: 10,
                  ),
                )
                .style,
            recognizer: TapGestureRecognizer()
              ..onTap = () async => (StringConst.privacyLink),
          ),
          const TextSpan(text: '-'),
          TextSpan(
            text: StringConst.terms,
            style: KStyles()
                .reg(
                  text: '',
                  size: getValueForScreenType(
                    context: context,
                    mobile: 7,
                    tablet: 9,
                    desktop: 10,
                  ),
                )
                .style,
            recognizer: TapGestureRecognizer()
              ..onTap = () async => (StringConst.termsLink),
          ),
        ],
      ),
    );
  }

  BlocBuilder _checkBoxWithTitle(
    context,
  ) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Row(
          children: <Widget>[
            10.width,
            state.loadingToken
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.red,
                    ),
                  )
                : Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.black),
                      shape: BoxShape.rectangle,
                    ),
                    child: Checkbox(
                      side: BorderSide.none,
                      activeColor: AppColors.white,
                      checkColor: AppColors.red,
                      value: isChecked,
                      onChanged: onChanged,
                    ),
                  ),
            10.width,
            KStyles().semiBold(
              text: StringConst.iAmNotARobot,
              size: 12,
              color: AppColors.black,
            ),
          ],
        );
      },
    );
  }
}

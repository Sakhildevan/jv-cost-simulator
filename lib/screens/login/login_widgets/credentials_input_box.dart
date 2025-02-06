import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:johnsonville_cost_simulator/utils/enums.dart';
import 'package:johnsonville_cost_simulator/utils/global_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/login/login_bloc.dart';
import '../../../constants/dimensions.dart';
import '../../../themes/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/string_const.dart';
import '../../../widgets/custom_login_text_field.dart';
import 'recaptcha_section.dart';

class CredentialsInputBox extends StatefulWidget {
  const CredentialsInputBox({
    super.key,
  });

  @override
  State<CredentialsInputBox> createState() => _CredentialsInputBoxState();
}

class _CredentialsInputBoxState extends State<CredentialsInputBox> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // form key for login validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _loadEmail(); // Call the method to load email from local storage
  }

  // Method to load email from shared preferences
  void _loadEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString(StringConst.userMailId);
    if (savedEmail != null) {
      emailController.text = savedEmail;
    }
    //TODO password functionality
    // String? password = prefs.getString(StringConst.passwordValue);
    // if (password != null) {
    //   passwordController.text = password;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.lighterGrey,
              borderRadius: BorderRadius.circular(6),
            ),
            width: 300,
            child: _contentInsideTheBox(context, state),
          );
        });
  }

  Padding _contentInsideTheBox(
    BuildContext context,
    LoginState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          20.height,
          uiCon.logo(context),
          20.height,
          (state.loadingStatus == LoadingStatus.failure)
              ? Column(
                  children: [
                    buildInvalidLoginCard(
                      context,
                      StringConst.invalidLoginDetails,
                    ),
                    10.height,
                  ],
                )
              : const SizedBox.shrink(),
          (emailController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty &&
                  state.isReCaptchaChecked == false &&
                  state.captchaChecked == true)
              ? Column(
                  children: [
                    buildInvalidLoginCard(
                      context,
                      StringConst.pleaseTickReCaptcha,
                    ),
                    10.height,
                  ],
                )
              : const SizedBox.shrink(),
          _inputCredentialsSection(),
        ],
      ),
    );
  }

  Widget _inputCredentialsSection() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              _emailTextField(context),
              15.height,
              _passwordTextField(
                context,
                context.read<LoginBloc>(),
                state,
              ),
              15.height,
              ReCaptchaIntegration(
                onChanged: (bool? value) {
                  if (formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(ReCaptchaTapEvent(
                          checkBoxValue: value ?? false,
                        ));
                    Timer(
                        const Duration(
                          seconds: 15,
                        ), () {
                      if (context.mounted) {
                        context.read<LoginBloc>().add(const ReCaptchaTapEvent2(
                              checkBoxValue: false,
                            ));
                      }
                    });
                  }
                },
                isChecked: state.isReCaptchaChecked ?? false,
              ),
              20.height,
              _appButton(
                context,
                state,
                onTap: () async {
                  context.read<LoginBloc>().add(const ReCaptchaCheckEvent());

                  //*----------(validation added )
                  if (formKey.currentState!.validate() &&
                      state.isReCaptchaChecked == true) {
                    context.read<LoginBloc>().add(OnSubmitLogin(
                          email: emailController.text,
                          password: passwordController.text,
                        ));

                    // Save email to local storage
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString('user_email', emailController.text);
                  } else {
                    context.read<LoginBloc>().add(const ReCaptchaCheckEvent3());
                  }
                },
              ),
              20.height,
            ],
          ),
        );
      },
    );
  }

  CustomTextfield _passwordTextField(
    BuildContext context,
    LoginBloc bloc,
    LoginState state,
  ) {
    return CustomTextfield(
      // onChanged: (p0) {
      //   textOnChanged(text: p0, txtFieldType: TextFieldType.password);
      // },
      validator: (String? value) {
        return fCon.loginValidation(
          textFieldType: TextFieldType.password,
          inputValue: value ?? "",
        );
      },
      obscureText: state.isObscure,
      hintText: StringConst.password,
      controller: passwordController,
      suffixIcon: InkWell(
        onTap: () {
          bloc.add(
            const OnPasswordObscure(),
          );
        },
        child: Icon(
          state.isObscure ? Icons.visibility_off : Icons.visibility,
          color: AppColors.grey,
        ),
      ),
    );
  }

  CustomTextfield _emailTextField(BuildContext context) {
    return CustomTextfield(
      // onChanged: (p0) {
      //   textOnChanged(
      //     text: p0,
      //     txtFieldType: TextFieldType.userName,
      //   );
      // },
      validator: (String? value) {
        return fCon.loginValidation(
          textFieldType: TextFieldType.userName,
          inputValue: value ?? "",
        );
      },
      obscureText: false,
      hintText: StringConst.email,
      controller: emailController,
    );
  }

  Widget _appButton(
    BuildContext context,
    LoginState state, {
    required dynamic Function()? onTap,
  }) {
    return state.loadingStatus == LoadingStatus.loading
        ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              AppColors.maroon,
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: uiCon.simButton(
              height: getValueForScreenType(
                context: context,
                mobile: 30,
                tablet: 30,
                desktop: 40,
              ),
              onPressed: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.lighterGrey,
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: AppColors.maroon,
                  size: getValueForScreenType(
                    context: context,
                    mobile: 10,
                    tablet: 12,
                    desktop: 25,
                  ),
                ),
              ),
              text: StringConst.startTheSimulator,
            ));
  }

  //*--------------------(Method for textfield on change )
  void textOnChanged({
    required TextFieldType txtFieldType,
    required String text,
  }) {
    // if the textfield type is email
    if (txtFieldType == TextFieldType.userName) {
      formKey.currentState!.validate();
    } else {
      //if the textfield type is password
      formKey.currentState!.validate();
    }
  }
}

//*------(invalid login card method)
Container buildInvalidLoginCard(BuildContext context, String text) {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 5,
    ),
    decoration: BoxDecoration(
      color: AppColors.loginErrorColor,
      border: Border.all(
        color: AppColors.orange.withOpacity(0.45),
      ),
      borderRadius: KDimension().kRadius05,
    ),
    height: getValueForScreenType(
      context: context,
      mobile: 40,
      tablet: 40,
      desktop: 40,
    ),
    width: Constants.width,
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: KStyles().med(
          text: text,
          size: 14,
        )),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:johnsonville_cost_simulator/bloc/login/login_bloc.dart';
import 'package:johnsonville_cost_simulator/gen/assets.gen.dart';
import 'package:johnsonville_cost_simulator/routes/routes_constants.dart';
import 'package:johnsonville_cost_simulator/styles/text_styles.dart';
import 'package:johnsonville_cost_simulator/utils/constants.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../themes/app_colors.dart';
import '../../utils/enums.dart';
import '../../utils/string_const.dart';
import 'login_widgets/credentials_input_box.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Constants.width = MediaQuery.of(context).size.width;
    Constants.height = MediaQuery.of(context).size.height;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoginBloc>().add(const LoginInit());
    });

    return Scaffold(
      body: _body(
        context,
      ),
    );
  }

//-body
  Widget _body(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loadingStatus == LoadingStatus.success) {
          context.goNamed(
            RouteConstants.name.home,
          );
        }
      },
      child: Container(
        width: Constants.width,
        height: Constants.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.loginBg.path),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.loginBg1.path),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            width: Constants.width * 0.9,
            height: Constants.height * 0.8,
            child: _bodyTitleBox(
              context,
            ),
          ),
        ),
      ),
    );
  }

//body title box
  Widget _bodyTitleBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //*----(title)
          _bodyTitle(context),
          //*----(credential input box)
          const CredentialsInputBox(),
        ],
      ),
    );
  }

// title
  Widget _bodyTitle(BuildContext context) {
    return KStyles().bold(
      text: StringConst.loginTitle,
      size: getValueForScreenType(
        context: context,
        mobile: 15,
        tablet: 20,
        desktop: Constants.width > 1440 ? 40 : 24,
      ),
      textAlign: TextAlign.center,
      color: AppColors.white,
    );
  }
}

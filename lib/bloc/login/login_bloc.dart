import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:johnsonville_cost_simulator/config/config.dart';
import 'package:johnsonville_cost_simulator/constants/api_constants.dart';
import 'package:johnsonville_cost_simulator/data/model/login.model.dart';
import 'package:johnsonville_cost_simulator/data/repository/auth/login.repo.dart';
import 'package:johnsonville_cost_simulator/utils/logger_extension';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../utils/enums.dart';
import '../../utils/string_const.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  //*--------(repo instance)
  final LoginRepo loginRepo = autoInjector.get<LoginRepo>();
  LoginBloc() : super(const LoginState()) {
    on<LoginInit>(_onInit);
    on<OnSubmitLogin>(_onSubmit);
    on<ReCaptchaCheckEvent>(_onReCaptchaCheckEvent);
    on<OnPasswordObscure>(_onPassObscure);
    on<ReCaptchaTapEvent>(_onReCaptchaCheck);
    on<ReCaptchaTapEvent2>(_onReCaptchaCheck2);
    on<ReCaptchaCheckEvent3>(_onReCaptchaChecksubmit);
  }
//*-------(on login init)
  _onInit(LoginInit event, Emitter<LoginState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString(StringConst.userMailId);
    final String? password = prefs.getString(StringConst.passwordValue);
    if (kIsWeb) {
      //!---(setting Re captcha)
      await GRecaptchaV3.ready(ApiConst.reCaptchaKey, showBadge: false);
    }
    emit(LoginState(
      isReCaptchaChecked: false,
      loadingStatus: LoadingStatus.initial,
      email: email ?? "",
      password: password ?? '',
    ));
  }

  _onSubmit(OnSubmitLogin event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      loadingStatus: LoadingStatus.loading,
    ));
    try {
      LoginModel response = await loginRepo.login(
        userName: event.email,
        password: event.password,
      );
      if (response.isSuccess ?? false) {
        //*-----(setting login credentials)
        await fCon.storeLoginCredentials(
          token: response.loginToken ?? "",
          mailId: event.email,
          password: event.password,
          userFirstName: response.firstName ?? '',
          userId: response.userId ?? '',
          userRole: response.userRole ?? "",
          isAdmin: response.isAdmin ?? false,
        );
        emit(state.copyWith(
            loadingStatus: LoadingStatus.success, captchaChecked: false));
      } else {
        emit(state.copyWith(
            loadingStatus: LoadingStatus.failure, captchaChecked: false));
      }
    } on Exception catch (e) {
      e.logError();
      emit(state.copyWith(
        loadingStatus: LoadingStatus.failure,
      ));
    }
  }

  _onReCaptchaCheckEvent(
      ReCaptchaCheckEvent event, Emitter<LoginState> emit) async {
    if (state.isReCaptchaChecked ?? false) {
      emit(state.copyWith(showReCaptChaError: false));
    } else {
      emit(state.copyWith(showReCaptChaError: true));
    }
  }

  _onPassObscure(OnPasswordObscure event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      isObscure: !state.isObscure,
    ));
  }

  FutureOr<void> _onReCaptchaCheck(
      ReCaptchaTapEvent event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(loadingToken: true),
    );
    if (event.checkBoxValue) {
      String token = await GRecaptchaV3.execute('submit') ?? 'null returned';
      GRecaptchaV3.hideBadge();
      emit(
        state.copyWith(
          isReCaptchaChecked: true,
          tokenValue: token,
          loadingToken: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isReCaptchaChecked: false,
          tokenValue: '',
          loadingToken: false,
        ),
      );
    }
  }

  FutureOr<void> _onReCaptchaCheck2(
      ReCaptchaTapEvent2 event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        isReCaptchaChecked: false,
        tokenValue: '',
      ),
    );
  }

  FutureOr<void> _onReCaptchaChecksubmit(
      ReCaptchaCheckEvent3 event, Emitter<LoginState> emit) async {
    if (state.loadingStatus != LoadingStatus.failure) {
      emit(state.copyWith(captchaChecked: true));
    }
  }
}

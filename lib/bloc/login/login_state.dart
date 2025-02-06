part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final String tokenValue;
  final bool isObscure;
  final bool? isReCaptchaChecked;
  final bool? showReCaptChaError;
  final bool loadingToken;
  final bool captchaChecked;
  final LoadingStatus? loadingStatus;

  const LoginState({
    this.email = '',
    this.password = '',
    this.tokenValue = '',
    this.isObscure = true,
    this.isReCaptchaChecked,
    this.loadingToken = false,
    this.showReCaptChaError,
    this.captchaChecked = false,
    this.loadingStatus = LoadingStatus.initial,
  });

  LoginState copyWith({
    String? email,
    String? password,
    String? tokenValue,
    LoadingStatus? loadingStatus,
    bool? isObscure,
    bool? isReCaptchaChecked,
    bool? loadingToken,
    bool? showReCaptChaError,
    bool? captchaChecked,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isObscure: isObscure ?? this.isObscure,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      isReCaptchaChecked: isReCaptchaChecked ?? this.isReCaptchaChecked,
      tokenValue: tokenValue ?? this.tokenValue,
      loadingToken: loadingToken ?? this.loadingToken,
      showReCaptChaError: showReCaptChaError ?? this.showReCaptChaError,
      captchaChecked: captchaChecked ?? this.captchaChecked,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        loadingStatus ?? LoadingStatus.initial,
        isObscure,
        isReCaptchaChecked ?? false,
        loadingToken,
        tokenValue,
        showReCaptChaError ?? false,
        captchaChecked,
      ];
}

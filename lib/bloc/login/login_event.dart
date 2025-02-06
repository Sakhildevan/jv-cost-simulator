part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class OnSubmitLogin extends LoginEvent {
  final String email;
  final String password;
  const OnSubmitLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class OnPasswordObscure extends LoginEvent {
  const OnPasswordObscure();

  @override
  List<Object> get props => [];
}

class ReCaptchaCheckEvent extends LoginEvent {
  const ReCaptchaCheckEvent();

  @override
  List<Object> get props => [];
}

class ReCaptchaCheckEvent3 extends LoginEvent {
  const ReCaptchaCheckEvent3();

  @override
  List<Object> get props => [];
}

class ReCaptchaTapEvent extends LoginEvent {
  final bool checkBoxValue;
  const ReCaptchaTapEvent({
    required this.checkBoxValue,
  });

  @override
  List<Object> get props => [checkBoxValue];
}

class ReCaptchaTapEvent2 extends LoginEvent {
  final bool checkBoxValue;
  const ReCaptchaTapEvent2({
    required this.checkBoxValue,
  });

  @override
  List<Object> get props => [checkBoxValue];
}

class LoginInit extends LoginEvent {
  const LoginInit();
}

part of 'signup_login_bloc.dart';

sealed class SignupLoginEvent extends Equatable {
  const SignupLoginEvent();

  @override
  List<Object> get props => [];
}

class SwitchToSignupOrLogin extends SignupLoginEvent {
  @override
  List<Object> get props => [];

  const SwitchToSignupOrLogin();
}

class SwitchPasswordVisibility extends SignupLoginEvent {
  @override
  List<Object> get props => [];

  const SwitchPasswordVisibility();
}

class CreateAccount extends SignupLoginEvent {
  final String name;
  final String email;
  final String password;
  final MainBloc mainBloc;

  @override
  List<Object> get props => [];

  const CreateAccount({
    required this.name,
    required this.email,
    required this.password,
    required this.mainBloc,
  });
}

class Login extends SignupLoginEvent {
  final String email;
  final String password;
  final MainBloc mainBloc;
  @override
  List<Object> get props => [];

  const Login({
    required this.email,
    required this.password,
    required this.mainBloc,
  });
}

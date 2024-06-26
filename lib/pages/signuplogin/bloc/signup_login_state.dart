part of 'signup_login_bloc.dart';

class SignupLoginState extends Equatable {
  final bool isLogin;
  final bool isPasswordHidden;
  final DateTime dateTime;
  final bool isSignupLoginDone;
  final bool hasError;
  final String errorMessage;

  const SignupLoginState({
    required this.isLogin,
    required this.isPasswordHidden,
    required this.dateTime,
    required this.isSignupLoginDone,
    required this.hasError,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [
        isLogin,
        isPasswordHidden,
        dateTime,
        isSignupLoginDone,
        hasError,
        errorMessage,
      ];

  SignupLoginState.initial()
      : isLogin = false,
        isPasswordHidden = true,
        dateTime = DateTime.now(),
        isSignupLoginDone = false,
        hasError = false,
        errorMessage = '';

  SignupLoginState copyWith({
    bool? isLogin,
    bool? isPasswordHidden,
    DateTime? dateTime,
    bool? isSignupLoginDone,
    bool? hasError,
    String? errorMessage,
  }) {
    return SignupLoginState(
      isLogin: isLogin ?? this.isLogin,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      dateTime: dateTime ?? this.dateTime,
      isSignupLoginDone: isSignupLoginDone ?? this.isSignupLoginDone,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

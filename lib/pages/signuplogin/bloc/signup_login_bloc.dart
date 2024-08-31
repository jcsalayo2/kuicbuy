import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kuicbuy/bloc/main_bloc.dart';
import 'package:kuicbuy/services/firebase_auth.dart';

part 'signup_login_event.dart';
part 'signup_login_state.dart';

class SignupLoginBloc extends Bloc<SignupLoginEvent, SignupLoginState> {
  SignupLoginBloc() : super(SignupLoginState.initial()) {
    on<SignupLoginEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SwitchToSignupOrLogin>(_switchToSignupOrLogin);
    on<SwitchPasswordVisibility>(_switchPasswordVisibility);
    on<CreateAccount>(_createAccount);
    on<Login>(_login);
  }

  FutureOr<void> _switchToSignupOrLogin(
      SwitchToSignupOrLogin event, Emitter<SignupLoginState> emit) {
    emit(state.copyWith(
      isLogin: !state.isLogin,
      dateTime: DateTime.now(),
    ));
  }

  FutureOr<void> _switchPasswordVisibility(
      SwitchPasswordVisibility event, Emitter<SignupLoginState> emit) {
    emit(state.copyWith(
      dateTime: DateTime.now(),
      isPasswordHidden: !state.isPasswordHidden,
    ));
  }

  FutureOr<void> _createAccount(
      CreateAccount event, Emitter<SignupLoginState> emit) async {
    var result = await FirebaseAuthService(FirebaseAuth.instance).signUp(
      email: event.email,
      password: event.password,
      name: event.name,
    );

    if (result == true) {
      final FirebaseAuth auth = FirebaseAuth.instance;
      event.mainBloc.add(GetSaved(uid: auth.currentUser!.uid));
      event.mainBloc.add(ListenToChats(uid: auth.currentUser!.uid));
      emit(state.copyWith(
        isSignupLoginDone: true,
      ));
    } else {
      emit(state.copyWith(
        isSignupLoginDone: false,
        hasError: true,
        errorMessage: getErrorDisplay(result),
        dateTime: DateTime.now(),
      ));
      emit(state.copyWith(
        hasError: false,
        errorMessage: "",
        dateTime: DateTime.now(),
      ));
    }
  }

  getErrorDisplay(result) {
    switch (result) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-not-found':
        return 'User not found';
      case 'wrong-password':
        return 'Wrong password';
      default:
        return 'An unknown error occurred.';
    }
  }

  FutureOr<void> _login(Login event, Emitter<SignupLoginState> emit) async {
    var result = await FirebaseAuthService(FirebaseAuth.instance).logIn(
      email: event.email,
      password: event.password,
    );

    if (result == true) {
      final FirebaseAuth auth = FirebaseAuth.instance;
      event.mainBloc.add(GetSaved(uid: auth.currentUser!.uid));
      event.mainBloc.add(ListenToChats(uid: auth.currentUser!.uid));
      emit(state.copyWith(
        isSignupLoginDone: true,
      ));
    } else {
      emit(state.copyWith(
        isSignupLoginDone: false,
        hasError: true,
        errorMessage: getErrorDisplay(result),
        dateTime: DateTime.now(),
      ));
      emit(state.copyWith(
        hasError: false,
        errorMessage: "",
        dateTime: DateTime.now(),
      ));
    }
  }
}

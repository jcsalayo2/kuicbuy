import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/models/account_model.dart';
import 'package:kuicbuy/services/account_services.dart';
import 'package:kuicbuy/services/generative_ai_service.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountState.initial()) {
    on<AccountEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetAccount>(_getAccount);
  }

  FutureOr<void> _getAccount(
      GetAccount event, Emitter<AccountState> emit) async {
    emit(state.copyWith(
      accountStatus: AccountStatus.loading,
    ));

    if (event.userId == '') {
      // await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(
        accountStatus: AccountStatus.noAccount,
      ));
      return;
    }

    var account = await AccountServices().getUser(userId: event.userId);

    emit(state.copyWith(
      account: account,
      accountStatus: AccountStatus.hasAccount,
    ));

    // var test = await GenerativeAIService().getIntro(name: account.fullName);
    // print('TEST: ${test}');
  }
}

part of 'account_bloc.dart';

class AccountState extends Equatable {
  final Account? account;
  final AccountStatus accountStatus;

  const AccountState({
    required this.account,
    required this.accountStatus,
  });

  @override
  List<Object> get props => [accountStatus];

  AccountState.initial()
      : account = null,
        accountStatus = AccountStatus.loading;

  AccountState copyWith({
    Account? account,
    AccountStatus? accountStatus,
  }) {
    return AccountState(
      account: account ?? this.account,
      accountStatus: accountStatus ?? this.accountStatus,
    );
  }
}

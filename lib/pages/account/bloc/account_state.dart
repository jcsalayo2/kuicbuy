part of 'account_bloc.dart';

class AccountState extends Equatable {
  final Account? account;
  final AccountStatus accountStatus;
  final DateTime timestamp;

  const AccountState({
    required this.account,
    required this.accountStatus,
    required this.timestamp,
  });

  @override
  List<Object> get props => [
        accountStatus,
        timestamp,
      ];

  AccountState.initial()
      : account = null,
        accountStatus = AccountStatus.loading,
        timestamp = DateTime.now();

  AccountState copyWith({
    Account? account,
    AccountStatus? accountStatus,
    DateTime? timestamp,
  }) {
    return AccountState(
      account: account ?? this.account,
      accountStatus: accountStatus ?? this.accountStatus,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetAccount extends AccountEvent {
  final String userId;

  @override
  List<Object> get props => [];

  const GetAccount({required this.userId});
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/pages/account/bloc/account_bloc.dart';
import 'package:kuicbuy/pages/signuplogin/signuplogin.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: () {
                    switch (state.accountStatus) {
                      case AccountStatus.loading:
                        return Colors.grey;
                      case AccountStatus.noAccount:
                        return Colors.blue[100];
                      case AccountStatus.hasAccount:
                        return Colors.green;
                    }
                  }(),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: () {
                if (state.accountStatus == AccountStatus.loading) {
                  return null;
                } else if (state.accountStatus == AccountStatus.noAccount) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(
                            child: Text("Get exclusive deals. Sign up now")),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupLogin(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.login_rounded,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state.accountStatus == AccountStatus.hasAccount) {
                  return Text("Account Detected");
                }
              }(),
            )
          ],
        );
      },
    );
  }
}

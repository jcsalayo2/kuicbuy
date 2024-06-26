import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/pages/account/bloc/account_bloc.dart';
import 'package:kuicbuy/pages/add_product/add_product.dart';
import 'package:kuicbuy/pages/signuplogin/signuplogin.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
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
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
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
                            onTap: () async {
                              // ignore: unused_local_variable
                              final value = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupLogin(),
                                ),
                              );

                              BlocProvider.of<AccountBloc>(context).add(
                                  GetAccount(
                                      userId: auth.currentUser?.uid ?? ''));
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
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: Image.network(
                                state.account!.avatar,
                                width: 75,
                                height: 75,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.account?.fullName ??
                                      "Something is Wrong",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  auth.currentUser?.email ??
                                      "Something is wrong",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    );
                  }
                }(),
              ),
              if (state.accountStatus == AccountStatus.hasAccount)
                MasonryGridView.custom(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  childrenDelegate: SliverChildListDelegate.fixed(
                    [
                      InkWell(
                        splashColor: Colors.grey,
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddProduct(),
                            ),
                          );
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 160,
                          child: const Center(
                            child: Text(
                              'List an item for sale.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

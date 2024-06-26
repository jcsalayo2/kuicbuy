import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/main.dart';
import 'package:kuicbuy/pages/signuplogin/bloc/signup_login_bloc.dart';

class SignupLogin extends StatefulWidget {
  const SignupLogin({super.key});

  @override
  State<SignupLogin> createState() => _SignupLoginState();
}

class _SignupLoginState extends State<SignupLogin> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupLoginBloc(),
      child: Builder(builder: (context) {
        return BlocListener<SignupLoginBloc, SignupLoginState>(
          listener: (context, state) {
            if (state.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text(state.errorMessage),
                ),
              );
            }

            if (state.isSignupLoginDone) {
              Navigator.pop(context);
            }
          },
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 10, right: 20, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 35, bottom: 20, right: 35),
                      child: BlocBuilder<SignupLoginBloc, SignupLoginState>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                state.isLogin
                                    ? "Login ✨"
                                    : "Create an account ✨",
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                state.isLogin
                                    ? "Welcome Back! Log in to Continue"
                                    : "Unlock Exclusive Benefits",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              const SizedBox(height: 20),
                              if (!state.isLogin) ...[
                                const Text(
                                  "Personal Details",
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(height: 10),
                              ],
                              if (!state.isLogin) ...[
                                TextField(
                                    controller: nameController,
                                    hintText: "Name"),
                                const SizedBox(height: 20),
                              ],
                              TextField(
                                  controller: emailController,
                                  hintText: "Email"),
                              const SizedBox(height: 20),
                              if (!state.isLogin) ...[
                                const Text(
                                  "Security",
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(height: 10),
                              ],
                              TextField(
                                  controller: passwordController,
                                  hintText: "Password",
                                  isPassword: true,
                                  isPasswordHidden: state.isPasswordHidden),
                              const SizedBox(height: 20),
                              if (!state.isLogin) ...[
                                TextField(
                                    controller: confirmPasswordController,
                                    hintText: "Confirm Password",
                                    isPassword: true,
                                    isPasswordHidden: state.isPasswordHidden),
                                const SizedBox(height: 20),
                              ],
                              TextButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.blue),
                                onPressed: () {
                                  if (state.isLogin) {
                                  } else {
                                    context
                                        .read<SignupLoginBloc>()
                                        .add(CreateAccount(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ));
                                  }
                                },
                                child: Text(
                                  state.isLogin ? "Log In" : "Sign Up",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<SignupLoginBloc>()
                          .add(const SwitchToSignupOrLogin());
                    },
                    child: BlocBuilder<SignupLoginBloc, SignupLoginState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(state.isLogin
                                ? "Don't have an account? "
                                : "Already have an account? "),
                            Text(
                              state.isLogin ? "Sign Up" : "Log In",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class TextField extends StatelessWidget {
  const TextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.isPassword = false,
      this.isPasswordHidden = true});

  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isPasswordHidden;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword ? isPasswordHidden : false,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: () {
          switch (hintText) {
            case "Name":
              return const Icon(Icons.person_outline_rounded);
            case "Email":
              return const Icon(Icons.email_outlined);
            case "Password":
              return const Icon(Icons.lock_outline_rounded);
            case "Confirm Password":
              return const Icon(Icons.lock_outline_rounded);
          }
        }(),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  !isPasswordHidden
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  context
                      .read<SignupLoginBloc>()
                      .add(const SwitchPasswordVisibility());
                },
              )
            : null,
        filled: true,
        fillColor: const Color.fromARGB(255, 233, 233, 233),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.green)),
        hintText: hintText,
      ),
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }
}

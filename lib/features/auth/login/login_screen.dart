import 'package:final_project/features/auth/login/bloc/logic_bloc.dart';
import 'package:final_project/features/auth/login/widgets/app_icon_section.dart';
import 'package:final_project/features/auth/login/widgets/forgot_password_section.dart';
import 'package:final_project/features/auth/login/widgets/loading_overlay.dart';
import 'package:final_project/features/auth/login/widgets/login_button_section.dart';
import 'package:final_project/features/auth/login/widgets/other_sign_in_method_section.dart';
import 'package:final_project/features/auth/login/widgets/username_password_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController userNameTextController;
  late final TextEditingController passwordTextController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: Builder(builder: (context) {
          return BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is FailedLoginState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    state.errorMessage ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ));
              } else if (state is SuccessfullyLoginState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    state.successfulMsg ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ));
              }
            },
            builder: (_, state) {
              final isLoading = state is LoadingLoginState;
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    behavior: HitTestBehavior
                        .opaque, // Ensure taps on the empty space are registered
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 45),
                                child: AppIconSection(),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 43),
                                child: Column(
                                  children: [
                                    UsernamePasswordSection(
                                      userNameTextController:
                                          userNameTextController,
                                      passwordTextController:
                                          passwordTextController,
                                    ),
                                    ForgotPasswordSection(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed("forgot-password");
                                      },
                                    ),
                                    LoginButtonSection(
                                      onPressed: () {
                                        BlocProvider.of<LoginBloc>(context).add(
                                            LoginWithUsernamePassword(
                                                username:
                                                    userNameTextController.text,
                                                pasword: passwordTextController
                                                    .text));
                                      },
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 45,
                              ),
                              OtherSignInMethodSection(
                                onGoogleSignInTap: () {
                                  BlocProvider.of<LoginBloc>(context)
                                      .add(LoginWithThirdParty(isGoogle: true));
                                },
                                onFBSignInTap: () {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      LoginWithThirdParty(isGoogle: false));
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (isLoading) const LoadingOverylay()
                ],
              );
            },
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    userNameTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    userNameTextController = TextEditingController();
    passwordTextController = TextEditingController();
    super.initState();
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/routing/routes.dart';

import 'package:store_app/features/login/cubit/login_cubit.dart';
import 'package:store_app/features/login/cubit/login_states.dart';
import 'package:store_app/features/login/widgets/custom_text_field.dart';
import 'package:store_app/features/login/widgets/custombutton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  //شيل const

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final loginformkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocProvider(
        create: (context) => LoginCubit(Dio()),

        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is SuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Success Sign in!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.pushReplacementNamed(context,Routes.homeScreen);
            } else if (state is FailedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Something Wrong, Try Again!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Form(
                      key: loginformkey,
                      autovalidateMode: autovalidateMode,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icon.png",
                            height: 170,
                            width: 160,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              "Welcome back",
                              style: TextStyle(
                                fontSize: 23,
                                color: const Color.fromARGB(255, 68, 5, 240),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          CustomTextField(
                            controller: usernameController,
                            thing: "Username",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Type The Username";
                              } else if (!value.contains(RegExp(r'[a-z]'))) {
                                return "This Not Username Format";
                              }

                              return null;
                            },
                          ),

                          CustomTextField(
                            ispassword: true,

                            controller: passwordController,
                            thing: "Password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Type The Password";
                              } else if (value.length < 8) {
                                return 'password should have at least 8 charcters';
                                // } else if (!value.contains(RegExp(r'[A-Z]'))) {
                                //   return "Password should have at least one Capital character A-Z";
                              } else if (!value.contains(RegExp(r'[a-z]'))) {
                                return "Password should have at least one small character a-z";
                                // } else if (!value.contains(RegExp(r'[0-9]'))) {
                                //   return "Password should have at least one number";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 12,
                              top: 8,
                              left: 190,
                            ),
                            child: GestureDetector(
                              child: Text(
                                "Forget Your Password?",

                                style: TextStyle(fontSize: 16.4),
                              ),
                            ),
                          ),
                          state is LoadingState
                              ? CircularProgressIndicator()
                              : CustomButton(
                                  text: "Login",
                                  onPressed: () {
                                    if (loginformkey.currentState!.validate()) {
                                      context.read<LoginCubit>().login(
                                        name: usernameController.text,
                                        password: passwordController.text,
                                      );
                                    } else {
                                      setState(() {
                                        autovalidateMode =
                                            AutovalidateMode.onUserInteraction;
                                      });
                                    }
                                  },
                                ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text.rich(
                              TextSpan(
                                text: "Don't Have an account? ",
                                style: TextStyle(fontSize: 17.4),
                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                      color: Color.fromARGB(243, 85, 88, 120),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

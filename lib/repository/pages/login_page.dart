import 'package:bloc_fire_notes/data/bloc/register_user/register_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/bloc/register_user/register_bloc.dart';
import '../../data/bloc/register_user/register_states.dart';
import '../widgets/botton/button.dart';
import '../widgets/text_field/text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset(
            "assets/images/login.png",
            fit: BoxFit.fitWidth,
            height: 300.h,
          ),
          SizedBox(
            height: 10.h,
          ),
          const Text(
            "Welcome back login!",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 3.h,
          ),
          CustomTextField(
            mtController: emailController,
            mHindText: "enter email",
            mKeyboardtype: TextInputType.emailAddress,
            mSuffIcon: CupertinoIcons.mail,
          ),
          CustomTextField(
            mtController: passwordController,
            mHindText: "enter Password",
            mKeyboardtype: TextInputType.visiblePassword,
            mSuffIcon: CupertinoIcons.lock,
          ),
          BlocConsumer<RegisterBloc, RegisterUserStates>(
            listener: (context, state) {
              if (state is RegisterUserErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMsg)));
              }
            },
            builder: (context, state) {
              if (state is RegisterUserLoadingState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    SizedBox(
                      width: 15.h,
                    ),
                    ButttonWidgetApp(
                      btnName: "Log In",
                      onTap: () {},
                    ),
                  ],
                );
              }
              // if (state is RegisterUserErrorState) {
              //   return Center(
              //     child: Text(state.errorMsg),
              //   );
              // }

              return ButttonWidgetApp(
                btnName: "Log In",
                onTap: () async {
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    var email = emailController.text.toString();
                    var password = passwordController.text.toString();

                    BlocProvider.of<RegisterBloc>(context).add(LoginUserEvent(
                        userEmail: email,
                        userPassword: password,
                        ctx: context));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("please fill all details")));
                  }

                  emailController.clear();
                  passwordController.clear();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/bloc/register_user/register_bloc.dart';
import '../../data/bloc/register_user/register_event.dart';
import '../../data/bloc/register_user/register_states.dart';
import '../widgets/botton/button.dart';
import '../widgets/text_field/text_field.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: LoginPage.myFormKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/login.png",
                fit: BoxFit.fitWidth,
                height: 300.h,
              ),
              SizedBox(
                height: 3.h,
              ),
              const Text(
                "Welcome back login!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomTextField(
                obs: false,
                myValidator: (value) {
                  const emailRegex =
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";
                  RegExp emailReg = RegExp(emailRegex);
                  if (!emailReg.hasMatch(value!)) {
                    return "enter valid email ";
                  }
                  if (value.isEmpty) {
                    return "email required ";
                  }
                  return null;
                },
                mtController: emailController,
                mHindText: "enter email",
                mKeyboardtype: TextInputType.emailAddress,
                mSuffIcon: CupertinoIcons.mail,
              ),
              CustomTextField(
                obs: true,
                obsText: "*",
                myValidator: (value) {
                  const passwordRegex =
                      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";

                  RegExp passReg = RegExp(passwordRegex);
                  if (!passReg.hasMatch(value!)) {
                    return "enter valid password ";
                  }
                  if (value.isEmpty) {
                    return "password required ";
                  }
                  return null;
                },
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
                      if (LoginPage.myFormKey.currentState!.validate()) {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          var email = emailController.text.toString();
                          var password = passwordController.text.toString();

                          BlocProvider.of<RegisterBloc>(context).add(
                              LoginUserEvent(
                                  userEmail: email,
                                  userPassword: password,
                                  ctx: context));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("please fill all details")));
                        }
                      }

                      emailController.clear();
                      passwordController.clear();
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Dont have an Account"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ));
                      },
                      child: const Text("Sign Up!"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

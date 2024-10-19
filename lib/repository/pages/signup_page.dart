import 'package:bloc_fire_notes/data/bloc/register_user/register_bloc.dart';
import 'package:bloc_fire_notes/data/bloc/register_user/register_event.dart';
import 'package:bloc_fire_notes/data/bloc/register_user/register_states.dart';
import 'package:bloc_fire_notes/domain/models/user_model/user_model.dart';
import 'package:bloc_fire_notes/repository/pages/login_page.dart';
import 'package:bloc_fire_notes/repository/widgets/text_field/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/botton/button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  static final GlobalKey<FormState> signKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: signKey,
          child: Column(
            children: [
              Image.asset(
                "assets/images/signup.png",
                fit: BoxFit.fitWidth,
                height: 250.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              const Text("Create an Account!"),
              SizedBox(
                height: 3.h,
              ),
              CustomTextField(
                obs: false,
                myValidator: (value) {
                  //   const nameRegex =
                  //       //   r"^(?![0-9]+$)(?!.*\s)[a-zA-Z0-9._-]{6,20}$";
                  //       r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$';

                  //   RegExp passReg = RegExp(nameRegex);
                  if (value!.length <= 6) {
                    return "enter valid name ";
                  }
                  if (value.isEmpty) {
                    return "name required ";
                  }
                  return null;
                },
                mtController: nameController,
                mHindText: "enter Name",
                mKeyboardtype: TextInputType.name,
                mSuffIcon: CupertinoIcons.person,
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
                obs: false,
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
                  if (state is RegisterUserLoadedState) {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  }

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
                        const SizedBox(
                          width: 15,
                        ),
                        ButttonWidgetApp(
                          btnName: "Sign Up",
                          onTap: () {},
                        ),
                      ],
                    );
                  }

                  return ButttonWidgetApp(
                    btnName: "Sign Up",
                    onTap: () async {
                      if (signKey.currentState!.validate()) {
                        if (nameController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          var newUser = UserModel(
                              createdAt: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              email: emailController.text.toString(),
                              name: nameController.text.toString(),
                              password: passwordController.text.toString());

                          BlocProvider.of<RegisterBloc>(context).add(
                              CreateUserEvent(
                                  newUser: newUser,
                                  userPassword:
                                      passwordController.text.toString()));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("please fill all details")));
                      }

                      nameController.clear();
                      emailController.clear();
                      passwordController.clear();
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an Account"),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      },
                      child: const Text("Login"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

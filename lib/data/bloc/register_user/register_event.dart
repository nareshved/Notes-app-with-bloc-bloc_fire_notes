import 'package:bloc_fire_notes/domain/models/user_model/user_model.dart';
import 'package:flutter/widgets.dart';

abstract class RegisterUserEvents {}

class CreateUserEvent extends RegisterUserEvents {
  UserModel newUser;
  String userPassword;

  CreateUserEvent({required this.newUser, required this.userPassword});
}

class LoginUserEvent extends RegisterUserEvents {
  String userEmail;
  String userPassword;
  BuildContext ctx;

  LoginUserEvent({required this.userEmail, required this.userPassword, required this.ctx});
}

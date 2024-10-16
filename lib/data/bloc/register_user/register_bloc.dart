import 'dart:developer';

import 'package:bloc_fire_notes/data/bloc/register_user/register_event.dart';
import 'package:bloc_fire_notes/data/bloc/register_user/register_states.dart';
import 'package:bloc_fire_notes/data/firebase/firebase_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterUserEvents, RegisterUserStates> {
  FirebaseProvider firebaseProvider;
  RegisterBloc({required this.firebaseProvider})
      : super(RegisterUserInitialState()) {
    on<CreateUserEvent>(
      (event, emit) async {
        emit(RegisterUserLoadingState());
        try {
          await firebaseProvider.createUser(
              mUser: event.newUser, mPass: event.userPassword);

          emit(RegisterUserLoadedState());
        } catch (e) {
          emit(RegisterUserErrorState(errorMsg: e.toString()));

          log("error in RegisterBloc ${e.toString()}");
        }
      },
    );

    on<LoginUserEvent>(
      (event, emit) async {
        emit(RegisterUserLoadingState());

        try {
          await firebaseProvider.authenticateUser(
              mEmail: event.userEmail,
              mPass: event.userPassword,
              context: event.ctx);
        } catch (e) {
          emit(RegisterUserErrorState(errorMsg: e.toString()));
          log("error in LoginUserEvent ${e.toString()}");
        }
      },
    );
  }
}

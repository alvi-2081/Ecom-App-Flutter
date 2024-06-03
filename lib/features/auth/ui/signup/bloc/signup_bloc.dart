import 'package:bloc/bloc.dart';
import 'package:ecommerece_app/features/auth/data/signup_wrapper.dart';
import 'package:ecommerece_app/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AuthRepository authRepository;
  SignupBloc(this.authRepository) : super(InitialSignupState()) {
    on<SignupButtonPressed>(_signupButtonPressed);
  }

  _signupButtonPressed(
      SignupButtonPressed event, Emitter<SignupState> emit) async {
    try {
      emit(LoadingSignupState());
      final response =
          await authRepository.signup(event.name, event.email, event.password);
      if (response.user != null) {
        emit(SignupSuccessState(response));
      } else {
        emit(SignupErrorState(response.message ?? ''));
      }
    } catch (e) {
      emit(SignupErrorState(e.toString()));
    }
  }
}

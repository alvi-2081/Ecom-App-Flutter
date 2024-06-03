part of 'signup_bloc.dart';

class SignupState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialSignupState extends SignupState {}

class LoadingSignupState extends SignupState {}

class SignupSuccessState extends SignupState {
  final SignupResponseWrapper signupResponseWrapper;
  SignupSuccessState(this.signupResponseWrapper);

  @override
  List<Object> get props => [signupResponseWrapper];
}

class SignupErrorState extends SignupState {
  final String message;
  SignupErrorState(this.message);

  @override
  List<Object> get props => [message];
}

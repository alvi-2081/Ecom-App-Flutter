part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent extends Equatable {
  const SignupEvent();
  @override
  List<Object> get props => [];
}

class SignupButtonPressed extends SignupEvent {
  final String name;
  final String email;
  final String password;

  const SignupButtonPressed(this.name, this.email, this.password);
}

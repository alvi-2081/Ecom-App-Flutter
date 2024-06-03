part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed(this.email, this.password);
}

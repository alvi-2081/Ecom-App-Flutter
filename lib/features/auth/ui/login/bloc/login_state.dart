part of 'login_bloc.dart';

class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginResponseWrapper loginResponseWrapper;
  LoginSuccessState(this.loginResponseWrapper);

  @override
  List<Object> get props => [loginResponseWrapper];
}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState(this.message);

  @override
  List<Object> get props => [message];
}


// part of 'auth_bloc.dart';

// enum LoginStatus { initial, loading, success, error }

// class AuthState extends Equatable {
//   const AuthState(
//       {this.email = '',
//       this.password = '',
//       this.message = '',
//       this.loginStatus = LoginStatus.initial});

//   final String email;
//   final String password;
//   final String message;
//   final LoginStatus loginStatus;

//   AuthState copyWith({
//     String? email,
//     String? password,
//     String? message,
//     LoginStatus? loginStatus,
//   }) {
//     return AuthState(
//       email: email ?? this.email,
//       password: password ?? this.password,
//       message: message ?? this.message,
//       loginStatus: loginStatus ?? this.loginStatus,
//     );
//   }

//   @override
//   List<Object> get props => [email, password, message, loginStatus];
// }
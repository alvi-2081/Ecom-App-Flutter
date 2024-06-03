import 'package:bloc/bloc.dart';
import 'package:ecommerece_app/features/auth/data/login_wrapper.dart';
import 'package:ecommerece_app/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository authRepository;
  LoginBloc(this.authRepository) : super(InitialLoginState()) {
    on<LoginButtonPressed>(_loginButtonPressed);
  }

  _loginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoadingLoginState());
      final response = await authRepository.login(event.email, event.password);
      if (response.user != null) {
        emit(LoginSuccessState(response));
      } else {
        emit(LoginErrorState(response.message ?? ''));
      }
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}

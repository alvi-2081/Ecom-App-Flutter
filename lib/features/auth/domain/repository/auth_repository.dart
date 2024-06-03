import 'package:ecommerece_app/core/constants/http_constants.dart';
import 'package:ecommerece_app/features/auth/data/login_wrapper.dart';
import 'package:ecommerece_app/features/auth/data/signup_wrapper.dart';
import 'package:ecommerece_app/main.dart';
import 'package:ecommerece_app/core/network/dio_api_services.dart';

class AuthRepository {
  Future<LoginResponseWrapper> login(String email, String password) async {
    final body = {'email': email, 'password': password};
    final response = await getIt<DioApiServices>()
        .postRequest(HttpConstants.login, data: body);
    return LoginResponseWrapper.fromJson(response);
  }

  Future<SignupResponseWrapper> signup(
      String name, String email, String password) async {
    final body = {'name': name, 'email': email, 'password': password};
    final response = await getIt<DioApiServices>()
        .postRequest(HttpConstants.signup, data: body);
    return SignupResponseWrapper.fromJson(response);
  }
}

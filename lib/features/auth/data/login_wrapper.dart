import 'package:ecommerece_app/features/auth/domain/entities/user.dart';

class LoginResponseWrapper {
  LoginResponseWrapper({
    this.message,
    this.token,
    this.user,
  });

  LoginResponseWrapper.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
    user = json['data'] != null ? User.fromJson(json['data']) : null;
  }
  String? message;
  String? token;
  User? user;
  LoginResponseWrapper copyWith({
    String? message,
    String? token,
    User? user,
  }) =>
      LoginResponseWrapper(
        message: message ?? this.message,
        token: token ?? this.token,
        user: user ?? this.user,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    if (user != null) {
      map['data'] = user?.toJson();
    }
    return map;
  }
}

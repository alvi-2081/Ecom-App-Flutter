import 'package:ecommerece_app/features/auth/domain/entities/user.dart';

class SignupResponseWrapper {
  SignupResponseWrapper({
    this.message,
    this.user,
  });

  SignupResponseWrapper.fromJson(dynamic json) {
    message = json['message'];
    user = json['data'] != null ? User.fromJson(json['data']) : null;
  }
  String? message;
  String? token;
  User? user;
  SignupResponseWrapper copyWith({
    String? message,
    String? token,
    User? user,
  }) =>
      SignupResponseWrapper(
        message: message ?? this.message,
        user: user ?? this.user,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['data'] = user?.toJson();
    }
    return map;
  }
}

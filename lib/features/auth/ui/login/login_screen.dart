import 'dart:convert';

import 'package:ecommerece_app/core/components/button_component.dart';
import 'package:ecommerece_app/core/components/route_constants.dart';
import 'package:ecommerece_app/core/components/text_component.dart';
import 'package:ecommerece_app/core/components/textfield_component.dart';
import 'package:ecommerece_app/core/components/toast_component.dart';
import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:ecommerece_app/core/constants/sizedbox_constants.dart';
import 'package:ecommerece_app/core/constants/string_constants.dart';
import 'package:ecommerece_app/core/network/dio_client_network.dart';
import 'package:ecommerece_app/core/utils/navigation_utils.dart';
import 'package:ecommerece_app/core/utils/sharedpreference_utils.dart';
import 'package:ecommerece_app/core/utils/validator_util.dart';
import 'package:ecommerece_app/features/auth/ui/login/bloc/login_bloc.dart';
import 'package:ecommerece_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> formkey;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    formkey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          getIt<DioClientNetwork>().changeBaseUrl();
          ToastComponent.show(state.loginResponseWrapper.message ?? '');
          getIt<SharedPreferencesUtil>()
              .setString('user', jsonEncode(state.loginResponseWrapper.user));
          NavigationUtil.popAllAndPush(context, RouteConstants.homeScreen);
        } else if (state is LoginErrorState) {
          ToastComponent.show(state.message);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorConstants.white,
            body: Form(
              key: formkey,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  children: [
                    SizedBoxConstants.eightyH(),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: TextComponent(
                        StringConstants.login,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBoxConstants.twentyH(),
                    TextFieldComponent(
                      emailController,
                      lableText: StringConstants.email,
                      validator: (value) =>
                          ValidatorUtil.emailValidator(value!),
                    ),
                    SizedBoxConstants.tenH(),
                    TextFieldComponent(
                      passwordController,
                      lableText: StringConstants.password,
                      validator: (value) =>
                          ValidatorUtil.requiredValidator(value!),
                    ),
                    SizedBoxConstants.twentyH(),
                    InkWell(
                      onTap: () => NavigationUtil.push(
                          context, RouteConstants.signupScreen),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const TextComponent(
                                  StringConstants.dontHaveAccount),
                              SizedBoxConstants.width(5),
                              const Icon(
                                Icons.arrow_right_alt_outlined,
                                color: ColorConstants.primary,
                              )
                            ],
                          )),
                    ),
                    ButtonComponent(
                        title: StringConstants.login.toUpperCase(),
                        loading: state is LoadingLoginState ? true : false,
                        onpressed: () {
                          if (formkey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            context.read<LoginBloc>().add(LoginButtonPressed(
                                emailController.text, passwordController.text));
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

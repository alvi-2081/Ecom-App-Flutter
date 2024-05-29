import 'package:ecommerece_app/core/components/button_component.dart';
import 'package:ecommerece_app/core/components/text_component.dart';
import 'package:ecommerece_app/core/components/textfield_component.dart';
import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:ecommerece_app/core/constants/sizedbox_constants.dart';
import 'package:ecommerece_app/core/constants/string_constants.dart';
import 'package:ecommerece_app/core/utils/logger_util.dart';
import 'package:ecommerece_app/core/utils/validator_util.dart';
import 'package:flutter/material.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.white,
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                SizedBoxConstants.eightyH(),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: TextComponent(
                    StringConstants.login,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBoxConstants.twentyH(),
                TextFieldComponent(
                  emailController,
                  lableText: StringConstants.email,
                  validator: (value) => ValidatorUtil.emailValidator(value!),
                ),
                SizedBoxConstants.tenH(),
                TextFieldComponent(
                  passwordController,
                  lableText: StringConstants.password,
                  validator: (value) => ValidatorUtil.requiredValidator(value!),
                ),
                SizedBoxConstants.twentyH(),
                Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TextComponent(StringConstants.forgetYourpassword),
                        SizedBoxConstants.width(5),
                        const Icon(
                          Icons.arrow_right_alt_outlined,
                          color: ColorConstants.primary,
                        )
                      ],
                    )),
                ButtonComponent(
                    title: StringConstants.login.toUpperCase(),
                    onpressed: () {
                      if (formkey.currentState!.validate()) {
                        LoggerUtil.logs('Validated');
                        // Map data = {
                        //   'email': emailController.text.toString(),
                        //   'password': passwordController.text.toString()
                        // };
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:ecommerece_app/core/components/button_component.dart';
import 'package:ecommerece_app/core/components/route_constants.dart';
import 'package:ecommerece_app/core/components/text_component.dart';
import 'package:ecommerece_app/core/components/textfield_component.dart';
import 'package:ecommerece_app/core/components/toast_component.dart';
import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:ecommerece_app/core/constants/sizedbox_constants.dart';
import 'package:ecommerece_app/core/constants/string_constants.dart';
import 'package:ecommerece_app/core/utils/navigation_utils.dart';
import 'package:ecommerece_app/core/utils/validator_util.dart';
import 'package:ecommerece_app/features/auth/ui/signup/bloc/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late GlobalKey<FormState> formkey;
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    formkey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccessState) {
          ToastComponent.show(state.signupResponseWrapper.message ?? '');
          NavigationUtil.popAllAndPush(context, RouteConstants.loginScreen);
        } else if (state is SignupErrorState) {
          ToastComponent.show(state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorConstants.white,
          appBar: AppBar(
            backgroundColor: ColorConstants.white,
            leading: InkWell(
                onTap: () => NavigationUtil.pop(context,
                    previousScreen: RouteConstants.signupScreen),
                child: const Icon(Icons.arrow_back_ios)),
          ),
          body: Form(
            key: formkey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: TextComponent(
                      StringConstants.signup,
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBoxConstants.twentyH(),
                  TextFieldComponent(
                    nameController,
                    lableText: StringConstants.name,
                    validator: (value) => ValidatorUtil.nameValidator(value!),
                  ),
                  SizedBoxConstants.tenH(),
                  TextFieldComponent(
                    emailController,
                    lableText: StringConstants.email,
                    validator: (value) => ValidatorUtil.emailValidator(value!),
                  ),
                  SizedBoxConstants.tenH(),
                  TextFieldComponent(
                    passwordController,
                    lableText: StringConstants.password,
                    validator: (value) =>
                        ValidatorUtil.passwordValidator(value!),
                  ),
                  SizedBoxConstants.twentyH(),
                  InkWell(
                    onTap: () => NavigationUtil.pop(context,
                        previousScreen: RouteConstants.signupScreen),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TextComponent(
                                StringConstants.alreadyHaveAccount),
                            SizedBoxConstants.width(5),
                            const Icon(
                              Icons.arrow_right_alt_outlined,
                              color: ColorConstants.primary,
                            )
                          ],
                        )),
                  ),
                  ButtonComponent(
                      title: StringConstants.signup.toUpperCase(),
                      loading: state is LoadingSignupState ? true : false,
                      onpressed: () {
                        if (formkey.currentState!.validate()) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context.read<SignupBloc>().add(SignupButtonPressed(
                              nameController.text,
                              emailController.text,
                              passwordController.text));
                        }
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

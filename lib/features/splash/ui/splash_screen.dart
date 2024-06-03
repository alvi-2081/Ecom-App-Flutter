import 'dart:async';
import 'package:ecommerece_app/core/components/route_constants.dart';
import 'package:ecommerece_app/core/components/text_component.dart';
import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:ecommerece_app/core/constants/string_constants.dart';
import 'package:ecommerece_app/core/network/dio_client_network.dart';
import 'package:ecommerece_app/core/utils/navigation_utils.dart';
import 'package:ecommerece_app/core/utils/sharedpreference_utils.dart';
import 'package:ecommerece_app/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    getIt<SharedPreferencesUtil>().isExist('user').then((value) {
      if (value) getIt<DioClientNetwork>().changeBaseUrl();
      Timer(
          const Duration(seconds: 2),
          () => NavigationUtil.popAllAndPush(context,
              value ? RouteConstants.homeScreen : RouteConstants.loginScreen));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              color: ColorConstants.main,
              size: 150,
            ),
            TextComponent(
              StringConstants.ecomApp,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorConstants.main,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

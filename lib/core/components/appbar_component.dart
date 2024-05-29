import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class AppBarComponent extends StatefulWidget {
  const AppBarComponent({super.key});

  @override
  State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.background,
      leading: const Icon(Icons.arrow_back_ios),
    );
  }
}

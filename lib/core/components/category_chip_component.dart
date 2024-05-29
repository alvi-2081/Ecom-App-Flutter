import 'package:ecommerece_app/core/components/route_constants.dart';
import 'package:ecommerece_app/core/components/text_component.dart';
import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:ecommerece_app/core/utils/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryChipComponent extends StatelessWidget {
  final String title;
  const CategoryChipComponent({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationUtil.push(context, RouteConstants.categoryScreen,
          args: title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: ColorConstants.primary,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: TextComponent(
            title,
            style: const TextStyle(color: ColorConstants.white),
          ),
        ),
      ),
    );
  }
}

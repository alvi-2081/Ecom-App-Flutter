import 'package:ecommerece_app/core/components/route_constants.dart';
import 'package:ecommerece_app/features/add_product/ui/add_product_screen.dart';
import 'package:ecommerece_app/features/auth/login_screen.dart';
import 'package:ecommerece_app/features/auth/signup_screen.dart';
import 'package:ecommerece_app/features/category/ui/category_screen.dart';
import 'package:ecommerece_app/features/home/domain/entities/products.dart';
import 'package:ecommerece_app/features/products_details/ui/products_details_screen.dart';
import 'package:flutter/material.dart';

Route onGenerateRoute(RouteSettings settings) {
  PageRoute materialRoute(
    Widget widget,
  ) {
    return MaterialPageRoute(builder: (context) => widget);
  }

  switch (settings.name) {
    case RouteConstants.signupScreen:
      return materialRoute(
        const SignupScreen(),
      );
    case RouteConstants.loginScreen:
      return materialRoute(
        const LoginScreen(),
      );
    case RouteConstants.productsDetailsScreen:
      final args = settings.arguments as Products;
      return materialRoute(
        ProductsDetailsScreen(
          product: args,
        ),
      );
    case RouteConstants.categoryScreen:
      final args = settings.arguments as String;
      return materialRoute(
        CategoryScreen(
          category: args,
        ),
      );
    case RouteConstants.addProductScreen:
      return materialRoute(
        const AddProductScreen(),
      );

    default:
      return materialRoute(
        const LoginScreen(),
      );
  }
}

import 'package:flutter/material.dart';

class NavigationUtil {
  static Future<dynamic> push<T>(
    BuildContext context,
    String routeName, {
    dynamic args,
  }) {
    return Navigator.pushNamed(
      context,
      routeName,
      arguments: args,
    );
  }

  static Future<dynamic> pushReplace(
    BuildContext context,
    String routeName, {
    required String previousScreen,
    dynamic args,
  }) {
    return Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: args,
    );
  }

  static void pop(
    BuildContext context, {
    dynamic args,
    bool isScreen = true,
    required String previousScreen,
  }) {
    return Navigator.pop(context);
  }

  static Future<dynamic> popAllAndPush(
    BuildContext context,
    String routeName, {
    dynamic args,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (Route route) => false,
      arguments: args,
    );
  }

  static void popUntil(
    BuildContext context,
    String routeName, {
    required String previousScreen,
    dynamic args,
  }) {
    return Navigator.popUntil(
      context,
      (Route route) => route.isFirst,
    );
  }
}

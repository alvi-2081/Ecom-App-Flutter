import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastComponent {
  static show(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: ColorConstants.main,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT);
  }
}

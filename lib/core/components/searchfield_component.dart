import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class SearchFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final Function(String _)? onChanged;
  const SearchFieldComponent(this.controller,
      {this.onChanged(String _)?, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: ColorConstants.black,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search Products',
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        suffixIcon: const Icon(Icons.search),
        border: _outLineBorder(),
        errorBorder: _outLineBorder(),
        enabledBorder: _outLineBorder(),
        focusedBorder: _outLineBorder(),
        disabledBorder: _outLineBorder(),
      ),
    );
  }

  OutlineInputBorder _outLineBorder() => const OutlineInputBorder(
        borderSide: BorderSide(color: ColorConstants.black, width: 0),
      );
}

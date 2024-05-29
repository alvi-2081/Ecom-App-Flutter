import 'dart:ui' as dart_ui;

import 'package:ecommerece_app/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldComponent extends StatefulWidget {
  final Function()? onTap;
  final String? lableText;
  final bool isMandatory;
  final TextEditingController textEditingController;
  final String hintText;
  final bool hideAsterisk;
  final bool? hidePassword;
  final Widget? suffixIcon;
  final Color fieldColor;
  final bool disableField;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int maxLines;
  final int minLines;
  final bool? enabled;
  final Function(String _)? onChanged;
  final Function(String _)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? trailingImage;
  final Function()? onTrailingPressed;
  final FocusNode? focusNode;
  final bool capitalizeText;
  final bool digitsOnly;
  final Color textColor;
  final Widget? prefixWidget;
  final dart_ui.TextDirection? textDirection;
  final bool? changeDirection;
  TextFieldComponent(
    this.textEditingController, {
    Key? key,
    this.onTap,
    this.lableText,
    this.isMandatory = false,
    this.hintText = '',
    this.hideAsterisk = false,
    this.hidePassword,
    this.suffixIcon,
    this.fieldColor = ColorConstants.background,
    this.disableField = false,
    this.validator,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.enabled,
    this.onChanged(String _)?,
    this.onFieldSubmitted(String _)?,
    this.keyboardType = TextInputType.name,
    this.textInputAction = TextInputAction.next,
    this.trailingImage,
    this.onTrailingPressed,
    this.focusNode,
    this.capitalizeText = false,
    this.digitsOnly = false,
    this.prefixWidget,
    this.changeDirection = false,
    this.textDirection,
    this.textColor = ColorConstants.black,
  }) : super(key: key);
  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  bool? hidePassword;
  List<TextInputFormatter> inputFormatters = [];
  @override
  void initState() {
    hidePassword = widget.hidePassword;
    // widget.fieldColor = ColorConstants.white.withOpacity(0.2);
    if (widget.capitalizeText) {
      inputFormatters.add(_UpperCaseTextFormatter());
    }
    if (widget.digitsOnly) {
      inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        textDirection: widget.textDirection,
        onTap: widget.onTap,
        textInputAction: widget.textInputAction,
        key: widget.key,
        controller: widget.textEditingController,
        obscureText: hidePassword ?? false,
        validator: widget.validator,
        maxLength: widget.maxLength,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        focusNode: widget.focusNode,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: (_) =>
            widget.onChanged == null ? () {} : widget.onChanged!(_),
        style: TextStyle(
          color: widget.textColor,
        ),
        inputFormatters: inputFormatters,
        cursorColor: ColorConstants.black,
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: widget.fieldColor,
          enabled: !widget.disableField,
          hintText: _showHintText(
            text: widget.hintText,
            showAsterisk: widget.isMandatory,
          ),
          alignLabelWithHint: true,
          labelStyle: const TextStyle(color: ColorConstants.grey),
          labelText: widget.lableText,
          hintStyle: const TextStyle(color: ColorConstants.grey, fontSize: 14),
          border: _outLineBorder(),
          errorBorder: _outLineBorder(),
          enabledBorder: _outLineBorder(),
          focusedBorder: _outLineBorder(),
          disabledBorder: _outLineBorder(),
          errorMaxLines: 2,
          prefixIcon: widget.prefixWidget != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 1),
                  child: SizedBox(
                    width: 35,
                    child: widget.prefixWidget,
                  ),
                )
              : null,
          prefixIconConstraints: _boxConstraints(),
          suffixIconConstraints: _boxConstraints(),
          contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          suffixIcon: hidePassword != null
              ? GestureDetector(
                  child: _iconWidget(),
                  onTap: () {
                    setState(() => hidePassword = !hidePassword!);
                  },
                )
              : widget.suffixIcon,
        ),
      ),
    );
  }

  OutlineInputBorder _outLineBorder() => OutlineInputBorder(
        borderSide: BorderSide(
          color: widget.fieldColor,
        ),
      );
  String _showHintText({
    required String text,
    required bool showAsterisk,
  }) {
    if (text != '') {
      return text + (showAsterisk ? '*' : '');
    } else {
      return text;
    }
  }

  BoxConstraints _boxConstraints() => const BoxConstraints();
  Widget _iconWidget() => Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Icon(
          hidePassword! ? Icons.visibility_off : Icons.visibility,
          color: ColorConstants.grey,
        ),
      );
}

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

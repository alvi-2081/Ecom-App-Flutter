import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final String? text;
  final TextAlign textAlign;
  final TextStyle? style;
  final TextOverflow? overFlow;
  final int? maxLines;
  final bool? softwrap;
  final double textScaleFactor;
  final List<String> listOfText;
  final List<TextStyle> listOfTextStyle;
  final List<Function()?> listOfOnPressedFunction;

  const TextComponent(
    this.text, {
    Key? key,
    this.textAlign = TextAlign.left,
    this.style,
    this.overFlow = TextOverflow.ellipsis,
    this.maxLines,
    this.softwrap,
    this.textScaleFactor = 1.0,
    this.listOfText = const [],
    this.listOfTextStyle = const [],
    this.listOfOnPressedFunction = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listOfText.isEmpty) {
      return Text(
        text ?? '',
        maxLines: maxLines,
        softWrap: softwrap,
        overflow: overFlow,
        textAlign: textAlign,
        style: style,
      );
    } else {
      if (listOfTextStyle.length > listOfText.length) {
        assert(
          throw ('Length of list of TextStyles cannot be greater than the List of text'),
        );
      }
      if (listOfOnPressedFunction.length > listOfText.length) {
        assert(
          throw ('Length of list of Pressed Functions cannot be greater than the List of text'),
        );
      }
      {
        List<TextSpan> listOfTextSpans = [];
        for (int t = 0; t < listOfText.length; t++) {
          listOfTextSpans.add(
            TextSpan(
              text: listOfText[t] + ' ',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  if (t < listOfOnPressedFunction.length) {
                    listOfOnPressedFunction[t]!();
                  }
                },
              style: (t + 1) > listOfTextStyle.length
                  ? const TextStyle(
                      color: Colors.black,
                    )
                  : listOfTextStyle[t],
            ),
          );
        }
        return RichText(
          text: TextSpan(children: listOfTextSpans),
          textAlign: textAlign,
        );
      }
    }
  }
}

import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  const BigText({Key? key, required this.text, this.textColor = Colors.black, this.fontSize = 22}) : super(key: key);

  final String text;
  final Color textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    ),);
  }
}

import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  const SmallText({Key? key, required this.text, this.textColor = Colors.grey, this.fontSize = 18, this.fontWeight = FontWeight.w500}) : super(key: key);

  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),);
  }
}

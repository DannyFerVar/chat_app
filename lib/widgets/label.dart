import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String labelName;
  final Color textColor;
  final double fontSize;

  const Label({
    super.key,
    required this.labelName,
    this.textColor = Colors.black,
    this.fontSize = 13,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        labelName,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

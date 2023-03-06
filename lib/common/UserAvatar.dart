import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final Color bgColor;
  final String text;
  final double fontSize;
  final double radius;
  const UserAvatar(
    this.text,
    this.bgColor, {
    this.fontSize = 20,
    this.radius = 20,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: bgColor,
      radius: radius,
      child: Text(
        text[0].toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

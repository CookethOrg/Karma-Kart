import 'package:flutter/material.dart';

class Authbuttons extends StatelessWidget {
  Authbuttons({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    required this.textColor,
  });
  String text;
  Color backgroundColor;
  Color textColor;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

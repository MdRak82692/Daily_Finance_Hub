// ignore_for_file: file_names

import 'CustomText.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double fontSize;
  final EdgeInsets padding;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.color,
    required this.textColor,
    this.fontSize = 20,
    this.padding = const EdgeInsets.all(20),
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: color,
          padding: padding,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: color),
          ),
        ),
        icon: icon != null ? Icon(icon, color: textColor) : const SizedBox(),
        label: Text(label, style: style(fontSize, color: textColor)),
      ),
    );
  }
}

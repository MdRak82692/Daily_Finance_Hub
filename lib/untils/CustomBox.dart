// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'CustomText.dart'; // Assuming this defines the style function

class CustomBox extends StatelessWidget {
  final String title; // Add title as a parameter

  const CustomBox({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.yellowAccent,
        borderRadius: BorderRadius.circular(50),
      ),
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        title,
        style: style(26, color: Colors.black),
      ),
    );
  }
}

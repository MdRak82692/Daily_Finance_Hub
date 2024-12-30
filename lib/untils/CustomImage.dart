// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icon/logo.png',
      height: 100,
    );
  }
}

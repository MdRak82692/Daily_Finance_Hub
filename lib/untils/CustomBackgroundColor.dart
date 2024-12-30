// ignore_for_file: file_names

import 'package:flutter/material.dart';

Decoration buildBoxDecoration() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.yellow,
        Colors.green,
        Colors.cyan,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}

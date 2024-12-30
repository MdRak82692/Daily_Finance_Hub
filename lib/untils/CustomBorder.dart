// ignore_for_file: file_names

import 'package:flutter/material.dart';

OutlineInputBorder buildBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(50),
    borderSide: const BorderSide(
      color: Colors.blue,
      width: 5.0,
    ),
  );
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomNavigationService {
  static Future<void> navigateToScreen(
    BuildContext context, {
    required Widget screen,
  }) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}

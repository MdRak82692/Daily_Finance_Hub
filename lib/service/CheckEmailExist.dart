// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../service/APIService.dart';
import '../../untils/CustomShowDialog.dart';

class CheckEmailExist {
  Future<bool> checkEmailExists(BuildContext context, String email) async {
    try {
      final data = await APIService.fetchData(email, 'user');

      if (data.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      showCustomDialog(
          // ignore: use_build_context_synchronously
          context,
          'Error',
          'Failed to check email existence. Error: $e');
      return false;
    }
  }
}

class CheckEmailMatch {
  Future<bool> checkEmailMatch(BuildContext context, String email) async {
    try {
      final data = await APIService.fetchData(email, 'user');

      if (data.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      showCustomDialog(
        // ignore: use_build_context_synchronously
        context,
        'Error',
        'Failed to check email existence. Error: $e',
      );
      return false;
    }
  }
}

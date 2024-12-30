// ignore_for_file: file_names

import 'package:flutter/material.dart';

TableBorder tableBorder() {
  return TableBorder.all(color: const Color(0xFF006400), width: 5.0);
}

TableBorder tableBorder1() {
  return const TableBorder.symmetric(
      inside: BorderSide(color: Color(0xFF006400), width: 5.0));
}

TableBorder tableBorder2() {
  return const TableBorder(
    left: BorderSide(color: Color(0xFF006400), width: 5.0),
    right: BorderSide(color: Color(0xFF006400), width: 5.0),
    verticalInside: BorderSide(color: Color(0xFF006400), width: 5.0),
    bottom: BorderSide(color: Color(0xFF006400), width: 5.0),
  );
}

TableBorder tableBorder3() {
  return const TableBorder(
    verticalInside: BorderSide(color: Color(0xFF006400), width: 5.0),
  );
}

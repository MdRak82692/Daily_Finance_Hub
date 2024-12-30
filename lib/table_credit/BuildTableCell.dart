// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../untils/CustomText.dart';

Widget buildTableCell(String text) {
  return SizedBox(
    height: 60,
    child: Center(
      child: Text(
        text,
        style: style(22, color: Colors.black),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget buildTableCell1(String text) {
  return Container(
    height: 60,
    padding: const EdgeInsets.all(15.0),
    child: Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: style(22, color: Colors.black),
        textAlign: TextAlign.right,
      ),
    ),
  );
}

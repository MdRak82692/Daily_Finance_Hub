// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'CustomText.dart';

Widget buildDataCard(String title, String value) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 230, 169, 163),
      border: Border.all(
        color: Colors.blue,
        width: 4.0,
      ),
      borderRadius: BorderRadius.circular(50.0),
    ),
    child: Card(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: style(24, color: Colors.black),
            ),
            Text(
              value,
              style: style(24, color: Colors.black),
            ),
          ],
        ),
      ),
    ),
  );
}

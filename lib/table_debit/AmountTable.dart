// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'TableBorder.dart';
import '../untils/CustomText.dart';

Widget buildTotalAmountTable(
    {required String value, required String value1, required String value2}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildTableRow(
          'Total Debit', value, const Color.fromARGB(255, 19, 148, 24)),
    ],
  );
}

Widget buildTableRow(String label, String value, Color color) {
  return Padding(
    padding: const EdgeInsets.all(0),
    child: Table(
      border: tableBorder(),
      columnWidths: const {
        0: FractionColumnWidth(0.5),
        1: FractionColumnWidth(0.5),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Colors.white),
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(label, style: style(22, color: color)),
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(value, style: style(22, color: color)),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

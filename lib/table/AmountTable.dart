// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../untils/CustomText.dart';
import 'TableBorder.dart';

Widget buildTotalAmountTable(
    {required String value, required String value1, required String value2}) {
  double totalBalance = double.tryParse(value2) ?? 0.0;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildTableRow(
          'Total Debit', value, const Color.fromARGB(255, 19, 148, 24)),
      buildTableRow1(
          'Total Credit', value1, const Color.fromARGB(255, 199, 11, 11)),
      buildTableRow1(
          'Total Balance',
          value2,
          totalBalance >= 0
              ? const Color.fromARGB(255, 19, 148, 24)
              : const Color.fromARGB(255, 199, 11, 11)),
    ],
  );
}

Widget buildTableRow(String label, String value, Color color) {
  return Padding(
    padding: const EdgeInsets.all(0),
    child: Table(
      border: tableBorder(),
      columnWidths: const {
        0: FractionColumnWidth(0.7),
        1: FractionColumnWidth(0.3),
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

Widget buildTableRow1(String label, String value, Color color) {
  return Padding(
    padding: const EdgeInsets.all(0),
    child: Table(
      border: tableBorder2(),
      columnWidths: const {
        0: FractionColumnWidth(0.7),
        1: FractionColumnWidth(0.3),
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

Widget buildTotalAmountTable1(
    {required String value, required String value1, required String value2}) {
  double totalBalance = double.tryParse(value2) ?? 0.0;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildTableRow2(
          'Total Debit', value, const Color.fromARGB(255, 19, 148, 24)),
      buildTableRow3(
          'Total Credit', value1, const Color.fromARGB(255, 199, 11, 11)),
      buildTableRow3(
          'Total Balance',
          value2,
          totalBalance >= 0
              ? const Color.fromARGB(255, 19, 148, 24)
              : const Color.fromARGB(255, 199, 11, 11)),
    ],
  );
}

Widget buildTableRow2(String label, String value, Color color) {
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

Widget buildTableRow3(String label, String value, Color color) {
  return Padding(
    padding: const EdgeInsets.all(0),
    child: Table(
      border: tableBorder2(),
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

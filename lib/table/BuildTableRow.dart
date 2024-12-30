// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../untils/CustomText.dart';
import 'TableBorder.dart';

Widget buildTableRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                child: Text(label, style: style(22, color: Colors.black)),
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(value, style: style(22, color: Colors.black)),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildTableRow1(String label) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Table(
      columnWidths: const {
        0: FractionColumnWidth(1),
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
                child: Text(label, style: style(22, color: Colors.black)),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildTableRow2(String value, String value1, String value2) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Table(
      border: tableBorder3(),
      columnWidths: const {
        0: FractionColumnWidth(0.3),
        1: FractionColumnWidth(0.3),
        2: FractionColumnWidth(0.4),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Colors.white),
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(value, style: style(22, color: Colors.black)),
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(value1, style: style(22, color: Colors.black)),
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(value2, style: style(22, color: Colors.black)),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildTableRow3(
    String value, String value1, String value2, String value3, String value4) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Table(
      border: tableBorder3(),
      columnWidths: const {
        0: FractionColumnWidth(0.2),
        1: FractionColumnWidth(0.2),
        2: FractionColumnWidth(0.2),
        3: FractionColumnWidth(0.2),
        4: FractionColumnWidth(0.2),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Colors.white),
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(value, style: style(22, color: Colors.black)),
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(value1, style: style(22, color: Colors.black)),
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(value2, style: style(22, color: Colors.black)),
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(value3, style: style(22, color: Colors.black)),
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(value4, style: style(22, color: Colors.black)),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

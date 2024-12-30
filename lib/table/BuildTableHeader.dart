// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../model/TransactionModel.dart';
import '../untils/CustomText.dart';
import 'BuildTotalTransactionSection.dart';
import 'BuildTransactionRow.dart';
import 'TableBorder.dart';

// Updated buildTableHeader
Widget buildTableHeader(String label, String value,
    List<TransactionModel> transactions, String transactionDate) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
    child: Table(
      border: tableBorder(),
      columnWidths: const {
        0: FractionColumnWidth(0.7),
        1: FractionColumnWidth(0.3),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 135, 87),
          ),
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(label, style: style(22, color: Colors.black)),
                ),
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
        TableRow(
          children: [
            buildtransactionRows1(transactions),
            buildtransactionRows2(transactions),
          ],
        ),
        TableRow(
          children: [
            buildTotaltransactionsForDateSection1(transactionDate),
            buildTotaltransactionsForDateSection2(transactions),
          ],
        ),
      ],
    ),
  );
}

Widget buildTableHeader1(
  BuildContext context,
  String label,
  String value,
  List<TransactionModel> transactionsList,
  String transactionDate,
  double previousDayBalance,
  String email,
  String name,
  String contactNumber,
  String password,
  String searchText,
  String collectionName,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
    child: Table(
      border: tableBorder(),
      columnWidths: const {
        0: FractionColumnWidth(0.5),
        1: FractionColumnWidth(0.5),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 135, 87),
          ),
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(label, style: style(22, color: Colors.black)),
                ),
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
        TableRow(
          children: [
            buildtransactionRows3(transactionsList, previousDayBalance),
            buildtransactionRows4(
              context,
              transactionsList,
              previousDayBalance,
              transactionsList,
              email,
              name,
              contactNumber,
              password,
              searchText,
              collectionName,
            ),
          ],
        ),
        TableRow(
          children: [
            buildTotaltransactionsForDateSection4(),
            buildTotaltransactionsForDateSection3(
                transactionsList, previousDayBalance, '', ''),
          ],
        ),
      ],
    ),
  );
}

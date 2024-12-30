// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../model/TransactionModel.dart';
import 'BuildTableRow.dart';

Widget buildTotaltransactionsForDateSection1(String transactionDate) {
  return Padding(
    padding: const EdgeInsets.only(top: 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTableRow1('Total Transactions for $transactionDate:'),
      ],
    ),
  );
}

Widget buildTotaltransactionsForDateSection2(
    List<TransactionModel> transactions) {
  double totalCredit = 0.0;

  for (var transaction in transactions) {
    if (transaction.status == 'Credit') {
      totalCredit += transaction.amount;
    }
  }

  final creditAmount = totalCredit.toStringAsFixed(0);

  return Padding(
    padding: const EdgeInsets.only(top: 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTableRow2(creditAmount),
      ],
    ),
  );
}

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
  double totalDebit = 0.0;

  for (var transaction in transactions) {
    if (transaction.status == 'Debit') {
      totalDebit += transaction.amount;
    }
  }

  final debitAmount = totalDebit.toStringAsFixed(0);

  return Padding(
    padding: const EdgeInsets.only(top: 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTableRow2(debitAmount),
      ],
    ),
  );
}

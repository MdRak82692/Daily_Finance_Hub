// ignore_for_file: file_names

import 'package:daily_finance_hub/untils/CustomDateTime.dart';
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

Widget buildTotaltransactionsForDateSection4() {
  return Padding(
    padding: const EdgeInsets.only(top: 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTableRow1('Total Transactions for ${formatDate(DateTime.now())}:'),
      ],
    ),
  );
}

Widget buildTotaltransactionsForDateSection2(
    List<TransactionModel> transactions) {
  double totalDebit = 0.0;
  double totalCredit = 0.0;

  for (var transaction in transactions) {
    if (transaction.status == 'Debit') {
      totalDebit += transaction.amount;
    } else if (transaction.status == 'Credit') {
      totalCredit += transaction.amount;
    }
  }

  final balance = (totalDebit - totalCredit).toStringAsFixed(0);

  final debitAmount = totalDebit.toStringAsFixed(0);
  final creditAmount = totalCredit.toStringAsFixed(0);

  return Padding(
    padding: const EdgeInsets.only(top: 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTableRow2(debitAmount, creditAmount, balance),
      ],
    ),
  );
}

Widget buildTotaltransactionsForDateSection3(
  List<TransactionModel> transactions,
  double previousDayBalance,
  String value3,
  String value4,
) {
  double totalDebit = 0.0;
  double totalCredit = 0.0;

  for (var transaction in transactions) {
    if (transaction.status == 'Debit') {
      totalDebit += transaction.amount;
    } else if (transaction.status == 'Credit') {
      totalCredit += transaction.amount;
    }
  }

  final balance =
      (previousDayBalance + totalDebit - totalCredit).toStringAsFixed(0);
  final debitAmount = (previousDayBalance + totalDebit).toStringAsFixed(0);
  final creditAmount = totalCredit.toStringAsFixed(0);

  return Padding(
    padding: const EdgeInsets.only(top: 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTableRow3(debitAmount, creditAmount, balance, value3, value4),
      ],
    ),
  );
}

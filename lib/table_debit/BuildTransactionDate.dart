// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../model/TransactionModel.dart';
import 'BuildTableHeader.dart';

Widget buildtransactionDateSection(
    String transactionDate, List<TransactionModel> transactions) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildTableHeader(
          'Transaction Date', transactionDate, transactions, transactionDate),
    ],
  );
}

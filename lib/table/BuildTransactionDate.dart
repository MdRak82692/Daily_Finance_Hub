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

Widget buildtransactionDateSection1(
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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildTableHeader1(
        context,
        label,
        value,
        transactionsList,
        transactionDate,
        previousDayBalance,
        email,
        name,
        contactNumber,
        password,
        searchText,
        collectionName,
      )
    ],
  );
}

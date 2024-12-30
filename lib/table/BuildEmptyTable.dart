// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../model/TransactionModel.dart';
import 'BuildTableHeader.dart';

Widget buildEmptyTable(String paymentDate, List<TransactionModel> payments) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildTableHeader('Transaction Date', '', [], ''),
    ],
  );
}

Widget buildEmptyTable1(
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

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

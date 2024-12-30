// ignore_for_file: file_names

import 'package:daily_finance_hub/untils/CustomDateTime.dart';
import 'package:flutter/material.dart';

import '../model/TransactionModel.dart';

import 'BuildTableCell.dart';
import 'TableBorder.dart';

Widget buildtransactionRows1(List<TransactionModel> transactionsList) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Table(
      border: tableBorder1(),
      columnWidths: const {
        0: FractionColumnWidth(0.5),
        1: FractionColumnWidth(0.5),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Colors.blue),
          children: [
            buildTableCell('SL NO'),
            buildTableCell('Transaction Time'),
          ],
        ),
        ...transactionsList.asMap().entries.map(
          (entry) {
            final transaction = entry.value;
            return TableRow(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green, width: 3),
              ),
              children: [
                buildTableCell('${entry.key + 1}'),
                buildTableCell(
                  formatTime(transaction.transactionTime),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

Widget buildtransactionRows2(List<TransactionModel> transactionsList) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Table(
      border: tableBorder1(),
      columnWidths: const {
        0: FractionColumnWidth(0.7),
        1: FractionColumnWidth(0.3),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Colors.blue),
          children: [
            buildTableCell('Source of Income or Expenditure'),
            buildTableCell('Debit'),
          ],
        ),
        ...transactionsList.asMap().entries.map(
          (entry) {
            final transaction = entry.value;

            final isDebit = transaction.status == 'Debit';

            final debitAmount = isDebit ? transaction.amount : 0.0;

            final debitAmountStr = debitAmount.toStringAsFixed(0);

            return TableRow(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green, width: 3),
              ),
              children: [
                buildTableCell(transaction.source),
                buildTableCell1(debitAmountStr),
              ],
            );
          },
        ),
      ],
    ),
  );
}

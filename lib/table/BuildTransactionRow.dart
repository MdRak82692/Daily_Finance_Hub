// ignore_for_file: file_names, deprecated_member_use

import 'package:daily_finance_hub/service/APIService.dart';
import 'package:daily_finance_hub/service/FetchDataSerice.dart';
import 'package:daily_finance_hub/untils/CustomDateTime.dart';
import 'package:daily_finance_hub/untils/CustomShowDialog.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../model/TransactionModel.dart';
import '../screen/other/EditDailyFinanceTransaction.dart';
import 'BuildTableCell.dart';
import 'TableBorder.dart';

Widget buildtransactionRows1(List<TransactionModel> transactionsList) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Table(
      border: tableBorder1(),
      columnWidths: const {
        0: FractionColumnWidth(0.2),
        1: FractionColumnWidth(0.3),
        2: FractionColumnWidth(0.5),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Colors.blue),
          children: [
            buildTableCell('SL NO'),
            buildTableCell('Transaction Time'),
            buildTableCell('Source of Income or Expenditure'),
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
                buildTableCell(transaction.source),
              ],
            );
          },
        ),
      ],
    ),
  );
}

Widget buildtransactionRows2(List<TransactionModel> transactionsList) {
  double runningBalance = 0.00;

  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Table(
      border: tableBorder1(),
      columnWidths: const {
        0: FractionColumnWidth(0.3),
        1: FractionColumnWidth(0.3),
        2: FractionColumnWidth(0.4),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Colors.blue),
          children: [
            buildTableCell('Debit'),
            buildTableCell('Credit'),
            buildTableCell('Balance'),
          ],
        ),
        ...transactionsList.asMap().entries.map(
          (entry) {
            final transaction = entry.value;
            final isCredit = transaction.status == 'Credit';
            final isDebit = transaction.status == 'Debit';

            final debitAmount = isDebit ? transaction.amount : 0;
            final creditAmount = isCredit ? transaction.amount : 0;

            runningBalance += debitAmount - creditAmount;

            final debitAmountStr = debitAmount.toStringAsFixed(0);
            final creditAmountStr = creditAmount.toStringAsFixed(0);
            final balanceStr = runningBalance.toStringAsFixed(0);

            return TableRow(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green, width: 3),
              ),
              children: [
                buildTableCell1(debitAmountStr),
                buildTableCell1(creditAmountStr),
                buildTableCell1(balanceStr),
              ],
            );
          },
        ),
      ],
    ),
  );
}

Widget buildtransactionRows3(
    List<TransactionModel> transactionsList, double previousDayBalance) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Table(
      border: tableBorder1(),
      columnWidths: const {
        0: FractionColumnWidth(0.1),
        1: FractionColumnWidth(0.25),
        2: FractionColumnWidth(0.65),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Colors.blue),
          children: [
            buildTableCell('SL NO'),
            buildTableCell('Transaction Time'),
            buildTableCell('Source of Income or Expenditure'),
          ],
        ),
        if (previousDayBalance != 0)
          TableRow(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.green, width: 3),
            ),
            children: [
              buildTableCell('1'),
              buildTableCell('12:00:00 AM'),
              buildTableCell('Previous Day Balance'),
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
                if (previousDayBalance != 0)
                  buildTableCell('${entry.key + 2}')
                else
                  buildTableCell('${entry.key + 1}'),
                buildTableCell(
                  formatTime(transaction.transactionTime),
                ),
                buildTableCell(transaction.source),
              ],
            );
          },
        ),
      ],
    ),
  );
}

Future<void> deletetransaction(mongo.ObjectId id, String email) async {
  try {
    await APIService.deleteData(email, 'TransactionDetails', id.toHexString());
  } catch (e) {
    // ignore: avoid_print
    print('Error delete transaction" $e');
  }
}

Widget buildtransactionRows4(
  BuildContext context,
  List<TransactionModel> transactionsList,
  double previousDayBalance,
  List<TransactionModel> transactions,
  String email,
  String name,
  String contactNumber,
  String password,
  String searchText,
  String collectionName,
) {
  double runningBalance = previousDayBalance;

  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Table(
      border: tableBorder1(),
      columnWidths: const {
        0: FractionColumnWidth(0.2),
        1: FractionColumnWidth(0.2),
        2: FractionColumnWidth(0.2),
        3: FractionColumnWidth(0.2),
        4: FractionColumnWidth(0.2),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Colors.blue),
          children: [
            buildTableCell('Debit'),
            buildTableCell('Credit'),
            buildTableCell('Balance'),
            buildTableCell('Edit'),
            buildTableCell('Delete'),
          ],
        ),
        if (previousDayBalance != 0)
          TableRow(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.green, width: 3),
            ),
            children: [
              buildTableCell1(previousDayBalance.toStringAsFixed(0)),
              buildTableCell1('0'),
              buildTableCell1(previousDayBalance.toStringAsFixed(0)),
              buildTableCell1(''),
              buildTableCell1(''),
            ],
          ),
        ...transactionsList.asMap().entries.map(
          (entry) {
            final transaction = entry.value;
            final isCredit = transaction.status == 'Credit';
            final isDebit = transaction.status == 'Debit';

            final debitAmount = isDebit ? transaction.amount : 0;
            final creditAmount = isCredit ? transaction.amount : 0;

            runningBalance += debitAmount - creditAmount;

            final debitAmountStr = debitAmount.toStringAsFixed(0);
            final creditAmountStr = creditAmount.toStringAsFixed(0);
            final balanceStr = runningBalance.toStringAsFixed(0);

            return TableRow(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green, width: 3),
              ),
              children: [
                buildTableCell1(debitAmountStr),
                buildTableCell1(creditAmountStr),
                buildTableCell1(balanceStr),
                SizedBox(
                  height: 60,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () async {
                        final updatedtransaction = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditDailyFinanceTransactionScreen(
                              transaction: transactions[entry.key],
                              email: email,
                              name: name,
                              contactNumber: contactNumber,
                              password: password,
                              source: transaction.source,
                              amount: transaction.amount.toStringAsFixed(0),
                              selectedstatus: transaction.status,
                              id: transaction.id,
                            ),
                          ),
                        );
                        if (updatedtransaction != null) {
                          fetchTransactionData(
                              email, searchText, collectionName);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDeleteConfirmationDialog(
                          context,
                          transaction.id,
                          deletetransaction,
                          email,
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

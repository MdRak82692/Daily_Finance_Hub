// ignore_for_file: file_names

import '../../model/TransactionModel.dart';
import 'APIService.dart';

Future<List<TransactionModel>> fetchTransactionData(
    String email, String? searchText, String collectionName) async {
  try {
    final fetchedTransactionList =
        await APIService.fetchData(email, collectionName);

    return fetchedTransactionList
        .map((json) => TransactionModel.fromJson(json))
        .where((transaction) =>
            searchText == null ||
            transaction.source
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            transaction.amount
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            transaction.transactionDate
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            transaction.transactionTime
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            transaction.status
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()))
        .toList();
  } catch (error) {
    // ignore: avoid_print
    print('$error');
    return [];
  }
}

double getTotalDebit(List<TransactionModel> transactionList) {
  return transactionList
      .where((transaction) => transaction.status == 'Debit')
      .fold(0.0, (sum, transaction) => sum + transaction.amount);
}

double getTotalCredit(List<TransactionModel> transactionList) {
  return transactionList
      .where((transaction) => transaction.status == 'Credit')
      .fold(0.0, (sum, transaction) => sum + transaction.amount);
}

double getBalance(List<TransactionModel> transactionList) {
  return getTotalDebit(transactionList) - getTotalCredit(transactionList);
}

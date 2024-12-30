// ignore_for_file: file_names

import '../untils/CustomDateTime.dart';
import '../../model/TransactionModel.dart';

Map<String, List<TransactionModel>> groupedTransactionByDate(
    List<TransactionModel> transactions) {
  Map<String, List<TransactionModel>> groupedTransactionData = {};

  for (var transaction in transactions) {
    String transactionDate = formatDate(transaction.transactionDate);

    if (!groupedTransactionData.containsKey(transactionDate)) {
      groupedTransactionData[transactionDate] = [];
    }

    groupedTransactionData[transactionDate]!.add(transaction);
  }
  return groupedTransactionData;
}

double getTotalDebit1(List<TransactionModel> transactionList) {
  String todayDate = formatDate(DateTime.now());

  return transactionList
      .where((transaction) =>
          transaction.status == 'Debit' &&
          formatDate(transaction.transactionDate) == todayDate)
      .fold(0.0, (sum, transaction) => sum + transaction.amount);
}

double getTotalCredit1(List<TransactionModel> transactionList) {
  String todayDate = formatDate(DateTime.now());

  return transactionList
      .where((transaction) =>
          transaction.status == 'Credit' &&
          formatDate(transaction.transactionDate) == todayDate)
      .fold(0.0, (sum, transaction) => sum + transaction.amount);
}

double getBalance1(List<TransactionModel> transactionList) {
  String todayDate = formatDate(DateTime.now());

  double totalDebit = transactionList
      .where((transaction) =>
          transaction.status == 'Debit' &&
          formatDate(transaction.transactionDate) == todayDate)
      .fold(0.0, (sum, transaction) => sum + transaction.amount);

  double totalCredit = transactionList
      .where((transaction) =>
          transaction.status == 'Credit' &&
          formatDate(transaction.transactionDate) == todayDate)
      .fold(0.0, (sum, transaction) => sum + transaction.amount);

  return totalDebit - totalCredit;
}

Map<String, List<TransactionModel>> groupedTransactionByDate1(
    List<TransactionModel> transactions) {
  Map<String, List<TransactionModel>> groupedTransactionData = {};

  String todayDate = formatDate(DateTime.now());

  for (var transaction in transactions) {
    String transactionDate = formatDate(transaction.transactionDate);

    if (transactionDate == todayDate) {
      groupedTransactionData.putIfAbsent(todayDate, () => []);
      groupedTransactionData[todayDate]!.add(transaction);
    }
  }

  return groupedTransactionData;
}

Map<String, List<TransactionModel>> groupedTransactionByDateAndDebit(
    List<TransactionModel> transactions) {
  Map<String, List<TransactionModel>> groupedTransactionData = {};

  for (var transaction in transactions) {
    String transactionDate = formatDate(transaction.transactionDate);

    if (transactionDate == formatDate(transaction.transactionDate) &&
        transaction.status == 'Debit') {
      if (!groupedTransactionData.containsKey(transactionDate)) {
        groupedTransactionData[transactionDate] = [];
      }
      groupedTransactionData[transactionDate]!.add(transaction);
    }
  }

  return groupedTransactionData;
}

Map<String, List<TransactionModel>> groupedTransactionByDateAndCredit(
    List<TransactionModel> transactions) {
  Map<String, List<TransactionModel>> groupedTransactionData = {};

  for (var transaction in transactions) {
    String transactionDate = formatDate(transaction.transactionDate);

    if (transactionDate == formatDate(transaction.transactionDate) &&
        transaction.status == 'Credit') {
      if (!groupedTransactionData.containsKey(transactionDate)) {
        groupedTransactionData[transactionDate] = [];
      }
      groupedTransactionData[transactionDate]!.add(transaction);
    }
  }

  return groupedTransactionData;
}

double getTotalDebit2(
    List<TransactionModel> transactionList, double previousDayBalance) {
  String todayDate = formatDate(DateTime.now());

  return transactionList
      .where((transaction) =>
          transaction.status == 'Debit' &&
          formatDate(transaction.transactionDate) == todayDate)
      .fold(previousDayBalance, (sum, transaction) => sum + transaction.amount);
}

double getBalance2(
    List<TransactionModel> transactionList, double previousDayBalance) {
  String todayDate = formatDate(DateTime.now());

  double totalDebit = transactionList
      .where((transaction) =>
          transaction.status == 'Debit' &&
          formatDate(transaction.transactionDate) == todayDate)
      .fold(previousDayBalance, (sum, transaction) => sum + transaction.amount);

  double totalCredit = transactionList
      .where((transaction) =>
          transaction.status == 'Credit' &&
          formatDate(transaction.transactionDate) == todayDate)
      .fold(0.0, (sum, transaction) => sum + transaction.amount);

  return (totalDebit - totalCredit);
}

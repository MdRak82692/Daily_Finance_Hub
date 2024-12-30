// ignore_for_file: file_names

import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class TransactionModel {
  final mongo.ObjectId id;
  final String source;
  final String status;
  final DateTime transactionDate;
  final double amount;
  final DateTime transactionTime;

  TransactionModel({
    required this.id,
    required this.source,
    required this.transactionDate,
    required this.amount,
    required this.status,
    required this.transactionTime,
  });

  DateTime? parseDate(String? dateString, DateFormat format) {
    try {
      return format.parse(dateString!);
    } catch (e) {
      return DateTime.now();
    }
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat('dd MMMM yyyy');
    final timeFormat = DateFormat('hh:mm:ss a');

    return TransactionModel(
      id: json['_id'] as mongo.ObjectId,
      transactionDate: json['TransactionDate'] != null
          ? dateFormat.parse(json['TransactionDate'])
          : DateTime.now(),
      amount: (json['Amount']).toDouble(),
      status: json['Status'],
      transactionTime: json['TransactionTime'] != null
          ? timeFormat.parse(json['TransactionTime'])
          : DateTime.now(),
      source: json['Source'],
    );
  }

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('dd MMMM yyyy');
    final timeFormat = DateFormat('hh:mm:ss a');

    return {
      '_id': id,
      'Source': source,
      'TransactionDate': dateFormat.format(transactionDate),
      'Amount': amount,
      'Status': status,
      'TransactionTime': timeFormat.format(transactionTime),
    };
  }
}

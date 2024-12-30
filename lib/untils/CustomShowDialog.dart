// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'CustomText.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

void showCustomDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Use a proper builder
      return AlertDialog(
        title: Text(
          title,
          style: style(26, color: title == 'Error' ? Colors.red : Colors.green),
        ),
        content: Text(
          message,
          style: style(18, color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: style(18, color: Colors.blue),
            ),
          ),
        ],
      );
    },
  );
}

void showDeleteConfirmationDialog(BuildContext context, mongo.ObjectId id,
    Function(mongo.ObjectId, String) deletetransaction, String email) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Delete Product', style: style(26, color: Colors.red)),
      content: Text('Are you sure you want to delete this Product?',
          style: style(18, color: Colors.black)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('No', style: style(18, color: Colors.blue)),
        ),
        TextButton(
          onPressed: () {
            deletetransaction(id, email);
            Navigator.of(context).pop();
          },
          child: Text('Yes', style: style(18, color: Colors.red)),
        ),
      ],
    ),
  );
}

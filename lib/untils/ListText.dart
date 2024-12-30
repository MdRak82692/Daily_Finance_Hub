// ignore_for_file: file_names

import 'package:daily_finance_hub/untils/CustomText.dart';
import 'package:flutter/material.dart';

class ListTextWidget extends StatelessWidget {
  final String title;
  final Color color;

  const ListTextWidget({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style(22, color: color),
    );
  }
}

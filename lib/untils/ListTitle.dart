// ignore_for_file: file_names

import 'package:daily_finance_hub/untils/CustomText.dart';
import 'package:flutter/material.dart';

import '../service/NavigationService.dart';

class ListTitleWidget extends StatelessWidget {
  final String title;
  final Widget screen;
  final Icon icon;

  const ListTitleWidget({
    super.key,
    required this.title,
    required this.screen,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      iconColor: const Color.fromARGB(255, 182, 14, 2),
      title: Text(title, style: style(22, color: Colors.black)),
      onTap: () {
        CustomNavigationService.navigateToScreen(
          context,
          screen: screen,
        );
      },
    );
  }
}

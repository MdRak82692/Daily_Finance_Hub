// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'CustomText.dart'; // Importing the intl package

class CustomBuildDateTimeBox extends StatefulWidget {
  const CustomBuildDateTimeBox({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomBuildDateTimeBoxState createState() => _CustomBuildDateTimeBoxState();
}

class _CustomBuildDateTimeBoxState extends State<CustomBuildDateTimeBox> {
  String _formattedDate = '';
  String _formattedTime = '';

  @override
  void initState() {
    super.initState();
    _updateDateTime();
  }

  // This method updates the date and time every second
  void _updateDateTime() {
    if (!mounted) return;
    setState(() {
      _formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
      _formattedTime = DateFormat('hh:mm:ss a').format(DateTime.now());
    });
    Future.delayed(const Duration(seconds: 1), _updateDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildDateTime('Date: $_formattedDate', Colors.red),
        buildDateTime('Time: $_formattedTime', Colors.orange),
      ],
    );
  }

  Widget buildDateTime(String label, Color backgroundcolor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: backgroundcolor,
        border: Border.all(
          color: Colors.blue,
          width: 4.0,
        ),
        borderRadius: BorderRadius.circular(50.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          label,
          style: style(24, color: Colors.black),
        ),
      ),
    );
  }
}

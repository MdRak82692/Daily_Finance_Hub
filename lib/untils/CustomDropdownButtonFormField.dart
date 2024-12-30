// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'CustomBorder.dart';
import 'CustomText.dart';

class CustomDropdownButtonFormField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final Function(String)? onChanged;
  final bool obscureText;
  final List<DropdownMenuItem<String>> items;
  final String? value;
  final String? Function(String?)? validator;

  const CustomDropdownButtonFormField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.onChanged,
    this.obscureText = false,
    required this.items,
    this.value,
    this.validator,
  });

  @override
  CustomDropdownButtonFormFieldState createState() =>
      CustomDropdownButtonFormFieldState();
}

class CustomDropdownButtonFormFieldState
    extends State<CustomDropdownButtonFormField> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: widget.label,
        hintText: 'Select ${widget.label}',
        labelStyle: style(18, color: Colors.blue),
        hintStyle: style(18, color: Colors.blue),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        errorBorder: buildBorder(),
        focusedErrorBorder: buildBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        prefixIcon: Icon(widget.icon, color: Colors.black),
      ),
      style: style(18, color: Colors.blue),
      value: selectedValue,
      items: widget.items,
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(newValue!);
        }
      },
      validator: widget.validator,
    );
  }
}

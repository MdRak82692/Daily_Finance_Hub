// ignore_for_file: file_names, deprecated_member_use

import 'package:daily_finance_hub/screen/other/HomeScreen.dart';
import 'package:daily_finance_hub/service/APIService.dart';
import 'package:daily_finance_hub/untils/CustomAppBar.dart';
import 'package:daily_finance_hub/untils/CustomBackgroundColor.dart';
import 'package:daily_finance_hub/untils/CustomDropdownButtonFormField.dart';
import 'package:daily_finance_hub/untils/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../model/TransactionModel.dart';
import '../../service/NavigationService.dart';
import '../../untils/CustomBox.dart';
import '../../untils/CustomButton.dart';
import '../../untils/CustomDateTime.dart';
import '../../untils/CustomShowDialog.dart';
import '../../untils/Drawer.dart';

class EditDailyFinanceTransactionScreen extends StatefulWidget {
  final TransactionModel transaction;
  final String email;
  final String name;
  final String contactNumber;
  final String password;
  final String source;
  final String amount;
  final String selectedstatus;
  final mongo.ObjectId id;

  const EditDailyFinanceTransactionScreen({
    super.key,
    required this.transaction,
    required this.email,
    required this.name,
    required this.contactNumber,
    required this.password,
    required this.source,
    required this.amount,
    required this.selectedstatus,
    required this.id,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditDailyFinanceTransactionScreenState createState() =>
      _EditDailyFinanceTransactionScreenState();
}

class _EditDailyFinanceTransactionScreenState
    extends State<EditDailyFinanceTransactionScreen> {
  late TextEditingController sourceController;
  late TextEditingController amountController;
  String? selectedstatus;

  List<String> selectedstatusOption = ['Debit', 'Credit'];
  @override
  void initState() {
    sourceController = TextEditingController(text: widget.source);
    amountController = TextEditingController(text: widget.amount.toString());
    selectedstatus = widget.selectedstatus;
    super.initState();
  }

  @override
  void dispose() {
    sourceController.dispose();
    amountController.dispose();
    super.dispose();
  }

  Future<void> updatetransction() async {
    final source = sourceController.text;
    final amount = amountController.text;

    if (source.isEmpty || amount.isEmpty || selectedstatus == null) {
      showCustomDialog(context, 'Error', 'Please fill in all fields.');
      return;
    }

    try {
      await APIService.updateData(
        widget.email,
        'TransactionDetails',
        widget.id.toHexString(),
        {
          'Source': source,
          'Amount': double.tryParse(amount),
          'Status': selectedstatus,
          'TransactionDate': formatDate(DateTime.now()),
          'TransactionTime': formatTime(DateTime.now()),
        },
      );
      CustomNavigationService.navigateToScreen(
        // ignore: use_build_context_synchronously
        context,
        screen: HomeScreen(
          email: widget.email,
          name: widget.name,
          contactNumber: widget.contactNumber,
          password: widget.password,
        ),
      );
      // ignore: use_build_context_synchronously
      showCustomDialog(context, 'Successful',
          'Transaction Details has been Updated Successfully');
    } catch (e) {
      // ignore: use_build_context_synchronously
      showCustomDialog(context, 'Error', 'Failed to update data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(
        title: 'Upadate Daily Finance Transaction Details',
        hasBackButton: false,
        actions: const [],
        onPressed: () {
          CustomNavigationService.navigateToScreen(
            context,
            screen: HomeScreen(
              email: widget.email,
              name: widget.name,
              contactNumber: widget.contactNumber,
              password: widget.password,
            ),
          );
        },
        centerTitle: false,
        showDrawerIcon: true,
      ),
      drawer: buildDrawer(context,
          name: widget.name,
          contactNumber: widget.contactNumber,
          email: widget.email,
          password: widget.password),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: buildBoxDecoration(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const CustomBox(title: 'Update Transaction Details'),
                const SizedBox(height: 40),
                CustomTextField(
                    controller: sourceController,
                    label: 'Source of Income or Expenditure',
                    icon: Icons.description),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: amountController,
                  label: 'Amount of Money',
                  icon: Icons.attach_money,
                ),
                const SizedBox(height: 20),
                CustomDropdownButtonFormField(
                  label: 'Select Status',
                  icon: Icons.credit_card,
                  items: selectedstatusOption
                      .map((status) => DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          ))
                      .toList(),
                  value: selectedstatus,
                  onChanged: (String? newValue) {
                    setState(
                      () {
                        selectedstatus = newValue;
                      },
                    );
                  },
                ),
                const SizedBox(height: 40.0),
                CustomButton(
                  label: 'Update Transaction Details',
                  onPressed: updatetransction,
                  color: Colors.red,
                  textColor: Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

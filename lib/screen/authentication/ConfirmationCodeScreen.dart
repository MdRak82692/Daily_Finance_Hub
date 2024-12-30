// ignore_for_file: file_names

import 'package:daily_finance_hub/screen/other/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../service/ConfirmationCodeGenerate.dart';
import '../../service/NavigationService.dart';
import '../../service/APIService.dart';
import '../../service/SendEmailService.dart';
import '../../untils/CustomAppBar.dart';
import '../../untils/CustomBackgroundColor.dart';
import '../../untils/CustomButton.dart';
import '../../untils/CustomDateTime.dart';
import '../../untils/CustomImage.dart';
import '../../untils/CustomTextField.dart';
import '../../untils/CustomBox.dart';
import '../../untils/CustomShowDialog.dart';
import 'LoginScreen.dart';

class ConfirmationCodeScreen extends StatefulWidget {
  final String email;
  final String name;
  final String contactNumber;
  final String password;

  const ConfirmationCodeScreen({
    super.key,
    required this.email,
    required this.name,
    required this.contactNumber,
    required this.password,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmationCodeScreenState createState() => _ConfirmationCodeScreenState();
}

class _ConfirmationCodeScreenState extends State<ConfirmationCodeScreen> {
  final TextEditingController _confirmationCodeController =
      TextEditingController();

  Future<void> verifyConfirmationCode() async {
    final confirmationCode = _confirmationCodeController.text;

    if (confirmationCode.isEmpty) {
      showCustomDialog(context, 'Error', 'Please enter the Confirmation Code');
      return;
    }

    try {
      final data = await APIService.fetchOneData(
          widget.email, 'ConfirmationCode', 'email', widget.email);

      if (data != null) {
        final String expiryDateStr = data['expiryDate&Time'];

        final DateTime expiryDateTime =
            DateFormat('dd MMMM yyyy hh:mm:ss a').parse(expiryDateStr);

        if (data['confirmationCode'] == confirmationCode &&
            expiryDateTime.isAfter(DateTime.now())) {
          final existingUser = await APIService.fetchOneData(
              widget.email, 'user', 'email', widget.email);

          if (existingUser == null) {
            await APIService.insertData(
                widget.email,
                {
                  'name': widget.name,
                  'contactNumber': widget.contactNumber,
                  'email': widget.email,
                  'password': widget.password,
                },
                'user');
          } else {
            await APIService.updateData(
                widget.email, 'user', existingUser['_id'].toHexString(), {
              'password': widget.password,
            });
          }

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
              'Password has been successfully updated. Now You are Entered in Dashboard.');
        } else {
          // ignore: use_build_context_synchronously
          showCustomDialog(context, 'Error',
              'Confirmation code is incorrect or expired. Please try again.');
        }
      } else {
        showCustomDialog(
            // ignore: use_build_context_synchronously
            context,
            'Error',
            'No confirmation code found. Please try again.');
      }
    } catch (e) {
      showCustomDialog(
          // ignore: use_build_context_synchronously
          context,
          'Error',
          'Failed to verify confirmation code. Error: $e');
    }
  }

  Future<void> resendConfirmationCode() async {
    try {
      final String confirmationCode = generateConfirmationCode();

      await APIService.insertData(
          widget.email,
          {
            'email': widget.email,
            'confirmationCode': confirmationCode,
            'expiryDate&Time':
                '${formatDate(DateTime.now())} ${formatTime(DateTime.now().add(const Duration(minutes: 10)))}',
          },
          'ConfirmationCode');

      await sendEmailConfirmationCode(widget.email, confirmationCode);

      // ignore: use_build_context_synchronously
      showCustomDialog(context, 'Confirmation Code Sent',
          'Confirmation code has been resent to your email.');
    } catch (e) {
      showCustomDialog(
          // ignore: use_build_context_synchronously
          context,
          'Error',
          'Failed to resend confirmation code. Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(
        title: 'Confirmation Code',
        hasBackButton: true,
        actions: const [],
        onPressed: () {
          CustomNavigationService.navigateToScreen(
            context,
            screen: const LoginScreen(),
          );
        },
        centerTitle: false,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: buildBoxDecoration(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const CustomImage(),
                const SizedBox(height: 20),
                const CustomBox(title: 'Verify Your Confirmation Code'),
                const SizedBox(height: 40),
                CustomTextField(
                  controller: _confirmationCodeController,
                  label: 'Confirmation Code',
                  icon: Icons.lock,
                ),
                const SizedBox(height: 40.0),
                CustomButton(
                  label: 'Verify Code',
                  onPressed: verifyConfirmationCode,
                  color: Colors.red,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 20.0),
                CustomButton(
                  label: 'Resend Confirmation Code',
                  onPressed: resendConfirmationCode,
                  color: Colors.blue,
                  textColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

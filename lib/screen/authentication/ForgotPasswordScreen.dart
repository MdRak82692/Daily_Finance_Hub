// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../service/ConfirmationCodeGenerate.dart';
import '../../service/NavigationService.dart';
import '../../service/SendEmailService.dart';
import '../../service/CheckEmailExist.dart';
import '../../service/APIService.dart';

import '../../untils/CustomAppBar.dart';
import '../../untils/CustomBackgroundColor.dart';
import '../../untils/CustomButton.dart';
import '../../untils/CustomDateTime.dart';
import '../../untils/CustomImage.dart';
import '../../untils/CustomTextField.dart';
import '../../untils/CustomBox.dart';
import '../../untils/CustomShowDialog.dart';
import '../../untils/PasswordStrong.dart';

import 'LoginScreen.dart';
import 'ConfirmationCodeScreen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String passwordStrength = ''; // Define the passwordStrength variable

  final PasswordStrengthChecker passwordChecker = PasswordStrengthChecker();

  Future<void> forgetpassword() async {
    final String email = _emailController.text;
    final String password = _newPasswordController.text;
    final String confirmpassword = _confirmPasswordController.text;

    if (email.isEmpty || password.isEmpty || confirmpassword.isEmpty) {
      showCustomDialog(context, 'Error', 'Please fill in all fields.');
      return;
    }

    if (!passwordChecker.isPasswordStrong(password, (strength) {
      setState(() {
        passwordStrength = strength;
      });
    })) {
      String errorMessage =
          passwordChecker.getPasswordStrengthErrorMessage(context);
      if (errorMessage.isNotEmpty) {
        showCustomDialog(context, 'Error', errorMessage);
        return;
      }
    }

    if (password != confirmpassword) {
      showCustomDialog(context, 'Error', 'Passwords do not match.');
      return;
    }

    try {
      bool emailMatch = await CheckEmailMatch().checkEmailMatch(context, email);

      if (!emailMatch) {
        showCustomDialog(
          // ignore: use_build_context_synchronously
          context,
          'Error',
          'Entered Email is not Correct. Please Enter the Correct Email.',
        );
        return;
      }

      final String confirmationCode = generateConfirmationCode();

      await APIService.insertData(
        email,
        {
          'email': email,
          'confirmationCode': confirmationCode,
          'expiryDate&Time':
              '${formatDate(DateTime.now())} ${formatTime(DateTime.now().add(const Duration(minutes: 10)))}',
        },
        'ConfirmationCode',
      );

      await sendEmailConfirmationCode(email, confirmationCode);
      final user = await APIService.fetchOneData(email, 'user', 'email', email);
      CustomNavigationService.navigateToScreen(
        // ignore: use_build_context_synchronously
        context,
        screen: ConfirmationCodeScreen(
          email: email,
          name: user?['name'],
          contactNumber: user?['contactNumber'],
          password: password,
        ),
      );
      // ignore: use_build_context_synchronously
      showCustomDialog(context, 'Confirmation Code Sent',
          'Confirmation Code has been sent to your email. Please check your email.');
    } catch (e) {
      // ignore: use_build_context_synchronously
      showCustomDialog(context, 'Error', 'Failed to create an account: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(
        title: 'Forget Password',
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
                const CustomBox(
                    title: 'Enter Your Account Email & New Password'),
                const SizedBox(height: 40),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  controller: _newPasswordController,
                  label: 'New Password',
                  icon: Icons.lock,
                  obscureText: !_isPasswordVisible,
                  isPassword: true,
                  onChanged: (text) {
                    passwordChecker.isPasswordStrong(text, (strength) {
                      setState(() {
                        passwordStrength = strength;
                      });
                    });
                  },
                ),
                buildPasswordStrengthIndicator(passwordStrength),
                const SizedBox(height: 20.0),
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  icon: Icons.lock,
                  obscureText: !_isConfirmPasswordVisible,
                  isPassword: true,
                  onChanged: (value) {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 40.0),
                CustomButton(
                  label: 'Send Confirmation Code',
                  onPressed: forgetpassword,
                  color: Colors.red,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  label: 'Remember Password? Log In',
                  onPressed: () {
                    CustomNavigationService.navigateToScreen(
                      context,
                      screen: const LoginScreen(),
                    );
                  },
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

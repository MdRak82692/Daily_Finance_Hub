// ignore_for_file: file_names

import 'package:daily_finance_hub/service/APIService.dart';
import 'package:flutter/material.dart';
import '../../service/NavigationService.dart';

import '../../untils/CustomAppBar.dart';
import '../../untils/CustomBackgroundColor.dart';
import '../../untils/CustomButton.dart';
import '../../untils/CustomTextField.dart';
import '../../untils/CustomBox.dart';
import '../../untils/CustomImage.dart';
import '../../untils/CustomShowDialog.dart';

import 'ForgotPasswordScreen.dart';
import 'SignUpScreen.dart';
import '../other/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  Future<void> login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty && password.isEmpty) {
      showCustomDialog(context, 'Error', 'Enter the Email & Password');
      return;
    } else if (email.isEmpty) {
      showCustomDialog(context, 'Error', 'Enter the Email');
      return;
    } else if (password.isEmpty) {
      showCustomDialog(context, 'Error', 'Enter the Password');
      return;
    }

    try {
      final user = await APIService.fetchOneData(email, 'user', 'email', email);
      if (user == null) {
        // ignore: use_build_context_synchronously
        showCustomDialog(context, 'Error',
            'Email & Password are not Corrected. Please Enter the Corrected Email & Password');
      } else if (user['password'] == password) {
        CustomNavigationService.navigateToScreen(
          // ignore: use_build_context_synchronously
          context,
          screen: HomeScreen(
            email: email,
            name: user['name'],
            contactNumber: user['contactNumber'],
            password: password,
          ),
        );
        // ignore: use_build_context_synchronously
        showCustomDialog(context, 'Successful',
            'Log In Successful. Now You are Entered in Home Screen');
      } else {
        // ignore: use_build_context_synchronously
        showCustomDialog(context, 'Error',
            'Email & Password are not Corrected. Please Enter the Corrected Email & Password');
      }
    } catch (e) {
      setState(() {});
      // ignore: use_build_context_synchronously
      showCustomDialog(context, 'Error', 'Failed to login. Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const CustomAppBar(
        title: 'Log In',
        hasBackButton: false,
        actions: [],
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
                const CustomBox(title: 'Log In To Your Account'),
                const SizedBox(height: 40),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 20.0),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  obscureText: !_isPasswordVisible,
                  isPassword: true,
                  onChanged: (value) {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 40.0),
                CustomButton(
                  label: 'Log In',
                  onPressed: login,
                  color: Colors.red,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  label: 'Forget Password',
                  onPressed: () {
                    CustomNavigationService.navigateToScreen(
                      context,
                      screen: const ForgetPasswordScreen(),
                    );
                  },
                  color: Colors.orange,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  label: 'Don\'t have an account? Sign Up',
                  onPressed: () {
                    CustomNavigationService.navigateToScreen(
                      context,
                      screen: const SignupScreen(),
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

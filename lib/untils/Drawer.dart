// ignore_for_file: file_names

import '../../screen/other/HomeScreen.dart';

import '../screen/authentication/ChangePassword.dart';
import '../screen/other/AddDailyFinanceTransaction.dart';

import 'package:flutter/material.dart';
import '../screen/authentication/LoginScreen.dart';

import '../screen/other/AllCreditTransactionScreen.dart';
import '../screen/other/AllDebitTransactionScreen.dart';
import '../screen/other/AllTransactionScreen.dart';
import 'CustomBackgroundColor.dart';
import 'ListTitle.dart';
import 'ListText.dart';

Drawer buildDrawer(
  BuildContext context, {
  required String name,
  required String contactNumber,
  required String email,
  required String password,
}) {
  return Drawer(
    width: MediaQuery.of(context).size.width * 0.6,
    child: Container(
      decoration: buildBoxDecoration(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                constraints: BoxConstraints(
                  minHeight: 0,
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15),
                    ListTextWidget(
                      title: 'Welcome $name Profile',
                      color: Colors.yellowAccent,
                    ),
                    const SizedBox(height: 15),
                    ListTextWidget(
                      title: 'Contact Number: $contactNumber',
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 15),
                    ListTextWidget(
                      title: 'Email: $email',
                      color: Colors.black,
                    ),
                  ],
                ),
              );
            },
          ),
          ListTitleWidget(
              title: 'Dashboard',
              screen: HomeScreen(
                  email: email,
                  name: name,
                  contactNumber: contactNumber,
                  password: password),
              icon: const Icon(Icons.home)),
          ListTitleWidget(
              title: 'All Transaction',
              screen: AllTransactionScreen(
                  email: email,
                  name: name,
                  contactNumber: contactNumber,
                  password: password),
              icon: const Icon(Icons.list_alt)),
          ListTitleWidget(
              title: 'All Debit Transaction',
              screen: AllDebitTransactionScreen(
                  email: email,
                  name: name,
                  contactNumber: contactNumber,
                  password: password),
              icon: const Icon(Icons.credit_card)),
          ListTitleWidget(
              title: 'All Credit Transaction',
              screen: AllCreditTransactionScreen(
                  email: email,
                  name: name,
                  contactNumber: contactNumber,
                  password: password),
              icon: const Icon(Icons.credit_card)),
          ListTitleWidget(
              title: 'Add Transaction Details',
              screen: AddDailyFinanceTransactionScreen(
                  email: email,
                  name: name,
                  contactNumber: contactNumber,
                  password: password),
              icon: const Icon(Icons.description)),
          ListTitleWidget(
              title: 'Change Password',
              screen: ChangePasswordScreen(
                  email: email,
                  name: name,
                  contactNumber: contactNumber,
                  password: password),
              icon: const Icon(Icons.password)),
          const ListTitleWidget(
            title: 'Logout',
            screen: LoginScreen(),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    ),
  );
}

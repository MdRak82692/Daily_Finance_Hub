import 'package:flutter/material.dart';

import 'screen/authentication/LoginScreen.dart';

void main() {
  runApp(const DailyFinanceHub());
}

class DailyFinanceHub extends StatelessWidget {
  const DailyFinanceHub({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily Finance Hub',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen());
  }
}

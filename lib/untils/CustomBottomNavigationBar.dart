// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'CustomText.dart';
import '../screen/other/HomeScreen.dart';
import '../screen/other/AllTransactionScreen.dart';
import '../screen/other/AddDailyFinanceTransaction.dart';
import '../screen/other/AllCreditTransactionScreen.dart';
import '../screen/other/AllDebitTransactionScreen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final String email;
  final String name;
  final String contactNumber;
  final String password;
  final int selectedIndex;

  const CustomBottomNavigationBar({
    super.key,
    required this.email,
    required this.name,
    required this.contactNumber,
    required this.password,
    required this.selectedIndex,
  });

  @override
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              email: widget.email,
              name: widget.name,
              contactNumber: widget.contactNumber,
              password: widget.password,
            ),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllTransactionScreen(
              email: widget.email,
              name: widget.name,
              contactNumber: widget.contactNumber,
              password: widget.password,
            ),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddDailyFinanceTransactionScreen(
              email: widget.email,
              name: widget.name,
              contactNumber: widget.contactNumber,
              password: widget.password,
            ),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllDebitTransactionScreen(
              email: widget.email,
              name: widget.name,
              contactNumber: widget.contactNumber,
              password: widget.password,
            ),
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllCreditTransactionScreen(
              email: widget.email,
              name: widget.name,
              contactNumber: widget.contactNumber,
              password: widget.password,
            ),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF1A73E8),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt, color: Colors.black),
          label: 'All Transaction',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add, color: Colors.black),
          label: 'Add Transaction',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card, color: Colors.black),
          label: 'All Debit Transaction',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card, color: Colors.black),
          label: 'All Credit Transaction',
        ),
      ],
      currentIndex: selectedIndex,
      selectedLabelStyle: style(18, color: Colors.transparent),
      selectedItemColor: Colors.red,
      unselectedLabelStyle: style(14, color: Colors.transparent),
      unselectedItemColor: const Color(0xFF1A73E8),
      onTap: _onItemTapped,
    );
  }
}

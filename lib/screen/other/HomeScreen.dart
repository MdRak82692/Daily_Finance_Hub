// ignore_for_file: file_names

import 'package:daily_finance_hub/service/APIService.dart';
import 'package:flutter/material.dart';

import '../../service/MappinService.dart';
import '../../service/FetchDataSerice.dart';
import '../../service/NavigationService.dart';
import '../../service/StartAutoRefresh.dart';

import '../../table/AmountTable.dart';
import '../../table/BuildEmptyTable.dart';
import '../../table/BuildTransactionDate.dart';

import '../../untils/CustomAppBar.dart';
import '../../untils/CustomBackgroundColor.dart';
import '../../untils/CustomBuildDateTimeBox.dart';
import '../../untils/CustomDateTime.dart';
import '../../untils/CustomText.dart';
import '../../untils/Drawer.dart';
import '../../untils/CustomBottomNavigationBar.dart';

import '../authentication/LoginScreen.dart';
import '../../model/TransactionModel.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  final String name;
  final String contactNumber;
  final String password;

  const HomeScreen({
    super.key,
    required this.email,
    required this.name,
    required this.contactNumber,
    required this.password,
  });

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<TransactionModel> transactionList = [];
  String? searchText;
  bool isSearching = false;
  double previousDayBalance = 0.0;

  @override
  void initState() {
    super.initState();
    startAutoRefresh(() async {
      List<TransactionModel> data = await fetchTransactionData(
          widget.email, searchText, 'TransactionDetails');
      if (mounted) {
        setState(() {
          transactionList = data;
        });
      }
      return 'Done';
    });
    calculatePastYearBalanceFromServer();
  }

  @override
  void dispose() {
    stopAutoRefresh();
    super.dispose();
  }

  Future<void> calculatePastYearBalanceFromServer() async {
    double cumulativeBalance = 0.0;
    List<dynamic> data =
        await APIService.fetchData(widget.email, 'TransactionDetails');
    List<TransactionModel> transactionList =
        data.map((json) => TransactionModel.fromJson(json)).toList();

    for (int i = 1; i <= 36500; i++) {
      String targetDate =
          formatDate(DateTime.now().subtract(Duration(days: i)));
      double totalDebit = transactionList
          .where((transaction) =>
              transaction.status == 'Debit' &&
              formatDate(transaction.transactionDate) == targetDate)
          .fold(0.0, (sum, transaction) => sum + transaction.amount);
      double totalCredit = transactionList
          .where((transaction) =>
              transaction.status == 'Credit' &&
              formatDate(transaction.transactionDate) == targetDate)
          .fold(0.0, (sum, transaction) => sum + transaction.amount);
      double dailyBalance = totalDebit - totalCredit;
      cumulativeBalance += dailyBalance;
    }

    if (mounted) {
      setState(() {
        previousDayBalance = cumulativeBalance;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupedTransactionData = groupedTransactionByDate1(transactionList);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(
        title: 'Dashboard',
        hasBackButton: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () => CustomNavigationService.navigateToScreen(
              context,
              screen: const LoginScreen(),
            ),
          ),
        ],
        showSearch: true,
        centerTitle: false,
        showDrawerIcon: true,
        onSearch: (query) async {
          setState(() {
            searchText = query;
          });
          List<TransactionModel> data = await fetchTransactionData(
              widget.email, searchText, 'TransactionDetails');
          if (mounted) {
            setState(() {
              transactionList = data;
            });
          }
        },
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CustomBuildDateTimeBox(),
                const SizedBox(height: 20),
                buildTotalAmountTable1(
                  value: getTotalDebit2(transactionList, previousDayBalance)
                      .toStringAsFixed(0),
                  value1: getTotalCredit1(transactionList).toStringAsFixed(0),
                  value2: getBalance2(transactionList, previousDayBalance)
                      .toStringAsFixed(0),
                ),
                groupedTransactionData.isEmpty
                    ? buildEmptyTable1(
                        context,
                        'Transaction Date',
                        formatDate(DateTime.now()),
                        [],
                        '',
                        previousDayBalance,
                        widget.email,
                        widget.name,
                        widget.contactNumber,
                        widget.password,
                        searchText ?? '',
                        '',
                      )
                    : Column(
                        children: groupedTransactionData.entries.map(
                          (entry) {
                            return buildtransactionDateSection1(
                              context,
                              'Transaction Date',
                              formatDate(DateTime.now()),
                              transactionList
                                  .where((transaction) =>
                                      formatDate(transaction.transactionDate) ==
                                      entry.key)
                                  .toList(),
                              entry.key,
                              previousDayBalance,
                              widget.email,
                              widget.name,
                              widget.contactNumber,
                              widget.password,
                              searchText ?? '',
                              'TransactionDetails',
                            );
                          },
                        ).toList(),
                      ),
                if (groupedTransactionData.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Today\'s No Transaction List Available.',
                      textAlign: TextAlign.center,
                      style: style(22, color: Colors.black),
                    ),
                  ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        email: widget.email,
        name: widget.name,
        contactNumber: widget.contactNumber,
        password: widget.password,
        selectedIndex: 0,
      ),
    );
  }
}

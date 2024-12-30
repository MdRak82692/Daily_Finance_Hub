// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../service/MappinService.dart';
import '../../service/NavigationService.dart';
import '../../service/StartAutoRefresh.dart';
import '../../service/FetchDataSerice.dart';

import '../../table_debit/BuildEmptyTable.dart';
import '../../table_debit/BuildTransactionDate.dart';
import '../../table_debit/AmountTable.dart';

import '../../untils/CustomAppBar.dart';
import '../../untils/CustomBackgroundColor.dart';
import '../../untils/CustomBottomNavigationBar.dart';
import '../../untils/CustomText.dart';

import '../../untils/Drawer.dart';
import 'HomeScreen.dart';
import '../../model/TransactionModel.dart';

class AllDebitTransactionScreen extends StatefulWidget {
  final String email;
  final String name;
  final String contactNumber;
  final String password;

  const AllDebitTransactionScreen({
    super.key,
    required this.email,
    required this.name,
    required this.contactNumber,
    required this.password,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AllDebitTransactionScreenState createState() =>
      _AllDebitTransactionScreenState();
}

class _AllDebitTransactionScreenState extends State<AllDebitTransactionScreen> {
  List<TransactionModel> transactionList = [];
  String? searchText;
  bool isSearching = false;

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
  }

  @override
  void dispose() {
    stopAutoRefresh();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groupedTransactionData =
        groupedTransactionByDateAndDebit(transactionList);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar(
        title: 'All Debit Transaction',
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
        showSearch: true,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                buildTotalAmountTable(
                  value: getTotalDebit(transactionList).toStringAsFixed(0),
                  value1: getTotalCredit(transactionList).toStringAsFixed(0),
                  value2: getBalance(transactionList).toStringAsFixed(0),
                ),
                groupedTransactionData.isEmpty
                    ? buildEmptyTable('', [])
                    : Column(
                        children: groupedTransactionData.entries.map(
                          (entry) {
                            return buildtransactionDateSection(
                                entry.key, entry.value);
                          },
                        ).toList(),
                      ),
                if (transactionList.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'No Debit Transaction List Available.',
                      style: style(
                        22,
                        color: Colors.black,
                      ),
                    ),
                  ),
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
        selectedIndex: 3,
      ),
    );
  }
}

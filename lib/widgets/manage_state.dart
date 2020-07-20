import 'package:flutter/material.dart';
import '../model/transaction.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';

class TransactionStateManage extends StatefulWidget {
  @override
  _TransactionStateManageState createState() => _TransactionStateManageState();
}

class _TransactionStateManageState extends State<TransactionStateManage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: "t1", title: "New Shoes", amount: 69.99, date: DateTime.now()),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              child: Text("Chart"),
              color: Colors.blue,
              elevation: 5,
            ),
          ),
          NewTransaction(_addNewTransaction),
          TransactionList(_userTransactions),

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import './model/transaction.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(MaterialApp(
    title: "Personal Expenses",
    theme: ThemeData(
      primarySwatch: Colors.purple,
      accentColor: Colors.amber,
      errorColor: Colors.redAccent,
      fontFamily: 'Quicksand',
      appBarTheme: AppBarTheme(
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSens',
                fontSize: 21,
              ),
              subtitle1: TextStyle(
                fontFamily: 'OpenSens',
                fontSize: 15,
                color: Colors.black,
              ),
            ),
      ),
    ),
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: "t1",
      title: "New Shoes",
      amount: 10.01,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 20.01,
      date: DateTime(2020, 7, 20),
    ),
  ];

  //we only need to pass recent transactions in chart widget
  //so creating getter
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((anyVar) {
      return anyVar.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: selectedDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String txId) {
    setState(() {
      _userTransactions.removeWhere((anyVar) {
        /* if(anyVar.id==txId){
          return true;
        }
        return false;*/
        return anyVar.id == txId;
      });
    });
  }

  void _openTransactionWindow(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Expenses",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _openTransactionWindow(context);
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Chart(_recentTransactions),
          Column(
            children: <Widget>[
              TransactionList(_userTransactions, _deleteTransaction),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openTransactionWindow(context);
        },
        elevation: 20,
      ),
    );
  }
}

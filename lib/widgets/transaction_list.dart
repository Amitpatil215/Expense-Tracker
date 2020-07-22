import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> fetchedTransactionList;

  TransactionList(this.fetchedTransactionList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      //height: 300,
      child: fetchedTransactionList.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No Transaction!",
                  style: TextStyle(fontSize: 35),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: SizedBox(
                      height: 300,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ),
              ],
            )
          : ListView.builder(
              itemCount: fetchedTransactionList.length,
              itemBuilder: (anyContext, index) {
                return Card(
                  elevation: 20,
                  shadowColor: Colors.purple.shade200,
                  child: Row(
                    children: <Widget>[
                      //Amount Box
                      Container(
                        height: 50,
                        width:80,
                        margin: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 30,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(7),
                        child: FittedBox(

                          child: Text(
                            "₹ ${fetchedTransactionList[index].amount.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            fetchedTransactionList[index].title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd("en_US")
                                .add_jm()
                                .format(fetchedTransactionList[index].date),
                            style: Theme.of(context).textTheme.subtitle1,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

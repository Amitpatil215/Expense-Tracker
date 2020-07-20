import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> fetchedTransactionList;

  TransactionList(this.fetchedTransactionList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.8,
      //height: 300,
      child: fetchedTransactionList.isEmpty?
          Column(
           children: <Widget>[Text("No Transaction!",style: TextStyle(fontSize: 35),),
           Padding(
             padding:  EdgeInsets.only(top:15.0),
             child: SizedBox(
             height: 400
             ,child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover,)),
           ),
           ],
          )
          : ListView.builder(
        itemCount:fetchedTransactionList.length ,
        itemBuilder: (anyContext,index){
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "₹ ${fetchedTransactionList[index].amount.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
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
                      DateFormat.yMMMd("en_US").add_jm().format(fetchedTransactionList[index].date),
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

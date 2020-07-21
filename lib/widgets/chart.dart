import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  //getter
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      //subtracting by index gives us a past week as today-5=5th day from now
      final weekDay = DateTime.now().subtract(Duration(days: index),);

      double totalSum=0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      print( DateFormat.E().format(weekDay));
      print(totalSum);

      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      color: Colors.amber,
      child: Row(
        children: <Widget>[

        ],
      ),
    );
  }
}

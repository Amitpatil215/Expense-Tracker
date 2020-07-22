import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/chart_bar.dart';
import '../model/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  //getter for a require list of transactions
  List<Map<String, Object>> get groupedTransactionValues {

    return List.generate(7, (index) {
      //subtracting by index gives us a last week as today-5=5th day from now
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );


      double totalSum = 0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum
      };
    });
  }

  //getter amount we spent in a week
  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum, item){
          return sum + item['amount'] ;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 30,
      margin: EdgeInsets.all(20),
      color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ...groupedTransactionValues.map((anyVar) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label:anyVar['day'] ,
                spendingAmount:anyVar['amount'],
                spendingPctOfTotal:totalSpending== 0.0 ? 0.0 : (anyVar['amount'] as double)/totalSpending,

              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

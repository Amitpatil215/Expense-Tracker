import 'package:flutter/material.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';
class TransactionStateManage extends StatefulWidget {
  @override
  _TransactionStateManageState createState() => _TransactionStateManageState();
}

class _TransactionStateManageState extends State<TransactionStateManage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Card(
            child: Text("Chart"),
            color: Colors.blue,
            elevation: 5,
          ),
        ),
        NewTransaction(),
        TransactionList(),
      ],
    );
  }
}

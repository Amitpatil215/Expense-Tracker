import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//this must be stateful (even if we are not calling setState((){}) as it is more about data than UI )
// otherwise we are unable to input in TextField as our data gets lost
//this happens cause when flutter checks internally to stateless widgets and it finds data get changed then
// we loose our imputed data

class NewTransaction extends StatefulWidget {
  //for receiving data from outside to class we construct constructor here not in _NewTransactionState class as
  //it is constructed using createState()
  final Function addTransactionButton;

  NewTransaction(this.addTransactionButton);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitButtonPressed() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    //widget. is added to use method in state class (_NewTransactionState) from widget class (NewTransaction)
    //and of course it is only available in state class
    widget.addTransactionButton(
      enteredTitle,
      enteredAmount,
    );

    //for closing model sheet once we pressed "Add Transaction" button
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title",labelStyle: TextStyle(fontWeight: FontWeight.bold)),
              controller: titleController,
              onSubmitted: (_) => submitButtonPressed(),
              // (_):as onSubmitted passes a string as argument  but we don't wanna use that value it so use this  _
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount",labelStyle: TextStyle(fontWeight: FontWeight.bold)),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitButtonPressed(),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.amber.shade300
              ),
              child: FlatButton(
                onPressed: submitButtonPressed,
                child: Text("Add Transaction",style: TextStyle(color: Colors.black),),
                textColor: Colors.purple,
              ),
            )
          ],
        ),
      ),
    );
  }
}

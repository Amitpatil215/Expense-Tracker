import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitButtonPressed() {
    if (_amountController.text.isEmpty) {
      //if user haven't entered amount
      return;
    }
    final _enteredTitle = _titleController.text;
    final _enteredAmount = double.parse(_amountController.text);
    if (_enteredTitle.isEmpty || _enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    //widget. is added to use method in state class (_NewTransactionState) from widget class (NewTransaction)
    //and of course it is only available in state class
    widget.addTransactionButton(
      _enteredTitle,
      _enteredAmount,
      _selectedDate,
    );

    //for closing model sheet once we pressed "Add Transaction" button
    Navigator.of(context).pop();
  }

  //date picker IconButton
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDateValue) {
      //pickedDateValue is any Variable with is returned by future
      if (pickedDateValue == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDateValue;
        });
      }
    });
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
              decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold)),
              controller: _titleController,
              onSubmitted: (_) => _submitButtonPressed(),
              // (_):as onSubmitted passes a string as argument  but we don't wanna use that value it so use this  _
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Amount",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold)),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitButtonPressed(),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _selectedDate == null
                      ? "Choose a Date"
                      : DateFormat.yMd().format(_selectedDate),
                  style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.purple),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _presentDatePicker,
                  padding: EdgeInsets.all(20),
                  highlightColor: Colors.purple.shade200,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.amber.shade300),
              child: FlatButton(
                onPressed: _submitButtonPressed,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(color: Colors.black),
                ),
                textColor: Colors.purple,
              ),
            )
          ],
        ),
      ),
    );
  }
}

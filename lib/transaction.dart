import 'package:flutter/foundation.dart';

class Transaction {
  final String id; //unique identity for an transaction
  final String title; //For what purpose user spent money or description
  final double amount; //money user spent
  final DateTime date; //Date when transaction happened
  //all values are final : there value never changes once transaction is created

  //constructor with named arguments
  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
  //for using @required we import material package or foundation.dart(used here) as it is not available in dart
}

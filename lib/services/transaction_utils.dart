import 'package:expense_tracker/constants/hive_boxes.dart';
import 'package:expense_tracker/models/expense_transaction.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExpenseTransactionService{
  ExpenseTransactionService();

  void insertTransaction(ExpenseTransaction transaction){
     Box<ExpenseTransaction> dataBox = Hive.box<ExpenseTransaction>(HiveBoxes.expenses);
     dataBox.put(transaction.id, transaction);
  }
}
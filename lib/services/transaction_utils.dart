import 'package:expense_tracker/constants/hive_boxes.dart';
import 'package:expense_tracker/models/expense_transaction.dart';
import 'package:expense_tracker/services/transaction_summary_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExpenseTransactionService{
  ExpenseTransactionService();

  void insertTransaction(ExpenseTransaction transaction){
     TransactionSummaryService summaryService = TransactionSummaryService();
     Box<ExpenseTransaction> dataBox = Hive.box<ExpenseTransaction>(HiveBoxes.expenses);
     dataBox.put(transaction.id, transaction);
     summaryService.updateTransactionSummary(amount: transaction.amount, isExpense: transaction.isExpense);
  }
}
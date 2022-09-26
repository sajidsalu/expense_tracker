import 'package:expense_tracker/constants/hive_boxes.dart';
import 'package:expense_tracker/models/transaction_summary.dart';
import 'package:expense_tracker/services/Utils/parse_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TransactionSummaryService{

  static void openTransactionBox() async{
    await Hive.openBox<TransactionSummary>(HiveBoxes.transactionSummary);
  }
  static void insertTransactionSummaryService() async{
    await Hive.openBox<TransactionSummary>(HiveBoxes.transactionSummary);
    Box<TransactionSummary> dataBox = Hive.box<TransactionSummary>(HiveBoxes.transactionSummary);
    dataBox.put(HiveBoxes.transactionSummary, TransactionSummary.reset());
  }

  void updateTransactionSummary({required double amount, required bool isExpense}) async{
    //Hive.openBox<TransactionSummary>(HiveBoxes.transactionSummary);
    Box<TransactionSummary> dataBox = Hive.box<TransactionSummary>(HiveBoxes.transactionSummary);
    var currentExpense = dataBox.get(HiveBoxes.transactionSummary);
    if(isExpense){
      currentExpense?.income = ParsingUtils.doubleFrom(currentExpense.income) + amount;
    }else{
      currentExpense?.expense = ParsingUtils.doubleFrom(currentExpense.expense) + amount;
    }
    dataBox.put(HiveBoxes.transactionSummary, currentExpense!);

  }

  Future<TransactionSummary?> getTransactionSummary() async{
    //Hive.openBox<TransactionSummary>(HiveBoxes.transactionSummary);
    Box<TransactionSummary> dataBox = Hive.box<TransactionSummary>(HiveBoxes.transactionSummary);
    var currentSummary = dataBox.get(HiveBoxes.transactionSummary);
    return currentSummary;

  }
}
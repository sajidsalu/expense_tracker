import 'dart:convert';

import 'package:expense_tracker/constants/hive_boxes.dart';
import 'package:expense_tracker/models/transaction_categories.dart';
import 'package:expense_tracker/modules/home/transaction-card.dart';
import 'package:expense_tracker/services/Utils/parse_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TransactionCategoryService{
  TransactionCategoryService();

 static void insertAllTransactionCategories()async {
   await Hive.openBox<TransactionCategories>(HiveBoxes.transactionCategories);
    Box<TransactionCategories> dataBox = Hive.box<TransactionCategories>(HiveBoxes.transactionCategories);
     await dataBox.put(1,TransactionCategories.food());
     await dataBox.put(2,TransactionCategories.entertainment());
     await dataBox.put(3,TransactionCategories.recharge());
     await dataBox.put(4,TransactionCategories.bills());
     await dataBox.put(5,TransactionCategories.homeRent());
     await dataBox.put(6,TransactionCategories.shopping());
     await dataBox.put(7,TransactionCategories.salary());
     await dataBox.put(8,TransactionCategories.miscellaneous());
     dataBox.close();
  }

  Future<List<TransactionCategories>> getAllTransactionCategories() async {
    await Hive.openBox<TransactionCategories>(HiveBoxes.transactionCategories);
    Box<TransactionCategories> dataBox = Hive.box<TransactionCategories>(HiveBoxes.transactionCategories);
    var catt= dataBox.values.toList();
    print("items are ${catt}");
    dataBox.close();
    return catt;
  }
}
import 'package:expense_tracker/constants/hive_boxes.dart';
import 'package:expense_tracker/models/expense_transaction.dart';
import 'package:expense_tracker/models/transaction_categories.dart';
import 'package:expense_tracker/models/transaction_summary.dart';
import 'package:expense_tracker/modules/home/home.dart';
import 'package:expense_tracker/modules/login/login.dart';
import 'package:expense_tracker/services/transaction_category.dart';
import 'package:expense_tracker/services/transaction_summary_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  final summaryBoxExists = await Hive.boxExists(HiveBoxes.transactionSummary,path: document.path);
  Hive.init(document.path);
  Hive.registerAdapter(ExpenseTransactionAdapter());
  Hive.registerAdapter(TransactionSummaryAdapter());
  Hive.registerAdapter(TransactionCategoriesAdapter());
  // Hive ..init(document.path)
  //   ..registerAdapter(ExpenseTransactionAdapter())
  //   ..registerAdapter(TransactionCategoriesAdapter());
  await Hive.openBox<ExpenseTransaction>(HiveBoxes.expenses);
  await Hive.openBox<TransactionSummary>(HiveBoxes.transactionSummary);
  TransactionCategoryService.insertAllTransactionCategories();
  if(!summaryBoxExists)
    TransactionSummaryService.insertTransactionSummaryService();
  await Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  LoginScreen(),
    );
  }
}

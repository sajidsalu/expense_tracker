import 'package:expense_tracker/constants/hive_boxes.dart';
import 'package:expense_tracker/models/expense_transaction.dart';
import 'package:expense_tracker/models/transaction_categories.dart';
import 'package:expense_tracker/modules/home/home.dart';
import 'package:expense_tracker/services/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // await Hive.openBox(HiveBoxes.expenses);
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(ExpenseTransactionAdapter());
  Hive.registerAdapter(TransactionCategoriesAdapter());
  // Hive ..init(document.path)
  //   ..registerAdapter(ExpenseTransactionAdapter())
  //   ..registerAdapter(TransactionCategoriesAdapter());
  await Hive.openBox<ExpenseTransaction>(HiveBoxes.expenses);
  TransactionCategoryService.insertAllTransactionCategories();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  HomeScreen(),
    );
  }
}

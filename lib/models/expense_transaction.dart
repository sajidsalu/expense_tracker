import 'package:expense_tracker/services/types/transaction_type.dart';
import 'package:hive/hive.dart';
part 'expense_transaction.g.dart';

@HiveType(typeId: 0)
class ExpenseTransaction extends HiveObject{
  @HiveField(0)
  final String category;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final double amount;
  @HiveField(4)
  final String type;
  @HiveField(5)
  final String id;
  @HiveField(6)
  final int categoryId;
  @HiveField(7)
  final bool isExpense;

  ExpenseTransaction({required this.category, required this.categoryId, required this.description, required this.date, required this.amount, required this.type, required this.id, required this.isExpense});

}
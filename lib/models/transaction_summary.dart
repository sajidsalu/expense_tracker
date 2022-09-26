import 'package:expense_tracker/services/Utils/parse_utils.dart';
import 'package:expense_tracker/services/types/transaction_type.dart';
import 'package:hive/hive.dart';
part 'transaction_summary.g.dart';

@HiveType(typeId: 3)
class TransactionSummary extends HiveObject{
  @HiveField(0)
  late double expense;
  @HiveField(1)
  late double income;

  TransactionSummary({required this.expense, required this.income});

  TransactionSummary.fromJson(Map<String, dynamic> json) {
    expense = ParsingUtils.doubleFrom(json['expense']);
    income = ParsingUtils.doubleFrom(json['income']);
  }

  Map<String, dynamic> toJson() {
    return {
      'category': expense,
      'categoryId': income,
    };
  }

  @override
  String toString() {
    return '{expsense: $expense,income: $income}';
  }

  TransactionSummary.reset({
    this.expense=0.00,
    this.income=0.00,
  });

}
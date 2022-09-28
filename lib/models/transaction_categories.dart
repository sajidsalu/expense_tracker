import 'package:expense_tracker/services/Utils/parse_utils.dart';
import 'package:expense_tracker/services/types/transaction_type.dart';
import 'package:hive/hive.dart';
part 'transaction_categories.g.dart';

@HiveType(typeId: 1)
class TransactionCategories extends HiveObject{
  @HiveField(0)
   late int id;
  @HiveField(1)
   late String category;
  @HiveField(2)
   late String imagePath;

  TransactionCategories({required this.id, required this.category, required this.imagePath});

  TransactionCategories.food({
    this.imagePath="assets/images/food.png",
    this.category="Food",
    this.id= 1,
  });

  TransactionCategories.entertainment({
    this.imagePath="assets/images/entertainment.png",
    this.category="Entertainment",
    this.id= 2,
  });

  TransactionCategories.recharge({
    this.imagePath="assets/images/recharge.png",
    this.category="Recharge",
    this.id= 3,
  });

  TransactionCategories.bills({
    this.imagePath="assets/images/bill.png",
    this.category="Bills",
    this.id= 4,
  });

  TransactionCategories.homeRent({
    this.imagePath="assets/images/house-rent.png",
    this.category="Home Rent",
    this.id= 5,
  });

  TransactionCategories.salary({
    this.imagePath="assets/images/salary.png",
    this.category="Salary",
    this.id= 7,
  });

  TransactionCategories.shopping({
    this.imagePath="assets/images/shopping.png",
    this.category="Shopping",
    this.id= 6,
  });

  TransactionCategories.miscellaneous({
    this.imagePath="assets/images/miscellaneous.png",
    this.category="Others",
    this.id= 8,
  });

  TransactionCategories.fromJson(Map<String, dynamic> json) {
    category = ParsingUtils.stringFrom(json['category']);
    id = ParsingUtils.intFrom(json['categoryId']);
    imagePath = ParsingUtils.stringFrom(json['path']);

  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'categoryId': id,
      'path': imagePath,
    };
  }

  @override
  String toString() {
    return '{category: $category,categoryId: $id, path: $imagePath}';
  }


}
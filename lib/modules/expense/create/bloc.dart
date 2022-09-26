import 'package:expense_tracker/models/transaction_categories.dart';
import 'package:expense_tracker/services/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CreateExpenseBloc {

  CreateExpenseBloc(){
    loadCategories();
  }
  TransactionCategoryService categoryService = TransactionCategoryService();

  final _isExpense = BehaviorSubject<bool>.seeded(true);
  final _categoriesList = BehaviorSubject<List<TransactionCategories>>.seeded([]);

  get transactionCategoryList => _categoriesList.value;

  Stream<bool> get isExpenseStream => _isExpense.stream;
  Stream<List<TransactionCategories>> get categories => _categoriesList.stream;

  get isExpense => _isExpense.value;

  void loadCategories()async{
   final categories =  await categoryService.getAllTransactionCategories();
   _categoriesList.sink.add(categories);
  }

  void setIsExpense(bool isExpense){
    _isExpense.sink.add(isExpense);
  }


}
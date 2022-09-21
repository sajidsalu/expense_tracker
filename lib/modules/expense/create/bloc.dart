import 'package:expense_tracker/models/transaction_categories.dart';
import 'package:expense_tracker/services/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CreateExpenseBloc {

  CreateExpenseBloc(){
    loadCategories();
  }
  TransactionCategoryService categoryService = TransactionCategoryService();

  final _reqInProgress = BehaviorSubject<bool>.seeded(false);
  final _categoriesList = BehaviorSubject<List<TransactionCategories>>.seeded([]);

  get transactionCategoryList => _categoriesList.value;

  Stream<bool> get reqInProgress => _reqInProgress.stream;
  Stream<List<TransactionCategories>> get categories => _categoriesList.stream;

  void loadCategories()async{
   final categories =  await categoryService.getAllTransactionCategories();
   _categoriesList.sink.add(categories);
  }


}
import 'package:expense_tracker/models/transaction_summary.dart';
import 'package:expense_tracker/services/transaction_summary_service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class DashboardBloc{
  TransactionSummaryService service = TransactionSummaryService();
  final _data = BehaviorSubject<TransactionSummary>.seeded(TransactionSummary.reset());
  Stream<TransactionSummary> get summary => _data.stream;


  DashboardBloc(){
   getTransactionSummary();
  }

  void getTransactionSummary()async{
    var data = await service.getTransactionSummary();
    print("summary data is ${data}");
  }
  void setTransactionSummaryData(TransactionSummary data){
    _data.sink.add(data);
  }
}
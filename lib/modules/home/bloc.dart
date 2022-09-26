import 'package:expense_tracker/models/transaction_summary.dart';
import 'package:expense_tracker/services/transaction_summary_service.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {

  TransactionSummaryService summaryService = TransactionSummaryService();

  final _reqInProgress = BehaviorSubject<bool>.seeded(false);
  final _summary = BehaviorSubject<TransactionSummary>.seeded(TransactionSummary.reset());

  get summaryValue => _summary.value;

  Stream<bool> get reqInProgress => _reqInProgress.stream;
  Stream<TransactionSummary> get summary => _summary.stream;

  void getTransactionSummary(){
     TransactionSummary summary = summaryService.getTransactionSummary() as TransactionSummary;
    _summary.sink.add(summary);
  }

}
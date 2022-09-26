import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/constants/hive_boxes.dart';
import 'package:expense_tracker/constants/styles.dart';
import 'package:expense_tracker/models/transaction_summary.dart';
import 'package:expense_tracker/modules/home/bloc.dart';
import 'package:expense_tracker/services/Utils/parse_utils.dart';
import 'package:expense_tracker/services/transaction_summary_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DashboardCard extends StatefulWidget {
  const DashboardCard({Key? key}) : super(key: key);

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {

  HomeBloc _bloc = HomeBloc();

  late Box<TransactionSummary> dataBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataBox = Hive.box<TransactionSummary>(HiveBoxes.transactionSummary);

  }
  @override
  Widget build(BuildContext context) {
    return Container(
          height: 150,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AppColors.primaryBlue,
                  AppColors.primaryRed,
                  AppColors.primaryViolet,
                ],
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder(
              valueListenable: dataBox.listenable(),
              builder: (context, Box<TransactionSummary> items, _){
                final data = items.get(HiveBoxes.transactionSummary);
                print("dashboard data $data");
                var summary = data;
                var newBalance = ParsingUtils.doubleFrom(summary?.income) - ParsingUtils.doubleFrom(summary?.expense);
                var totalExpense = ParsingUtils.doubleFrom(summary?.expense);
                var totalIncome = ParsingUtils.doubleFrom(summary?.income);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Text("Total Balance",style: TextStyles.h5),
                    Text("\$${newBalance}",style: TextStyles.h1),
                    Padding(
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Income",style: TextStyle(color: AppColors.white),),
                              Text("\$${totalIncome}",style: TextStyle(color: AppColors.white, fontSize: 18),),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Expense",style: TextStyle(color: AppColors.white),),
                              Text("\$${totalExpense}",style: TextStyle(color: AppColors.white,fontSize: 18),),
                            ],
                          )
                        ],
                      ),
                    )
                  ] ,
                );
              }
            ),
          ),
        );
  }
}

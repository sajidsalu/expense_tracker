import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/constants/hive_boxes.dart';
import 'package:expense_tracker/constants/styles.dart';
import 'package:expense_tracker/models/expense_transaction.dart';
import 'package:expense_tracker/models/transaction_categories.dart';
import 'package:expense_tracker/modules/expense/create/create_expense.dart';
import 'package:expense_tracker/modules/home/dashboard_card.dart';
import 'package:expense_tracker/modules/home/transaction-card.dart';
import 'package:expense_tracker/services/transaction_category.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<ExpenseTransaction> dataBox;
  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ExpenseTransaction>(HiveBoxes.expenses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:  FloatingActionButton(
        child: Container(
          width: 160,
          height: 160,
          child: Icon(
            Icons.add,
            size: 40,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                AppColors.primaryBlue,
                AppColors.primaryRed,
                AppColors.primaryViolet,])
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateExpense(),
            ),
          );
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/user-avatar.png',height: 50,width: 50,),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Welcome"),
                            Text("John Doe", style: TextStyles.h1Dark,),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10,),
                Container(
                  color: AppColors.backgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: DashboardCard(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Transactions", style: TextStyles.h1Dark,),
                          Text("View All", style: TextStyles.h6,),
                        ],
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: dataBox.listenable(),
                  builder: (context, Box<ExpenseTransaction> items, _){
                    List<String> keys= items.keys.cast<String>().toList();
                    if(keys.length ==0) return Text("");
                    return ListView.separated(
                      separatorBuilder: (_, index) => Divider(),
                      itemCount: keys.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder:(_, index){
                        final String key = keys[index];
                        final ExpenseTransaction data =  items.get(key)!;
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.blueGrey[200],
                          child: TransactionCardItem(type: data.categoryId,
                              transactionAmount: data.amount,
                              transactionDate: data.date.toString(),
                              isExpense:data.isExpense,
                              description: data.description,
                          ),
                        );
                      },

                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


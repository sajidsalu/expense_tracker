import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/constants/styles.dart';
import 'package:expense_tracker/modules/expense/create/create_expense.dart';
import 'package:expense_tracker/modules/home/dashboard_card.dart';
import 'package:expense_tracker/modules/home/transaction-card.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                      children: [
                        Expanded(
                          child: DashboardCard(),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Transactions", style: TextStyles.h1Dark,),
                        Text("View All", style: TextStyles.h6,),
                      ],
                    ),
                    SizedBox(height: 30,),
                    TransactionCardItem(type: TransactionType.food, transactionAmount: 430.00, transactionDate: "today"),
                    SizedBox(height: 30,),
                    TransactionCardItem(type: TransactionType.entertainment, transactionAmount: 130.00, transactionDate: "today"),
                    SizedBox(height: 30,),
                    TransactionCardItem(type: TransactionType.homeRent, transactionAmount: 13000.00, transactionDate: "today"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


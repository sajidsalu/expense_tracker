import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/constants/hive_boxes.dart';
import 'package:expense_tracker/constants/styles.dart';
import 'package:expense_tracker/models/expense_transaction.dart';
import 'package:expense_tracker/models/transaction_categories.dart';
import 'package:expense_tracker/modules/expense/create/create_expense.dart';
import 'package:expense_tracker/modules/expense/list/expense_list.dart';
import 'package:expense_tracker/modules/home/dashboard/dashboard_card.dart';
import 'package:expense_tracker/modules/home/transaction-card.dart';
import 'package:expense_tracker/modules/login/login.dart';
import 'package:expense_tracker/services/Utils/authentication.dart';
import 'package:expense_tracker/services/data_manager.dart';
import 'package:expense_tracker/services/transaction_category.dart';
import 'package:expense_tracker/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:expense_tracker/widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<ExpenseTransaction> dataBox;
  String username = "Sajid";

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box<ExpenseTransaction>(HiveBoxes.expenses);
    print("logged in user $username");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: AppDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  FloatingActionButton(
        child: Container(
          width: 160,
          height: 160,
          child: const Icon(
            Icons.add,
            size: 40,
          ),
          decoration: const BoxDecoration(
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
      bottomNavigationBar: BottomAppBar( //bottom navigation bar on scaffold
        color:Colors.redAccent,
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin: 5, //notche margin between floating button and bottom appbar
        child: Row( //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: Icon(Icons.list_outlined, color: Colors.white,), onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ExpenseListingScreen()));
            },),
            IconButton(icon: Icon(Icons.bar_chart, color: Colors.white,), onPressed: () {},),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.backgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
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
                          Text("Recent Transactions", style: TextStyles.h1Dark,),
                          OutlinedButton(onPressed: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=> ExpenseListingScreen()),
                            );
                          }, child: Text("View All", style: TextStyles.h6,)),
                        ],
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: dataBox.listenable(),
                  builder: (context, Box<ExpenseTransaction> items, _){
                    List<String> keys= items.keys.cast<String>().toList();
                    if(keys.length ==0) {
                      return Column(
                        children:[ Container(
                            alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(top: 10.0),
                          height: 350,
                          color: AppColors.white,
                          child:
                          Center(child:Image.asset("assets/images/no-data.jpg",fit: BoxFit.fill,))),
                          Container(
                              alignment: Alignment.bottomCenter,
                              child: Text("No Transactions...",style: TextStyles.h5lightGrey,)),
                    ]
                      );
                    }
                    return ListView.separated(
                      separatorBuilder: (_, index) => Divider(height: 0, color: Colors.transparent,),
                      itemCount: 5,
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
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 0),
              child:Text("Expense Tracker",style: TextStyle(color: Colors.white),)),
        ],
      ),
    );
  }
}


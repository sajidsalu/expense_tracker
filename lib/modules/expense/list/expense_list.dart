import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/constants/hive_boxes.dart';
import 'package:expense_tracker/constants/styles.dart';
import 'package:expense_tracker/models/expense_transaction.dart';
import 'package:expense_tracker/modules/home/transaction-card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExpenseListingScreen extends StatefulWidget {
  const ExpenseListingScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseListingScreen> createState() => _ExpenseListingScreenState();
}

class _ExpenseListingScreenState extends State<ExpenseListingScreen> {

  late Box<ExpenseTransaction> dataBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataBox = Hive.box<ExpenseTransaction>(HiveBoxes.expenses);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: SingleChildScrollView(
         child:Container(
           padding: EdgeInsets.all(10),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text("Transaction History",style: TextStyles.h1Dark,),
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

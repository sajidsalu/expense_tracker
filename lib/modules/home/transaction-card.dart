import 'package:expense_tracker/constants/styles.dart';
import 'package:flutter/material.dart';

class TransactionCategory{
  static const int food = 1;
  static const int entertainment = 2;
  static const int recharge = 3;
  static const int otherBills = 4;
  static const int homeRent = 5;
  static const int shopping = 6;
  static const int salary = 7;
  static const int miscellaneous = 8;
}
class TransactionCardItem extends StatefulWidget {
  int transactionType= TransactionCategory.food;
  double amount = 0;
  String date ="";
  bool isExpenseEntry=true;
  String note ="";

  TransactionCardItem({Key? key, required int type,required double transactionAmount,required String transactionDate, required bool isExpense, required String description}) : super(key: key){
    amount = transactionAmount;
    date = transactionDate;
    transactionType = type;
    isExpenseEntry = isExpense;
    note = description;
  }

  @override
  State<TransactionCardItem> createState() => _TransactionCardItemState();
}

class _TransactionCardItemState extends State<TransactionCardItem> {
  var image ="assets/images/food.png";
  var transaction= "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    print("transaction type ${widget.transactionType}");
    switch(widget.transactionType){
      case TransactionCategory.food : {
        image="assets/images/food.png";
        transaction = "Food";
        break;
      }
      case TransactionCategory.entertainment : {
        image="assets/images/entertainment.png";
        transaction = "Entertainment";
        break;
      }
      case TransactionCategory.homeRent : {
        image="assets/images/house-rent.png";
        transaction = "Rent";
        break;
      }
      case TransactionCategory.recharge : {
        image="assets/images/recharge.png";
        transaction = "Recharge";
        break;
      }
      case TransactionCategory.otherBills : {
        image="assets/images/bill.png";
        transaction = "Bills";
        break;
      }
      case TransactionCategory.shopping : {
        image="assets/images/shopping.png";
        transaction = "Shopping";
        break;
      }
      case TransactionCategory.salary : {
        image="assets/images/salary.png";
        transaction = "Salary";
        break;
      }
      case TransactionCategory.miscellaneous : {
      image="assets/images/miscellaneous.png";
      transaction = "Other";
      break;
    }
    }
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: Shadows.universal,
        borderRadius: Corners.mdBorder,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(image,height: 50,width: 50,),
              SizedBox(width: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaction,style: TextStyles.h3,),
                  SizedBox(height: 5,),
                  SizedBox(
                    width: 150,
                    child: Text(widget.note,  maxLines:1, style: TextStyles.h5lightGrey, overflow: TextOverflow.ellipsis,),
                  )
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("${widget.isExpenseEntry?"-":"+"}\$${widget.amount}",style: TextStyle(fontWeight: FontWeight.w600),),
              SizedBox(height: 5,),
              Text("${widget.date}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: FontSizes.s11),),
            ],
          )
        ],
      ),
    );
  }
}

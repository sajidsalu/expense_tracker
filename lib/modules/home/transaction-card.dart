import 'package:expense_tracker/constants/styles.dart';
import 'package:flutter/material.dart';

enum TransactionType{
  food,
  entertainment,
  recharge,
  homeRent,
  otherBills,
}
class TransactionCardItem extends StatefulWidget {
  TransactionType transactionType= TransactionType.food;
  double amount = 0;
  String date ="";

  TransactionCardItem({Key? key, required TransactionType type,required double transactionAmount,required String transactionDate}) : super(key: key){
    amount = transactionAmount;
    date = transactionDate;
    transactionType = type;
  }

  @override
  State<TransactionCardItem> createState() => _TransactionCardItemState();
}

class _TransactionCardItemState extends State<TransactionCardItem> {
  var image ="assets/images/";
  var transaction= "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch(widget.transactionType){
      case TransactionType.food : {
        image="assets/images/food.png";
        transaction = "Food";
        break;
      }
      case TransactionType.entertainment : {
        image="assets/images/entertainment.png";
        transaction = "Entertainment";
        break;
      }
      case TransactionType.homeRent : {
        image="assets/images/house-rent.png";
        transaction = "Rent";
        break;
      }
      case TransactionType.recharge : {
        image="assets/images/recharge.png";
        transaction = "Recharge";
        break;
      }
      case TransactionType.otherBills : {
        image="assets/images/bill.png";
        transaction = "Bills";
        break;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
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
              Text(transaction,style: TextStyles.h3,),
            ],
          ),
          Column(
            children: [
              Text("-\$${widget.amount}"),
              Text("${widget.date}"),
            ],
          )
        ],
      ),
    );
  }
}
